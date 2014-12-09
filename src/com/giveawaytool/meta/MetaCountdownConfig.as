package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCountdownConfig {
		public var target:String = "Some poor dude";
		public var text1:String = "QUICK!  Show yourself!  Talk in the chat!";
		public var countdown:int = 30;
		public var metaAnimation:MetaSelectAnimation = new MetaSelectAnimation();
		
		private var saveData : Dictionary = new Dictionary();
			
		public function encode():Dictionary {
			saveData["text1"] = text1;
			saveData["target"] = target;
			saveData["countdown"] = countdown;
			saveData["metaAnimation"] = metaAnimation.encode();	
			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			text1 = obj["text1"];
			target = obj["target"] ;
			countdown = obj["countdown"] ;
			metaAnimation.decode(obj["metaAnimation"]);
		}
		
	}
}
