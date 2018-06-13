package com {
	import com.giveawaytool.meta.MetaIRCConnection;
	import com.lachhh.io.Callback;
	import com.lachhh.io.CallbackGroup;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.Timer;
	
	/*
		Simple IRC Bot
	
		There are a few important constants at the very beginning - I've tried to comment them well
	
		Here are the main methods to communicate with the server
		
		Say(string) - adds string to the queue of messages to send to IRC server
		SayNoDelay(string) - immediately sends string to server, no queue used
		SayToChannel(string) - sends message to chat. Auto-adds all the PRIVMSG and #channel info to string
		
		OnRecieveMessage() - grabs socket data to string, passes data to HandleMessage().
		HandleMessage(string) - probably the most important bit of the class. This parses the server messages
		
		LogInToChat() - shakes hands with the server and logs you into the channel specified
		
		Then there are a few bookeeping methods and variables
		- OnMessageDelayTimer() - pops off queued messages and sends them, IF we haven't sent too many
		- OnMessageCapResetTimer() - just resets the messagesSent variable
	*/
	
	public class SimpleIRCBot extends MovieClip{
		
		// standard message limit is 20 messages in 30 seconds. 
		// I've set it a tad conservatively just to make sure we dont get locked out.
		// moderators have a message limit of 100. Change message limit if the bot is a moderator!
		private const MESSAGE_LIMIT:int = 15;
		private const MESSAGE_TIME_LIMIT:Number = 30 * 1000;
		
		// time between sending queued messages
		private const MESSAGE_DELAY:Number = 1 * 1000;
		
		// your oauth token. needs the 'oauth:' bit at the very start
		//private const OATHTOKEN:String = VersionInfoDONTSTREAMTHIS.IRC_AUTH;
		
		// should be no need to change the server. I guess this can connect to different IRC servers
		private const SERVER:String = "irc.twitch.tv"; //"irc.twitch.tv"
		
		private var sock : Socket;
		public var metaIRCConnection : MetaIRCConnection;
		
		private var messageCapResetTimer:Timer = new Timer(MESSAGE_TIME_LIMIT);
		private var messageDelayTimer:Timer = new Timer(MESSAGE_DELAY);
		
		private var messagesSent:int = 0;
		private var messageQueue:Array = new Array();
		
		public var callbackMsgReceived:CallbackGroup ;
		public var callbackOnConnected:Callback ;
		public var callbackOnFailed:Callback ;
		public var lastMsgReceived:MetaIRCMessage;
		private var _connected:Boolean = false;
		

		public function SimpleIRCBot(metaIRC:MetaIRCConnection) { // lachhhandfriends
			metaIRCConnection = metaIRC;
			
			callbackMsgReceived = new CallbackGroup();
			sock = new Socket();
			sock.addEventListener(ProgressEvent.SOCKET_DATA, this.OnRecieveMessage);
			sock.addEventListener(Event.CONNECT, this.OnConnected);
			sock.addEventListener(Event.CLOSE, this.OnClosedConnection);
			sock.addEventListener(IOErrorEvent.IO_ERROR, this.OnIOError);
			sock.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.OnSecurityError); // false, 0, true);
			
			messageCapResetTimer.addEventListener(TimerEvent.TIMER, OnMessageCapResetTimer);
			messageDelayTimer.addEventListener(TimerEvent.TIMER, OnMessageDelayTimer);
			
			messageCapResetTimer.start();
			messageDelayTimer.start();
		}
		
		public function Connect():void{
			trace("connecting");
			try{
				sock.connect(SERVER, 6667);
			}
			catch(error:Error){
				disconnect();
			}
		}
		
		public function OnConnected(event:Event):void{
			LogInToChat();

		}
		
		public function LogInToChat():void{
			trace("logging in");
			SayNoDelay("USER " + metaIRCConnection.userName);
			SayNoDelay("PASS " + metaIRCConnection.auth);
			SayNoDelay("NICK " + metaIRCConnection.userName);
			SayNoDelay("JOIN #" + metaIRCConnection.channelName);
			SayNoDelay("CAP REQ :twitch.tv/tags twitch.tv/commands twitch.tv/membership");
			//SayToChannel("AS3 bot reporting for duty.");
		}
		
		public function SayNoDelay(msg:String):void {
			trace(msg);
			messagesSent++;
			sock.writeUTFBytes(msg + '\n');
			sock.flush();
		}
		
		public function SayToChannel(msg:String):void{
			Say("PRIVMSG #" + metaIRCConnection.channelName + " :" + msg);
		}
		
		public function PingReply(msg:String = "tmi.twitch.tv"):void{
			SayNoDelay("PONG " + msg);
		}
		
		public function Say(msg:String):void {
			messageQueue.push(msg);
		}
		
		public function OnMessageCapResetTimer(event:TimerEvent):void {
			trace("resetting message count...");
			messagesSent = 0;
		}
		
		public function OnMessageDelayTimer(event:TimerEvent):void {
			if(messageQueue.length > 0 && messagesSent < MESSAGE_LIMIT){
				SayNoDelay(messageQueue.shift());
			}
			else{
				if(messageQueue.length > 0){
					trace("message cap reached");
				}
			}
		}
		
		public function OnRecieveMessage(event:ProgressEvent):void{
			var str:String = sock.readUTFBytes(sock.bytesAvailable);
			
			var messages:Array = str.split("\n");
			
			var i:int;
			for(i = 0; i < 5; i++){
				if(messages[i] == null){continue;}
				trace(messages[i]);
				HandleMessage(messages[i]);
			}
			

		}
		
		public function HandleMessage(msg:String):void{
			
			// reply to ping-pong messages immediately. heartbeat messages from the server.
			if(MetaIRCMessage.isErrorLoggingMsg(msg)) {
				_connected = false;
				if(callbackOnFailed) callbackOnFailed.call();
				callbackOnFailed = null;
			}
			
			if(!_connected && MetaIRCMessage.isLoggedSuccess(msg)) {
				_connected = true;
				if(callbackOnConnected) callbackOnConnected.call();
				callbackOnConnected = null;
			}
			
			if(MetaIRCMessage.isPing(msg)){
				PingReply();
				return;
			}
			
			lastMsgReceived = MetaIRCMessage.createFromRawData(msg);
			if (callbackMsgReceived) callbackMsgReceived.call();
		}
		
		public function disconnect():void {
			try {
				sock.close();
			} catch (e:Error) {
				
			}
			_connected = false;
		}
		
		public function TextContains( text:String, substr:String ):Boolean{
			return (text.indexOf(substr) >= 0);
		}
		
		public function OnIOError(event:IOErrorEvent):void {
			triggerError("SimpleIRCBot : IO ERROR!" + "\n" + event);
			disconnect();	
		}

		public function OnSecurityError(event : SecurityErrorEvent) : void {
			triggerError("SimpleIRCBot : Security Error!" + "\n" + event);
			disconnect();
		}

		public function OnClosedConnection(event : Event) : void {
			triggerError("SimpleIRCBot : Closed Connection"+ "\n" + event);
			disconnect();
		}
		
		private function triggerError(msg:String):void {
			trace(msg);
			disconnect();
			if(callbackOnFailed) callbackOnFailed.call();
			callbackOnFailed = null;
		}

		public function isConnected() : Boolean {
			return _connected;
		}

	}
	
}
