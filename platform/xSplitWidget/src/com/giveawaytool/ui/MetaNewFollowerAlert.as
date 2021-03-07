package com.giveawaytool.ui {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaNewFollowerAlert {
		public var name : String;
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["name"] = name;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			name = loadData["name"];
		}

		public static function createFromRawData(rawData : Dictionary) : MetaNewFollowerAlert {			
			var result:MetaNewFollowerAlert = new MetaNewFollowerAlert();
			result.decode(rawData);
			return result;
		}
	}
}
