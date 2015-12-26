package com.kojaktsl.TwitterAPI {
	/**
	 * @author Shayne
	 */
	public class MetaTweet {		
		public var user:String;
		public var text:String;
		public var date:Date;
		
		public function MetaTweet(user:String, text:String, date:Date){
			this.user = user;
			this.text = text;
			this.date = date;
		}
		
		public function toString():String{
			return user + ": " + text;
		}
		
		public static function parseTweetFromJSON(json:Object):MetaTweet{
			var user:String = json["user"]["screen_name"];
			var text:String = json["text"];
			var date:Date = parseDateFromString(json["created_at"]);
			
			if(json["entities"] != null){
				if(json["entities"]["urls"] != null){
					text = formatURLText(text, json["entities"]["urls"]);
				}
			}
			
			return new MetaTweet(user, text, date);
		}
		
		public static function parseDateFromString(str:String):Date{
			var date:Date = new Date();
			date.setTime(Date.parse(str));
			return date;
		}
		
		public static function formatURLText(text:String, jsonURLs:Object):String{
			var urls:Array = jsonURLs as Array;
			var i:int;
			for(i = 0; i < urls.length; i++){
				var urlEntry:Object = urls[i];
				text = text.replace(urlEntry["url"], urlEntry["display_url"]);
			}
			return text;
		}
		
		public static function equal(tweet1:MetaTweet, tweet2:MetaTweet):Boolean{
			if(tweet1 == null) return false;
			if(tweet2 == null) return false;
			return (tweet1.user == tweet2.user && tweet1.text == tweet2.text);
		}
		
	}
}
