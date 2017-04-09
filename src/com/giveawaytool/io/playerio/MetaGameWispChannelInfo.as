package com.giveawaytool.io.playerio {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispChannelInfo {
		public var displayName:String;
		public var userName:String;
		public var userId : String;
		public var metaTiers : MetaGameWispTierInfo = new MetaGameWispTierInfo();

		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["displayName"] = displayName;
			saveData["userName"] = userName;
			saveData["userId"] = userId;
			saveData["metaTiers"] = metaTiers.encode();
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if (loadData == null) return ;
			displayName = loadData["displayName"];
			userName = loadData["userName"];
			userId = loadData["userId"];
			metaTiers.decode(loadData["metaTiers"]);
			
			if(displayName == null) displayName = "";
			if(userName == null) userName = "";
			if(userId == null) userId = "";
		}
		
		public static function createFromRawData(d : Dictionary) : MetaGameWispChannelInfo {
			var result:MetaGameWispChannelInfo = new MetaGameWispChannelInfo();
			result.displayName = d["data"]["display_name"];
			result.userName = d["data"]["name"];
			result.userId = d["data"]["id"];
			result.metaTiers.decodeFromRaw(d["data"]["tiers"]);
			return result;
		}

		public function clear() : void {
			displayName = "";
			userId = "";
			userName = "";
		}
	}
}
