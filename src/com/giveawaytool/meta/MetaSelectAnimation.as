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
	}
}
