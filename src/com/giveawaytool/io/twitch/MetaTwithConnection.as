package com.giveawaytool.io.twitch {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaTwithConnection {
		public var lastAccessToken:String = "";
		public var lastNameLogin:String = "";
		public var chatIRCoauth : String = "";
		
		

		public function MetaTwithConnection() {
		}
		
		private var saveData : Dictionary = new Dictionary();
				
		public function hasLoggedInBefore():Boolean {
			return (lastNameLogin != "");
		}
		
		public function hasLoggedInChatBefore():Boolean {
			return (chatIRCoauth != "" && chatIRCoauth != null);
		}
		
		public function clear():void {
			lastNameLogin = "";
			chatIRCoauth = "";
			lastAccessToken = "";
		}
		
		public function encode():Dictionary {
			saveData["lastNameLogin"] = lastNameLogin;
			saveData["chatIRCoauth"] = chatIRCoauth;
			saveData["lastAccessToken"] = lastAccessToken;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			chatIRCoauth = loadData["chatIRCoauth"];
			lastNameLogin = loadData["lastNameLogin"];
			lastAccessToken = loadData["lastAccessToken"];
			
			if(chatIRCoauth == null) chatIRCoauth = "";
			if(lastNameLogin == null) lastNameLogin = "";
			if(lastAccessToken == null) lastAccessToken = "";
		}
	}
}
