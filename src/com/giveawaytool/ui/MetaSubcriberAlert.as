package com.giveawaytool.ui {
	import com.MetaIRCMessage;
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
		
		static public function createFromIRCMsg(m:MetaIRCMessage):MetaSubcriberAlert {
			var result:MetaSubcriberAlert = new MetaSubcriberAlert();
			result.name = m.getSubName();
			result.numMonthInARow = m.getResubMonth();
			return result;
		}
	}
}
