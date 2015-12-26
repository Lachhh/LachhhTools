package com.kojaktsl.TwitterAPI {
	/**
	 * @author Shayne
	 */
	public class MetaTwitterSearchResults {
		
		var tweetList:Array;
		
		public static function parseFromRawString(data:String):MetaTwitterSearchResults{
			var jsonData:Object = JSON.parse(data);
			return MetaTwitterSearchResults.parseFromRawJSON(jsonData);
		}
		
		public static function parseFromRawJSON(json:Object):MetaTwitterSearchResults{
			var tweetArray:Array = new Array();
			
			var rawTweetObjects:Array = json["statuses"];
			var i:int;
			for(i = 0; i < rawTweetObjects.length; i++){
				tweetArray.push(MetaTweet.parseTweetFromJSON(rawTweetObjects[i]));
			}
			
			var result:MetaTwitterSearchResults = new MetaTwitterSearchResults(tweetArray);
			return result;
		}
		
		public function MetaTwitterSearchResults(tweetList:Array){
			this.tweetList = tweetList;
		}
		
		public function getLastTweet():MetaTweet{
			if(tweetList.length > 0){
				return tweetList[0];
			}
			else{
				return null;
			}
		}
		
		public function DEBUGTrace():void{
			var i:int;
			for(i = 0; i < tweetList.length; i++){
				trace(tweetList[i].toString());
			}
		}
		
	}
}
