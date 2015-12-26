package com.giveawaytool.meta {
	import com.kojaktsl.TwitterAPI.MetaTweet;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaTwitterAlert {
		public var message:String = "" ;
		public var name:String = "Dummy" ;
		public var searchedFor:String = "" ;
		
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["message"] = message;
			saveData["name"] = name;
			saveData["searchedFor"] = searchedFor;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			message = loadData["message"];
			name = loadData["name"];
			searchedFor = loadData["searchedFor"];
			
		}
		
		static public function createFromMetaTweet(metaTweet:MetaTweet):MetaTwitterAlert {			
			var result:MetaTwitterAlert = new MetaTwitterAlert();
			result.name = metaTweet.user;
			result.message = metaTweet.text;
			return result;
		}
		
		static public function createFromRawData(rawData:Dictionary):MetaTwitterAlert {			
			var result:MetaTwitterAlert = new MetaTwitterAlert();
			result.decode(rawData);
			return result;
		}

		public static function createDummy() : MetaTwitterAlert {
			var result:MetaTwitterAlert = new MetaTwitterAlert();
			result.name = "MrDummy";
			result.message = "This is a test of a long tweet.  I'm doing this to check out what's the maximum of characters a tweets can do.  I know it's 140, but I need.";
			return result;
		}
	}
}
