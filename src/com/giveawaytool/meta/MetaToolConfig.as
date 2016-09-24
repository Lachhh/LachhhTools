package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaToolConfig {
		static public var SCREEN_FULL:int = 0;
		static public var SCREEN_WINDOW_100:int = 1;
		//static public var SCREEN_WINDOW_75:int = 2;
		public var screenSize:int = 0;
		public var text1:String = "QUICK!  Show yourself!  Talk in the chat!";
		public var countdown:int = 30;
		private var saveData : Dictionary = new Dictionary();
			
		public function encode():Dictionary {
			saveData["screenSize"] = screenSize;
			
			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			screenSize = obj["screenSize"];
		}
		
		public function nextScreenSize():void {
			screenSize++;
			if(screenSize > 1) screenSize = 0;
		}
		
		public function isFullscreen():Boolean {
			return screenSize == SCREEN_FULL;
		}
		
		public function isWindowed():Boolean {
			return screenSize == SCREEN_WINDOW_100; //|| screenSize == SCREEN_WINDOW_75;
		}
		
		public function scaleOfWindow():Number {
			//if(screenSize == SCREEN_WINDOW_75) return 0.75; 
			return 1;
		}
	}
}
