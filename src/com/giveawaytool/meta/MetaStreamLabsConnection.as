package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaStreamLabsConnection {
		public var lastAccessToken:String = "";
	
		private var saveData : Dictionary = new Dictionary();
				
		public function hasLoggedInBefore():Boolean {
			return (lastAccessToken != "");
		}
		
		public function clear():void {
			lastAccessToken = "";
		}
		
		public function encode():Dictionary {
			saveData["lastAccessToken"] = lastAccessToken;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			lastAccessToken = loadData["lastAccessToken"];
			if(lastAccessToken == null) lastAccessToken = "";
		}
	}
}
