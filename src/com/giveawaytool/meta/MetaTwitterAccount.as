package com.giveawaytool.meta {
	import isle.susisu.twitter.Twitter;
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.events.TwitterErrorEvent;
	import isle.susisu.twitter.events.TwitterRequestEvent;

	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaTwitterAccount {
		public var accountName:String = "";
		public var accessToken:String = "";
		public var accessTokenSecret:String = "";
		public var twitter:Twitter ;
		public var twitterRequest:TwitterRequest ;
		public var callbackRefresh:Callback ;
		public var isLoading:Boolean = false;
		public var infos:Object;
		public var bmp:Bitmap ;
		public var error:TwitterErrorEvent;
		
		private var saveData : Dictionary = new Dictionary();
		
		public function encode():Dictionary {
			saveData["accountName"] = accountName;
			saveData["accessToken"] = accessToken;
			saveData["accessTokenSecret"] = accessTokenSecret;
			
			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			accountName = obj["accountName"];
			accessToken = obj["accessToken"];
			accessTokenSecret = obj["accessTokenSecret"];
			
			fetchInfo();
		}
		
		public function refresh():void {
			bmp = null;
			error = null;
			fetchInfo();
			
		}
		
		public function fetchInfo():void {
			twitter = new Twitter(VersionInfo.TWITTER_CONSUMER_KEY, VersionInfo.TWITTER_CONSUMER_KEY_SECRET, accessToken, accessTokenSecret);
			twitterRequest = twitter.account_getSettings();
			twitterRequest.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onTwitterError);
			twitterRequest.addEventListener(TwitterRequestEvent.COMPLETE, onComplete);
			isLoading = true;
		}

		private function onComplete(event : TwitterRequestEvent) : void {
			//trace(twitterRequest.response);	
			var d:Object = JSON.parse(twitterRequest.response);
			accountName = d["screen_name"];
			
			twitterRequest = twitter.users_show(accountName, accountName);
			twitterRequest.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onTwitterError);
			twitterRequest.addEventListener(TwitterRequestEvent.COMPLETE, onCompleteInfos);
			if(callbackRefresh) callbackRefresh.call();
		}

		private function onCompleteInfos(event : TwitterRequestEvent) : void {
			//trace(twitterRequest.response);
			infos = JSON.parse(twitterRequest.response);
			var url:String = infos.profile_image_url;
			DataManager.loadImage(url, new Callback(onBmpLoaded, this, null), new Callback(onError, this, null));
		}
		
		public function onBmpLoaded(pBmp:Bitmap):void {
			bmp = pBmp;
			isLoading = false;
			if(callbackRefresh) callbackRefresh.call();
		}
		
		public function getURL():String {
			return "http://www.twitter.com/" + accountName;
		}
		
		private function onTwitterError(event : TwitterErrorEvent):void {
			isLoading = false;
			error = event;
			if(callbackRefresh) callbackRefresh.call();
		}
		
		private function onError():void {
			isLoading = false;
			if(callbackRefresh) callbackRefresh.call();
		}
	}
}
