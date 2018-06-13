package com.giveawaytool.ui.views {
	/**
	 * @author LachhhSSD
	 */
	public class MetaParticipant {
		public var name : String;
		public var nameToLowerCase : String;

		public function MetaParticipant(pName:String) {
			name = pName;
			nameToLowerCase = name.toLowerCase();
		}
		
		public function isNull():Boolean {
			if(name == "")  return true;
			if(name == null) return true;
			return false;
		}

		public static function sortByNameLowerCase(a:MetaParticipant, b:MetaParticipant) : int {
			if(a.nameToLowerCase < b.nameToLowerCase) return -1;
			if(a.nameToLowerCase > b.nameToLowerCase) return 1;
			return 0;
		}

		public static function toArray(list : Vector.<MetaParticipant>) : Array {
			var result:Array = new Array();
			for (var i : int = 0; i < list.length; i++) {
				result.push(list[i].name);
			}
			return result;
		}
		
	}
}
