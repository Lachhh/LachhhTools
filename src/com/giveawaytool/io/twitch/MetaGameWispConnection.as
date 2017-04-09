package com.giveawaytool.io.twitch {
	import com.giveawaytool.io.playerio.MetaGameWispChannelInfo;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispConnection {
		public var lastAccessToken:String = "";
		public var channelInfo:MetaGameWispChannelInfo = new MetaGameWispChannelInfo();

		public function MetaGameWispConnection() {
			
		}
		
		private var saveData : Dictionary = new Dictionary();
				
		public function hasLoggedInBefore():Boolean {
			return (lastAccessToken != "");
		}
				
		public function clear():void {
			channelInfo.clear();
			lastAccessToken = "";
		}
		
		public function encode():Dictionary {
			saveData["channelInfo"] = channelInfo.encode();
			saveData["lastAccessToken"] = lastAccessToken;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			channelInfo.decode(loadData["channelInfo"]);
			lastAccessToken = loadData["lastAccessToken"];
			
			if(lastAccessToken == null) lastAccessToken = "";
		}
	}
}
