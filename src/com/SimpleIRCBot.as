package com {
	import com.lachhh.io.CallbackGroup;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;

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
		const MESSAGE_LIMIT:int = 15;
		const MESSAGE_TIME_LIMIT:Number = 30 * 1000;
		
		// time between sending queued messages
		const MESSAGE_DELAY:Number = 1 * 1000;
		
		// your oauth token. needs the 'oauth:' bit at the very start
		const OATHTOKEN:String = VersionInfoDONTSTREAMTHIS.IRC_AUTH;
		
		// should be no need to change the server. I guess this can connect to different IRC servers
		const SERVER:String = "irc.twitch.tv"; //"irc.twitch.tv"
		
		var sock:Socket;
		var user:String;
		var channel:String;
		
		var messageCapResetTimer:Timer = new Timer(MESSAGE_TIME_LIMIT);
		var messageDelayTimer:Timer = new Timer(MESSAGE_DELAY);
		
		var messagesSent:int = 0;
		var messageQueue:Array = new Array();
		
		public var callbackMsgReceived:CallbackGroup ;
		public var lastMsgReceived:MetaIRCMessage;

		public function SimpleIRCBot(userName:String = "lachhhandfriends", channel:String = "lachhhandfriends") { // lachhhandfriends
		
			this.user = userName;
			this.channel = channel;
			
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
			
			Connect();
		}
		
		public function Connect():void{
			trace("connecting");
			try{
				sock.connect(SERVER, 6667);
			}
			catch(error:Error){
				trace(error.message);
			}
		}
		
		public function OnConnected(event:Event):void{
			LogInToChat();
		}
		
		public function LogInToChat():void{
			trace("logging in");
			SayNoDelay("USER " + user);
			SayNoDelay("PASS " + OATHTOKEN);
			SayNoDelay("NICK " + user);
			SayNoDelay("JOIN #" + channel);
			//SayToChannel("AS3 bot reporting for duty.");
		}
		
		public function SayNoDelay(msg:String):void{
			trace(msg);
			messagesSent++;
			sock.writeUTFBytes(msg + '\n');
			sock.flush();
		}
		
		public function SayToChannel(msg:String):void{
			Say("PRIVMSG #" + channel + " :" + msg);
		}
		
		public function PingReply(msg:String = "tmi.twitch.tv"):void{
			SayNoDelay("PONG " + msg);
		}
		
		public function Say(msg:String){
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
			//trace("new message");
			
			var str:String = sock.readUTFBytes(sock.bytesAvailable);
			
			//trace(str);
			
			var messages:Array = str.split("\n");
			
			var i:int;
			for(i = 0; i < 5; i++){
				if(messages[i] == null){continue;}
				trace(messages[i]);
				HandleMessage(messages[i]);
			}
			
			// all this commented code below works just fine. I left it here in case the above code ever starts acting up.
			// the code below loops through the buffer one character at a time, using an array as a buffer to build the string.
			// but, the above works perfectly as far as I could tell.
			
			// practice good memory management! we aren't +'ing two strings here, we're using a stringbuilder
			// then again, this is the "best practice" (airquotes) socket reader I found.
			//var stringBuffer:Array = new Array();
			//while(sock.bytesAvailable > 0){
			//	stringBuffer.push(sock.readUTFBytes(1).charCodeAt(0));
			//}
			
			// build our string
			//var data:String = String.fromCharCode.apply(null, stringBuffer);
			
			//trace(data);
			//MatchMessage(data);
		}
		
		public function HandleMessage(msg:String):void{
			
			
			
			// reply to ping-pong messages immediately. heartbeat messages from the server.
			if(MetaIRCMessage.isPing(msg)){
				PingReply();
				return;
			}
			
			lastMsgReceived = MetaIRCMessage.createFromRawData(msg);
			if (callbackMsgReceived) callbackMsgReceived.call();
			/*
			// Username Filtering
			if(metaIRCMsg.isNotificationFromTwitch()){ // twitch notify is the account that sends subscription messages
				var data:Array;
				if(metaIRCMsg.isNewSubAlert()){ // kojaktsl just subscribed!
					trace("SOMEONE JUST SUBSCRIBED!");
					data = text.split(" ");
					// data[0] is the username
					var name:String = data[0];
					trace("THAT SOMEONE: " + name);
					
					var m:MetaSubcriberAlert = new MetaSubcriberAlert();
					m.name = name;
					m.numMonthInARow = 1;
				}
				else if(text.indexOf("subscribed for") >= 0){ //kojaktsl subscribed for x months in a row!
					trace("RESUBSCRIPTION!");
					data = text.split(" ");
					// data[0] is the username, data[3] is the length of months
					trace(data[0] + " : SUB LENGTH " + data[3]);
					
					var m:MetaSubcriberAlert = new MetaSubcriberAlert();
					m.name = data[0];
					m.numMonthInARow = data[3];
				}
				return;
			}
			else if(metaIRCMsg.isMoobot()){
				// ignore moobot
				return;
			}
			
			// Message filtering
			if(TextContains(text, "!help") || TextContains(text, "!commands")){
				SayToChannel("I respond to <list of commands>");
			}
			else if(TextContains(text, "Dear Lachhh,")){
				SayToChannel("you can use this to collect interview questions");
			}
			else if(TextContains(text, "lachhhPunch")){
				SayToChannel("Collect punches! Because that sounds awesome");
			}
			else if(TextContains(text, "!collect")){
				SayToChannel(userName + " has collected their chest.");
				// people on mobile get their chests!
			}
			else if(TextContains(text, "!question")){
				SayToChannel(userName + " has a question!");
				// you could then put the text in a queue and have a little counter for questions
			}*/
		}
		
		public function TextContains( text:String, substr:String ):Boolean{
			return (text.indexOf(substr) >= 0);
		}
		
		public function OnIOError(event:IOErrorEvent):void {trace("IO ERROR!"); trace(event);	}
		public function OnSecurityError(event:SecurityErrorEvent):void {trace("Security Error!");	trace(event);}
		public function OnClosedConnection(event:Event):void{trace("Closed Connection"); trace(event);}

	}
	
}
