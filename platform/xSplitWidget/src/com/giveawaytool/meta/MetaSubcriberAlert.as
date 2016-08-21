package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSubcriberAlert {
		public var numMonthInARow:int = 0 ;
		public var name:String = "Dummy" ;
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["numMonthInARow"] = numMonthInARow;
			saveData["name"] = name;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			numMonthInARow = loadData["numMonthInARow"];
			name = loadData["name"];
		}
		
		public function isNewSubscriber():Boolean {
			return (numMonthInARow <= 1);
		}
		
		static public function createFromRawData(rawData:Dictionary):MetaSubcriberAlert {			
			var result:MetaSubcriberAlert = new MetaSubcriberAlert();
			result.decode(rawData);
			return result;
		}
	}
}
