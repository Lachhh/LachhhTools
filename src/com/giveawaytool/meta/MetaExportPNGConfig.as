package com.giveawaytool.meta {
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaExportPNGConfig {
		public var winner:String = "Some Lucky Dude";
		public var text1:String = "has won the giveaway!";
		public var text2:String = "Come over for a chance to win!";
		public var text3:String = "twitch.tv/" + VersionInfo.DEFAULT_CHANNEL;
		public var metaAnimation:MetaSelectAnimation = new MetaSelectAnimation();
		
		private var saveData : Dictionary = new Dictionary();
			
		public function encode():Dictionary {
			saveData["winner"] = winner;
			saveData["text1"] = text1;
			saveData["text2"] = text2;
			saveData["text3"] = text3;
			saveData["metaAnimation"] = metaAnimation.encode();
			
			
			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			winner = obj["winner"];
			text1 = obj["text1"];
			text2 = obj["text2"];
			text3 = obj["text3"];
			metaAnimation.decode(obj["metaAnimation"]);
		}
		
	}
}
