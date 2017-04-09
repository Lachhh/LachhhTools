package com.giveawaytool.io.playerio {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispTier {
		static public var NULL:MetaGameWispTier = new MetaGameWispTier();
		
		public var tierId:String = "";
		public var tierCost:String = "";
		public var tierTitle : String = "";
		public var tierDescription : String = "";
		public var tierLevel : String = "";
		private var saveData : Dictionary = new Dictionary();
		

		public function encode() : Dictionary {
			saveData["tierId"] = tierId;
			saveData["tierCost"] = tierCost;
			saveData["tierTitle"] = tierTitle;
			saveData["tierDescription"] = tierDescription ;
			saveData["tierLevel"] = tierLevel ;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			tierId = loadData["tierId"];
			tierCost = loadData["tierCost"];
			tierTitle = loadData["tierTitle"];
			tierDescription = loadData["tierDescription"];
			tierLevel = loadData["tierLevel"];
			
		}

		public static function createFromRaw(rawData : Dictionary) : MetaGameWispTier {
			var result:MetaGameWispTier = new MetaGameWispTier();
			result.tierId = rawData["id"];
			result.tierCost = rawData["cost"];
			result.tierTitle = rawData["title"];
			result.tierDescription = rawData["description"];
			result.tierLevel = rawData["level"];
			return result;
		}
	}
}
