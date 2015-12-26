package com.giveawaytool.ui {
	import com.MetaIRCMessage;
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
		
		
		static public function createFromIRCMsg(m:MetaIRCMessage):MetaHostAlert {
			var result:MetaHostAlert = new MetaHostAlert();
			result.name = m.getHostName();
			result.numViewers = m.getHostViewerCount();
			return result;
		}
	}
}
