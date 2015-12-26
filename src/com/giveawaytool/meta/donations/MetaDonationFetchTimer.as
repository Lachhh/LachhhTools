package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonationFetchTimer {
		public var seconds:int = 30;
		public var secondsLeft:int = 30;
		public var autoCollect:Boolean = true;
		public var enabled:Boolean = true;
		
		private var saveData : Dictionary = new Dictionary();
				
		public function resetTimer():void {
			secondsLeft = seconds;
		}
		
		public function encode():Dictionary {
			saveData["seconds"] = seconds;
			saveData["autoCollect"] = autoCollect;
			saveData["enabled"] = enabled;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			seconds = loadData["seconds"];
			autoCollect = loadData["autoCollect"];
			enabled = loadData["enabled"];
			secondsLeft = seconds;
		}
	}
}
