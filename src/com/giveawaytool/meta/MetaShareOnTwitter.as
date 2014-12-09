package com.giveawaytool.meta {
	import com.lachhh.lachhhengine.VersionInfo;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaShareOnTwitter {
		static public var WINNER:String = "<Winner>"; 
		public var attachImage:Boolean = true;
		public var tweet:String = "<Winner> has won the last giveaway!  Next giveaway in an hour, be There! twitch.tv/" + VersionInfo.DEFAULT_CHANNEL;
		public var twitterAccounts:MetaTwitterAcccountList = new MetaTwitterAcccountList();
		
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["attachImage"] = attachImage;
			saveData["tweet"] = tweet;
			saveData["twitterAccounts"] = twitterAccounts.encode();
			
			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			attachImage = obj["attachImage"];
			tweet = obj["tweet"];
			twitterAccounts.decode(obj["twitterAccounts"]);
			if(tweet == null) tweet = "";
		}
		
		public function getCompleteTweetMsg():String {
			var winner:String = MetaGameProgress.instance.metaExportPNGConfig.winner;
			return tweet.split(WINNER).join(winner);
		}
		
		
		public function charLeft():int {
			var tweetLen:int = getCompleteTweetMsg().length;
			var totalUsed:int = tweetLen + (attachImage ? 27 : 0);
			var totalAllowed:int = 140;
			return (totalAllowed - totalUsed);
		}
		
		public function hasTooMuchChars():Boolean {
			return (charLeft() < 0); 
		}
	}
}
