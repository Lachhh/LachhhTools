package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSelectAnimation {
		public var pathToSwf : String = "";
		public var useDefault : Boolean = true;
		public var volume : Number = 1;
		private var saveData : Dictionary = new Dictionary();

		public function MetaSelectAnimation() {
		}
		
				
		public function encode():Dictionary {
			saveData["pathToSwf"] = pathToSwf;
			saveData["useDefault"] = useDefault;
			saveData["volume"] = volume;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			pathToSwf = loadData["pathToSwf"];
			useDefault = loadData["useDefault"];
			volume = loadData["volume"];
			if(isNaN(volume)) volume = 1;
		}
		
		public function isUseDefault():Boolean {
			if(useDefault) return true;
			if(pathToSwf == "") return true;
			return false;
		}
		
		public function hasCustomAnim():Boolean {
			return !isUseDefault();
		}
		
		public function getPathAsWidgetLocal():String {
			if(isUseDefault()) return "";
			return pathToSwf;
		}
	}
}
