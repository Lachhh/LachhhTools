package com.giveawaytool.ui.views {
	import com.MetaIRCMessage;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCheerAlert {
		public var numBits:int = 0 ;
		public var name:String = "Dummy" ;
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["numBits"] = numBits;
			saveData["name"] = name;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			numBits = loadData["numBits"];
			name = loadData["name"];
		}
		
		
		static public function createFromIRCMsg(m:MetaIRCMessage):MetaCheerAlert {
			var result:MetaCheerAlert = new MetaCheerAlert();
			result.name = m.getCheerName();
			result.numBits = m.getCheerBitCount();
			return result;
		}
		
		public static function createFromCheer(metaCheer : MetaCheer) : MetaCheerAlert {
			var result:MetaCheerAlert = new MetaCheerAlert();
			result.name = metaCheer.name;
			result.numBits = metaCheer.numBits;
			return result;
		}

		public static function createDummy() : MetaCheerAlert {
			var result:MetaCheerAlert = new MetaCheerAlert();
			result.name = "An Awesome dude";
			result.numBits = Math.random()*127+24;
			return result;
		}
	}
}
