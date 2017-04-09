package com.giveawaytool.components {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.io.playerio.GameWispConnection;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.io.twitch.emotes.MetaEmoteGroup;
	import com.giveawaytool.io.twitch.streamlabs.StreamLabsConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaPlayMovie;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.giveawaytool.meta.donations.MetaDonationList;
	import com.giveawaytool.meta.donations.MetaDonationsConfig;
	import com.giveawaytool.ui.MetaHostAlert;
	import com.giveawaytool.ui.MetaSubcriberAlert;
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.views.MetaCheerAlert;
	import com.giveawaytool.ui.views.MetaFollower;
	import com.giveawaytool.ui.views.MetaFollowerList;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import com.lachhh.io.CallbackGroup;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.sfx.JukeBox;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.OutputProgressEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class LogicSendToWidget extends ActorComponent {
		private var serverSocket:ServerSocket ;
		private var clientSockets:Array = new Array();
		public var onWidgetChanged : CallbackGroup = new CallbackGroup();
		public var onSendFailed : CallbackGroup = new CallbackGroup();
		private var port : int;
		public var autoSendConfig : Boolean = false;
		public var modelAPIToGetCodeFrom : String = "twitch";
		public var MODEL_TWITCH : String = "twitch";
		public var MODEL_STREAMLABS : String = "streamlabs";
		public var MODEL_GAMEWISP : String = "gamewisp";
		

		public function LogicSendToWidget(pPort : int, pAutoSendConfig:Boolean) {
			super();
			port = pPort;
			serverSocket = new ServerSocket();
			autoSendConfig = pAutoSendConfig;
			tryToConnect();
			
		}
		
		public function setModelForTwitch():void {
			modelAPIToGetCodeFrom = MODEL_TWITCH;
		}
		
		public function setModelForStreamlabs():void {
			modelAPIToGetCodeFrom = MODEL_STREAMLABS;
		}
		public function setModelForGameWisp() : void {
			modelAPIToGetCodeFrom = MODEL_GAMEWISP;
		}
		
		
		private function tryToConnect():void {
			try {
				serverSocket.bind(port, "127.0.0.1");
				serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT, onConnect);
				serverSocket.listen();
			} catch(e:Error) {
				CallbackTimerEffect.addWaitCallFctToActor(MainGame.dummyActor, tryToConnect, 10000);
			}
		}
		
		private function onConnect( event:ServerSocketConnectEvent ):void {
			trace("WidgetsConnectionManager ::: server_connectHandler");
			var clientSocket : Socket = event.socket;
			clientSockets.push(clientSocket);

			clientSocket.addEventListener(ProgressEvent.SOCKET_DATA, widgetSocket_dataHandler);
			clientSocket.addEventListener(Event.CONNECT, widgetSocket_connectHandler);
			clientSocket.addEventListener(Event.CLOSE, widgetSocket_closeHandler);
			clientSocket.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, widgetSocket_progressHandler);
			clientSocket.addEventListener(IOErrorEvent.IO_ERROR, widgetSocket_ioErrorHandler);
			clientSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, widgetSocket_securityErrorHandler);
			
			onWidgetChanged.call();
			
			if(autoSendConfig) CallbackTimerEffect.addWaitCallFctToActor(actor, sendConfig, 1000);
		}
		
		private function sendConfig():void {
			sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
		}
		
		//------------------------------------
		// getPolicy()
		//------------------------------------
		private function getPolicy():String {
			trace("WidgetsConnectionManager ::: getPolicy");
			var xml:String = '<?xml version="1.0" encoding="UTF-8"?>\n';
			xml += '<!DOCTYPE cross-domain-policy SYSTEM "http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd">\n';
			xml += '<cross-domain-policy>\n';
			xml += '    <allow-access-from domain="*" to-ports="*"/>\n';
			xml += '</cross-domain-policy>\n';
			return xml;
			//return "<?xml version=\"1.0\"?><cross-domain-policy><allow-access-from domain=\"*\" to-ports=\"*\"/></cross-domain-policy>\0";
		}
		
		private function widgetSocket_closeHandler(event : Event) : void {
			trace("Socket CLosed " + event.type + "/" + event.target);
			cleanDeadSocket();
			onWidgetChanged.call();
		}
	  
	 	private function widgetSocket_dataHandler( event:ProgressEvent ):void {
			trace("WidgetsConnectionManager ::: widgetSocket_dataHandler");
			
			var s:Socket = event.currentTarget as Socket;
			var p:String;
			
			var msg:String = s.readUTFBytes(s.bytesAvailable);
			trace("    - msg: ", msg);
			 
			if(msg.toString().indexOf("GET /?code=") == 0) {
				var a:Array = msg.toString().split("?code=");
				var str1:String = a[1];
				var a2:Array = str1.split("&");
				var code:String = a2[0];
				//s.flush();
				if(modelAPIToGetCodeFrom == MODEL_TWITCH) {
					TwitchConnection.instance.setCodeFromWebSocket(code);
				} else if(modelAPIToGetCodeFrom == MODEL_STREAMLABS) {
					StreamLabsConnection.instance.setCodeFromWebSocket(code);
				} else if(modelAPIToGetCodeFrom == MODEL_GAMEWISP) {
					GameWispConnection.instance.setCodeFromWebSocket(code);
				}
				///clearShitOnURL();
				
				/*s.writeUTFBytes(getSuccessMsg());
				s.flush();*/
				sendSuccessMsg(s);
			}
			
			if(msg.toString().indexOf("policy-file-request") != -1) {
				trace("    - sending policy file");
				p = getPolicy();
				trace(p);
				s.writeUTFBytes(p);
				s.writeByte(0);
				s.flush();
			}
			
			if(msg == "Connected") {
				sendConfig();	
			}
	       
		}

		
		private function widgetSocket_connectHandler(event:Event):void {
			trace("WidgetsConnectionManager ::: widgetSocket_connectHandler");	
		}
		
		//------------------------------------
		// widgetSocket_progressHandler()
		//------------------------------------
		private function widgetSocket_progressHandler(event:OutputProgressEvent):void {
			trace("WidgetsConnectionManager ::: widgetSocket_progressHandler");
			
		}
		
		//------------------------------------
		// widgetSocket_ioErrorHandler()
		//------------------------------------
		private function widgetSocket_ioErrorHandler(event:IOErrorEvent):void {
			trace("WidgetsConnectionManager ::: widgetSocket_ioErrorHandler");
			
		}
		
		//------------------------------------
		// widgetSocket_securityErrorHandler()
		//------------------------------------
		private function widgetSocket_securityErrorHandler(event:SecurityErrorEvent):void {
			trace("WidgetsConnectionManager ::: widgetSocket_securityErrorHandler");
		}
		
		public function sendTestDonation():void { sendAddDonation(MetaDonation.createDummy());}
		public function sendTestCheer():void { sendCheerAlert(MetaCheerAlert.createDummy());}
		public function sendTestFollow():void { sendFollowAlert(MetaFollowAlert.createDummy());}
		public function sendTestSub():void { sendSubscriberAlert(MetaSubcriberAlert.createDummy());}
		public function sendTestHost():void { sendHostAlert(MetaHostAlert.createDummy());}
		
		public function sendAddDonation(m:MetaDonation):void {
			var d:Dictionary = m.encode();
			MetaGameProgress.instance.metaDonationsConfig.allDonations.encodeNewDonation(d, m);
			d.type = "newDonation";
			sendData(d);
		}
		
		public function sendEmoteFireworks(m:MetaEmoteGroup):void{
			var d:Dictionary = m.encode();
			d.type = "emoteFirework";
			sendData(d);
		}
		
		public function sendPlayMovie(m:MetaPlayMovie):void {
			var d:Dictionary = m.encode();
			d.type = "playMovie";
			sendData(d);
		}

		public function sendHostAlert(m : MetaHostAlert) : void {
			var d : Dictionary = m.encode();
			d.type = "hostAlert";
			sendData(d);
		}

		public function sendFollowAlert(m : MetaFollowAlert) : void {
			var d:Dictionary = m.encodeForWidget();
			d.type = "followAlert";
			sendData(d);
		}
		
		public function sendCheerAlert(m : MetaCheerAlert) : void {
			var d:Dictionary = m.encode();
			d.type = "cheerAlert";
			sendData(d);
		}
		
		public function sendVolumeMaster() : void {
			var d:Dictionary = JukeBox.getInstance().encode();
			d.type = "volumeMaster";
			sendData(d);
		}
		
		public function sendAllNewFollow(allFollows:MetaFollowerList):void {
			var newFollowersList:MetaFollowerList = allFollows.copyKeepingOnlyNew();
			for (var i : int = 0; i < newFollowersList.followers.length; i++) {
				var m:MetaFollower = newFollowersList.getMetaFollower(i);
				sendFollowAlert(MetaFollowAlert.create(m));
			}
		}
		
		public function sendSubscriberAlert(m : MetaSubcriberAlert) : void {
			var d:Dictionary = m.encodeForWidget();
			d.type = "subAlert";
			sendData(d);
		}
		
		public function sendAllNewSubscriber(allFollows:MetaSubscribersList):void {
			var newFollowersList:MetaSubscribersList = allFollows.copyKeepingOnlyNew();
			for (var i : int = 0; i < newFollowersList.subscribers.length; i++) {
				var m:MetaSubscriber= newFollowersList.getMetaSubscriber(i);
				sendSubscriberAlert(MetaSubcriberAlert.createFromSub(m));
			}
		}
		
		public function sendTwitterAlert(m : MetaTwitterAlert) : void {
			var d:Dictionary = m.encode();
			d.type = "tweetAlert";
			sendData(d);
		}
		
		
		
		public function sendAllNewDonation(allDonation:MetaDonationList):void {
			var newDonationsList:MetaDonationList = allDonation.copyKeepingOnlyNew();
			var d:Dictionary = newDonationsList.encodeForWidget(MetaGameProgress.instance.metaDonationsConfig);
			d.type = "newDonationList";
			sendData(d);
		}
		
		public function sendDonationConfig(m:MetaDonationsConfig):void {
			var d:Dictionary = m.encodeForWidget();
			d.type = "refreshConfig";
			sendData(d);
			
			MetaGameProgress.instance.metaDonationsConfig.metaCustomAnim.transfertCustomAnimToFolder();
		}
		
		
		public function sendForceStopAnim():void {
			var d:Dictionary = MetaGameProgress.instance.metaDonationsConfig.encodeForWidget();
			d.type = "forceStopAnim";
			sendData(d);
		}
		
		public function sendData(data:Dictionary):void {
			if(!autoSendConfig) return ;
			cleanDeadSocket();
			
			if(!hasAWidgetConnected()) {
				onSendFailed.call();
				return ;
			}
			
			var obj:Object = DataManager.dictToObject(data);
			var dataToSend:String = (JSON.stringify(obj)) + "\n";
			sendRaw(dataToSend);
			
		}
		
		public function sendRaw(dataToSend:String):void {
			cleanDeadSocket();
			
			if(!hasAWidgetConnected()) {
				onSendFailed.call();
				return ;
			}
			
			for (var i : int = 0; i < clientSockets.length; i++) {
				var clientSocket:Socket =  clientSockets[i];
				if(!clientSocket.connected) continue;
				
				if(port == 9233) {
					trace(dataToSend);
				}
				clientSocket.writeUTFBytes(dataToSend);
           		clientSocket.flush();
			}
		}

		public function cleanDeadSocket() : void {
			for (var i : int = 0; i < clientSockets.length; i++) {
				var clientSocket:Socket =  clientSockets[i];
				if(clientSocket.connected == false) {
					trace("socket Dead, Removed");
					clientSockets.splice(i, 1);
					i--;
				} 
			}
		}
		
		public function hasAWidgetConnected():Boolean {
			return clientSockets.length >= 1;
		}

		public function clearShitOnURL() : void {
			cleanDeadSocket();
			
			if(!hasAWidgetConnected()) {
				onSendFailed.call();
				return ;
			}
			
			
			for (var i : int = 0; i < clientSockets.length; i++) {
				var clientSocket:Socket =  clientSockets[i];
				if(!clientSocket.connected) continue;
				
           		clientSocket.flush();
			}
		}

		public function sendSuccessMsg(s:Socket):void {
			var returnData : ByteArray =new ByteArray();
			var str:String = "Success! You can now close this page";
			returnData.writeUTFBytes(str);
				
			var returnHeader:String = "";
			returnHeader="HTTP/1.1 200 OK\r\n";
		    returnHeader+="Accept-Ranges: bytes\r\n";
		    returnHeader+="Connection: keep-alive\r\n";
		    returnHeader+="Content-Length: "+returnData.length+"\r\n";
		    returnHeader+="Content-Type: "+"html"+"\r\n\r\n";
			s.writeUTFBytes(returnHeader);
			s.writeBytes(returnData);
			s.flush();
		}
	
		public function getSuccessMsg():String {
			var redirect:String = "http://www.lachhhTools.com";
			var returnData : ByteArray =new ByteArray();
			var str:String = "Success! You can now close this page";
			returnData.writeUTFBytes(str);
				
			var result:String = "";
			result="HTTP/1.1 200 OK\r\n";
		    result+="Accept-Ranges: bytes\r\n";
		    result+="Connection: keep-alive\r\n";
		    result+="Content-Length: "+returnData.length+"\r\n";
		    result+="Content-Type: "+"html"+"\r\n\r\n";
			result = "<html lang=\"en\" xml:lang=\"en\" xmlns=\"http://www.w3.org/1999/xhtml\"><head></head><body><?php echo \"<center>Success! You can now close this page\" <script language=\'javascript\'>?></body></html>";
			trace(result);
			return result;
	
		}
	}
}
