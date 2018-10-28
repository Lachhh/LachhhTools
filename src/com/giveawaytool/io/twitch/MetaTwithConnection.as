package com.giveawaytool.io.twitch {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaTwithConnection {
		public var lastAccessTokenV5:String = "";
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
			lastAccessTokenV5 = "";
		}
		
		public function encode():Dictionary {
			saveData["lastNameLogin"] = lastNameLogin;
			saveData["chatIRCoauth"] = chatIRCoauth;
			saveData["lastAccessTokenV5"] = lastAccessTokenV5;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			chatIRCoauth = loadData["chatIRCoauth"];
			lastNameLogin = loadData["lastNameLogin"];
			lastAccessTokenV5 = loadData["lastAccessTokenV5"];
			
			if(chatIRCoauth == null) chatIRCoauth = "";
			if(lastNameLogin == null) lastNameLogin = "";
			if(lastAccessTokenV5 == null) lastAccessTokenV5 = "";
		}
	}
}
