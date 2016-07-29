package com.giveawaytool.io.twitch {
	
	public class MetaTwitchAPIFollowerData_DEPRECATED {
		public var names:Array = new Array();
		public var followerDates:Array = new Array();
		public var totalFollowers:int = 0;
		
		public function MetaTwitchAPIFollowerData_DEPRECATED() {
			
		}
		
		
		public function decode(data:String):void {
			var jsonData:Object = JSON.parse(data);
			names = parseNamesFromRawData(jsonData);
			totalFollowers = parseTotalFollowersFromRawData(jsonData);
			followerDates = parseLastFollowerDateFromRawData(jsonData);
		}
		
		function parseNamesFromRawData(data:Object):Array{
			var result:Array = new Array();

			var rawFollowObjects:Array = data["follows"];
			var i:int;
			for(i = 0; i < rawFollowObjects.length; i++){
				var userName:String = rawFollowObjects[i]["user"]["name"];
				result.push(userName);
			}
			
			return result;
		}
		
		function parseTotalFollowersFromRawData(data:Object):int{
			return data["_total"];
		}
		
		function parseLastFollowerDateFromRawData(data:Object):Array{
			var result:Array = new Array();
			
			var rawFollowObjects:Array = data["follows"];
			var i:int;
			for(i = 0; i < rawFollowObjects.length; i++){
				var rawDateString:String = rawFollowObjects[i]["created_at"];
				result.push(parseDateFromTwitchFormat(rawDateString));
			}
			
			return result;
		}
		
		function parseDateFromTwitchFormat(rawDateString:String):Date{
			var dateTimeSplitIndex = rawDateString.indexOf("T");
			var yearMonthDay:String = rawDateString.substring(0, dateTimeSplitIndex);
			
			var hourMinuteSecond:String = rawDateString.substring(dateTimeSplitIndex+1, rawDateString.length-1);
			
			yearMonthDay = yearMonthDay.replace(/-/g, "/");
			
			var parseDateString:String = yearMonthDay + " " + hourMinuteSecond;
			
			var totalMilliseconds:Number = Date.parse(parseDateString);
			
			var result:Date = new Date();
			result.setTime(totalMilliseconds);
			
			return result;
		}

	}
	
}
