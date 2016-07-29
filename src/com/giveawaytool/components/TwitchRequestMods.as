package com.giveawaytool.components {
	import com.MetaIRCMessage;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.lachhh.io.Callback;
	import com.lachhh.utils.Utils;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchRequestMods {
		
		public var listOfMods : Array;
		private var twitchChat : LogicTwitchChat;
		public var onSuccessCallback : Callback;
		public var onErrorCallback : Callback;
		private var callbackOnMsg : Callback;

		public function TwitchRequestMods(pTwitchChat : LogicTwitchChat) {
			twitchChat = pTwitchChat;
			callbackOnMsg = new Callback(onMsg, this, null);
		}

		public function fetchListOfMods() : void {
			listOfMods = new Array();
			if(!twitchChat.isConnected()) {
				return ;
			}
			
			twitchChat.callbackMsgReceived.addCallback(callbackOnMsg);
			twitchChat.getIRCBot().SayNoDelay( "PRIVMSG #" + TwitchConnection.instance.getNameOfAccount() + " :.mods\n");
			trace("Something");
		}
		
		private function onMsg() : void {
			try {
				var msg:MetaIRCMessage = twitchChat.lastMsgReceived;
				if(!msg.isModsRequest()) return ;
				
				twitchChat.callbackMsgReceived.removeCallback(callbackOnMsg);
				var listModsStr:String = msg.text.split(" ").join("");
				listModsStr = Utils.removeTextNewLine(listModsStr);
				listOfMods = listModsStr.split(",");
				if(onSuccessCallback) onSuccessCallback.call();
			} catch (e:Error) {
				
				if(onErrorCallback) onErrorCallback.call();
			}
		}
		

		
	}
}
