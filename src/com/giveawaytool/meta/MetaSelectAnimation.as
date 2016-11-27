package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSelectAnimation {
		
		public var useDefault:Boolean = true;
		public var pathToSwf:String = "";
		
		public var saveData:Dictionary = new Dictionary();
		
		public function encode():Dictionary {
			saveData["useDefault"] = useDefault;
			saveData["pathToSwf"] = pathToSwf;
			return saveData; 
		}
		
		public function encodeForWidget():Dictionary {
			saveData["useDefault"] = useDefault;
			saveData["pathToSwf"] = getPathAsWidgetLocal();
			return saveData;
		}
		
		public function getPathAsWidgetLocal():String {
			if(isUseDefault()) return "";
			var fileName:String = pathToSwf.split("\\").pop();
			return "CustomAnims\\" + fileName;
		}
				
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			useDefault = obj["useDefault"] ;
			pathToSwf = obj["pathToSwf"] ;
			clean();
		}
		
		public function getShortDesc():String {
			clean();
			if(useDefault) return "Default Animation";
			var fileName:String = pathToSwf.split("\\").pop();
			return fileName;
		}
		
		public function clean():void {
			if(pathToSwf == null) {
				useDefault = true;
			}
		}
		
		public function isUseDefault():Boolean {
			if(useDefault) return true;
			if(pathToSwf == "") return true;
			return false;
		}
		
		public function hasCustomAnim():Boolean {
			return !isUseDefault();
		}
	}
}
