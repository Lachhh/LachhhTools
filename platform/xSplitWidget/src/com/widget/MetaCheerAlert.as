package com.giveawaytool {
	import com.lachhh.utils.Utils;
	import com.lachhh.flash.FlashUtils;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCheerAlert {
		public var name:String = "";
		public var numBits:int = 0;
		private var saveData : Dictionary = new Dictionary();
		
		public function MetaCheerAlert() {
			
		}
				
		public function encode():Dictionary {
			saveData["name"] = name;
			saveData["numBits"] = numBits;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			name = loadData["name"];
			numBits = FlashUtils.myParseFloat(loadData["numBits"]);
		}
		
		public function getBitsText():String {
			return Utils.PutVirgules(numBits) + " bit" + (numBits > 1 ? "s" : "");
		}
		

		public static function createDummy() : MetaCheerAlert {
			var result:MetaCheerAlert = new MetaCheerAlert();
			result.numBits = Math.random()*25000;
			result.name = "M. Dummy : " + result.numBits;
			return result;
		}

		static public function createFromRawData(rawData:Dictionary):MetaCheerAlert {			
			var result:MetaCheerAlert = new MetaCheerAlert();
			result.decode(rawData);
			return result;
		}
	}
}
