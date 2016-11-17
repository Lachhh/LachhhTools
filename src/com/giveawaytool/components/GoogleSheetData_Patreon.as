package com.giveawaytool.components {
	import com.GoogleSheetData;
	/**
	 * @author LachhhSSD
	 */
	public class GoogleSheetData_Patreon extends GoogleSheetData {
		
		public function GoogleSheetData_Patreon(json:Object) {
			super(json);
		}
		
		public function isInBronze(name:String):Boolean {
			return isInColumn(0, name);
		}
		
		public function isInSilver(name:String):Boolean {
			return isInColumn(1, name);
		}
		
		public function isInGold(name:String):Boolean {
			return isInColumn(2, name);
		}
		
		public function isInColumn(x:int, name:String):Boolean {
			var crntName:String = ""; 
			var i:int = 1;
			crntName = getValue(x, i);
			while(crntName != "") {
				if(name.toLowerCase() == crntName.toLowerCase()) return true;
				i++;
				crntName = getValue(x, i); 
			}
			return false;
		}
	}
}
