package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCustomAnim {
		public var dataPath : String = "";
		public var useDefault : Boolean = true;
		private var saveData : Dictionary = new Dictionary();

		public function MetaCustomAnim() {
		}
		
				
		public function encode():Dictionary {
			saveData["dataPath"] = dataPath;
			saveData["useDefault"] = useDefault;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			dataPath = loadData["dataPath"];
			useDefault = loadData["useDefault"];
		}
		
		public function isUseDefault():Boolean {
			if(useDefault) return true;
			if(dataPath == "") return true;
			return false;
		}
		
		public function hasCustomAnim():Boolean {
			return !isUseDefault();
		}
	}
}
