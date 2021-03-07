package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSubcriberAlert_widget {
		public var numMonthInARow:int = 0 ;
		public var name : String = "Dummy" ;
		public var modelSubSource : String = "Dummy" ;
		public var metaGameWispSubInfo : MetaGameWispSub_widget = new MetaGameWispSub_widget();
		private var saveData : Dictionary = new Dictionary();

		public function encode() : Dictionary {
			saveData["numMonthInARow"] = numMonthInARow;
			saveData["name"] = name;
			saveData["modelSubSource"] = modelSubSource;
			saveData["metaGameWispSubInfo"] = metaGameWispSubInfo.encode();
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			numMonthInARow = loadData["numMonthInARow"];
			name = loadData["name"];
			modelSubSource = loadData["modelSubSource"];
			metaGameWispSubInfo.decode(loadData["metaGameWispSubInfo"]);
		}
		
		public function isNewSubscriberOnTwitch():Boolean {return (numMonthInARow <= 1) && isTwitchSub();}
		public function isReSubOnTwitch():Boolean {return (numMonthInARow > 1) && isTwitchSub();}
		public function isGameWispSub():Boolean {return (modelSubSource == "gamewisp");}
		public function isTwitchSub():Boolean {return (modelSubSource == "twitch");}
		
		static public function createFromRawData(rawData:Dictionary):MetaSubcriberAlert_widget {			
			var result:MetaSubcriberAlert_widget = new MetaSubcriberAlert_widget();
			result.decode(rawData);
			return result;
		}
	}
}
