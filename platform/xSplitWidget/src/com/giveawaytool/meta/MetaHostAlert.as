package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaHostAlert {
		public var numViewers:int = 0 ;
		public var name:String = "Dummy" ;
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["numViewers"] = numViewers;
			saveData["name"] = name;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			numViewers = loadData["numViewers"];
			name = loadData["name"];
		}
		
		public function getIsHostingUsMsg():String {
			if(hasEnoughForRainbow()) return "is hosting us for";
			return "is hosting us!";
		}
		
		public function hasEnoughForRainbow():Boolean {
			return numViewers >= 5;
		}
		
		static public function createFromRawData(rawData:Dictionary):MetaHostAlert {			
			var result:MetaHostAlert = new MetaHostAlert();
			result.decode(rawData);
			return result;
		}

		public static function createDummy() : MetaHostAlert {
			var result:MetaHostAlert = new MetaHostAlert();
			result.name = "DancingFighter";
			result.numViewers = 3;
			return result;
		}
	}
}
