package com.giveawaytool.meta {
	import com.lachhh.lachhhengine.VersionInfo;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGiveawayConfig {
		public var text1:String = "It's Super Awesome";
		public var text2:String = "Giveaway time!";
		public var channelToLoad:String = VersionInfo.DEFAULT_CHANNEL;
		public var metaAnimation:MetaSelectAnimation = new MetaSelectAnimation();
		private var saveData : Dictionary = new Dictionary();
			
		public function encode():Dictionary {
			saveData["text1"] = text1;
			saveData["text2"] = text2;
			saveData["channelToLoad"] = channelToLoad;
			saveData["metaAnimation"] = metaAnimation.encode();
			
			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			text1 = obj["text1"];
			text2 = obj["text2"];
			channelToLoad = obj["channelToLoad"];
			metaAnimation.decode(obj["metaAnimation"]);
			
			if(channelToLoad == null) channelToLoad = VersionInfo.DEFAULT_CHANNEL;
		}
		
	}
}
