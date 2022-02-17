package com.giveawaytool.io.twitch {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaTwithConnection {
		public var lastAccessTokenHelix:String = "";
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
			lastAccessTokenHelix = "";
		}
		
		public function encode():Dictionary {
			saveData["lastNameLogin"] = lastNameLogin;
			saveData["chatIRCoauth"] = chatIRCoauth;
			saveData["lastAccessTokenHelix"] = lastAccessTokenHelix;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			chatIRCoauth = loadData["chatIRCoauth"];
			lastNameLogin = loadData["lastNameLogin"];
			lastAccessTokenHelix = loadData["lastAccessTokenHelix"];
			
			if(chatIRCoauth == null) chatIRCoauth = "";
			if(lastNameLogin == null) lastNameLogin = "";
			if(lastAccessTokenHelix == null) lastAccessTokenHelix = "";
		}
	}
}
