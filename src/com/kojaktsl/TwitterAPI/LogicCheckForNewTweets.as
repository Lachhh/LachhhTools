package com.kojaktsl.TwitterAPI {
	import isle.susisu.twitter.Twitter;
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.events.TwitterErrorEvent;
	import isle.susisu.twitter.events.TwitterRequestEvent;

	import com.lachhh.io.Callback;
	/**
	 * @author Shayne
	 */
	public class LogicCheckForNewTweets {
		public var twitter:Twitter;
		public var searchRequest:TwitterRequest;
		public var onNewTweetCallback:Callback;
		
		public var lastTweetRecieved:MetaTweet;
		public var lastSearchResults:MetaTwitterSearchResults;
		
		public function LogicCheckForNewTweets(callback:Callback){
			lastTweetRecieved = null;
			onNewTweetCallback = callback;
		}
		
		
		public function searchTweets(string:String):void{
			try{
				searchRequest = twitter.search_tweets(string);
				searchRequest.addEventListener(TwitterRequestEvent.COMPLETE, onSearchCompleted);
				searchRequest.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onTwitterError);
				searchRequest.addEventListener(TwitterErrorEvent.SERVER_ERROR, onTwitterError);
			}
			catch(e:Error){
				trace(e);
			}
		}
		
		public function onTwitterError(e:TwitterErrorEvent):void{
			//trace(e);
		}
		
		public function onSearchCompleted(e:TwitterRequestEvent):void{
			var response:String = TwitterRequest(e.target).response;
			var results:MetaTwitterSearchResults = MetaTwitterSearchResults.parseFromRawString(response);
			
			checkForNewTweets(results);
		}
		
		public function checkForNewTweets(newSearchResults:MetaTwitterSearchResults):void{
			var newLastTweet:MetaTweet = newSearchResults.getLastTweet();
			if(lastTweetRecieved == null){
				lastTweetRecieved = newLastTweet;
				lastSearchResults = newSearchResults;
				if(onNewTweetCallback) onNewTweetCallback.callWithParams([newLastTweet]);
				
			}
			if(newLastTweet == null) return;
			if(!MetaTweet.equal(lastTweetRecieved, newLastTweet)){
				if(lastTweetRecieved.date.time > newLastTweet.date.time){
					return;
				}
				
				var i:int;
				var list:Array = newSearchResults.tweetList;
				for(i = 0; i < list.length; i++){
					var newTweet:MetaTweet = list[i];
					if(newTweet == null){ continue; }
					var reachedOldTweet:Boolean = MetaTweet.equal(lastTweetRecieved, newTweet);
					if(reachedOldTweet){
						break;
					}
					if(onNewTweetCallback) onNewTweetCallback.callWithParams([newTweet]);
				}
				
				lastSearchResults = newSearchResults;
				lastTweetRecieved = newSearchResults.getLastTweet();
			}
			else{
				//trace("no new tweets");
			}
		}
	}
}
