package com.giveawaytool.components {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.giveawaytool.ui.UI_PlayMovies;
	import com.lachhh.io.CallbackGroup;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.MetaIRCMessage;
	import com.SimpleIRCBot;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaIRCConnection;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicTwitchChat extends ActorComponent {
		private var simpleIRCBot:SimpleIRCBot ;
		public var callbackOnConnectGroup:CallbackGroup;
		public var callbackOnFailedGroup:CallbackGroup;
		public var callbackMsgReceived:CallbackGroup;
		public var lastMsgReceived:MetaIRCMessage;
		
		public function LogicTwitchChat() {
			super();
			callbackMsgReceived = new CallbackGroup();
			callbackOnConnectGroup = new CallbackGroup();
			callbackOnFailedGroup = new CallbackGroup();
		}
		
		public function quickConnect():void {
			if(!TwitchConnection.instance.isConnected()) return ;
			connect("oauth:" + TwitchConnection.instance.accessToken);	
		}
		
		public function connect(oauth:String):void {
			var nameOfAccount:String = TwitchConnection.instance.getNameOfAccount();
			var metaconnect:MetaIRCConnection = new MetaIRCConnection(nameOfAccount, oauth);
			disconnect();
			traceLog("Connecting to chat...");
			simpleIRCBot = new SimpleIRCBot(metaconnect);
			simpleIRCBot.callbackOnConnected = new Callback(onConnectSuccess, this, null);
			simpleIRCBot.callbackOnFailed = new Callback(onConnectError, this, null);
			simpleIRCBot.Connect();
			
		}
		
		private function disconnect():void {
			if(simpleIRCBot == null) return ;
			simpleIRCBot.disconnect();
			simpleIRCBot = null;
			traceLog("Disconnecting to chat...");
		}

		private function onConnectSuccess() : void {
			MetaGameProgress.instance.metaTwitchConnection.chatIRCoauth = simpleIRCBot.metaIRCConnection.auth;
			MetaGameProgress.instance.saveToLocal();
			simpleIRCBot.callbackMsgReceived.addCallback(new Callback(onMsg, this, null));
			callbackOnConnectGroup.call();
			UIBase.manager.refresh();
		}
		
		private function onConnectError() : void {
			MetaGameProgress.instance.metaTwitchConnection.chatIRCoauth = "";
			MetaGameProgress.instance.saveToLocal();
			callbackOnFailedGroup.call();
			UIBase.manager.refresh();
		}
		
		private function onMsg() : void {
			lastMsgReceived = simpleIRCBot.lastMsgReceived;
			traceLog("MSG " + lastMsgReceived.toString());
			callbackMsgReceived.call();
			
		}
		
		public function isConnected():Boolean {
			if(simpleIRCBot == null) return false;
			return simpleIRCBot.isConnected();
		}

		
		public function traceLog(str:String):void {
			MetaGameProgress.instance.metaTwitchChat.addLine(str);
			var ui:UI_PlayMovies = UIBase.manager.getFirst(UI_PlayMovies) as UI_PlayMovies;
			if(ui) ui.refresh();
		}

		public function getIRCBot() : SimpleIRCBot {
			return simpleIRCBot;
		}
	}
}
