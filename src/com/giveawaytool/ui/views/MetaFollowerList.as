package com.giveawaytool.ui.views {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaFollowerList {
		public var followers : Array = new Array();
		private var saveData : Dictionary;

		public function sortByDate() : void {
			followers.sort(sortDate);
		}
		
		
		public function sortDate(m1:MetaFollower, m2:MetaFollower):int {
			if(m1.date.time < m2.date.time) return 1;
			if(m1.date.time > m2.date.time) return -1;
			return 0;
		}
		
		public function addCopyAsNew(m:MetaFollower):void {
			var newDonation:MetaFollower = m.clone();
			newDonation.isNew = true;
			add(newDonation);
		}
		
		public function add(metaFollower : MetaFollower) : void {
			followers.push(metaFollower);
		}
		
		public function clone(otherList : MetaFollowerList) : void {
			decode(otherList.encode());
		}
				
		public function hasFollower(m:MetaFollower):Boolean {
			for (var i : int = 0; i < followers.length; i++) {
				var metaFollower:MetaFollower = followers[i];
				if(metaFollower.isEquals(m)) return true;
			}
			return false;
		}
		
		public function encode():Dictionary {
			saveData = new Dictionary();
			for (var i : int = 0; i < followers.length; i++) {
				var donation:MetaFollower = followers[i];
				saveData["follower"+i] = donation.encode();	
			}
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			followers = new Array();
			if(loadData == null) return ;
			var i:int = 0;
			while(loadData["follower" + i] != null) {
				var d:Dictionary = loadData["follower" + i];
				followers.push(MetaFollower.create(d));
				i++;
			}
			
		}
				
		public function getMetaFollower(i:int):MetaFollower {
			if(i < 0) return MetaFollower.NULL;
			if(i >= followers.length) return MetaFollower.NULL;
			return followers[i];
			
		}
		
		public function copyKeepingOnlyNew() : MetaFollowerList {
			var result : MetaFollowerList = new MetaFollowerList();
			for (var i : int = 0; i < followers.length; i++) {
				var d:MetaFollower = followers[i];
				if(d.isNew) {
					result.followers.push(d);
				}
			}
			return result;
		}
		
		public function remove(m:MetaFollower):void {
			var i:int = followers.indexOf(m);
			if(i != -1) followers.splice(i,1);
		}
		
		
		
		public function getAmountTotalOfNew():Number {
			var result:Number = 0;
			for (var i : int = 0; i < followers.length; i++) {
				var metaFollower:MetaFollower = followers[i];
				if(metaFollower.isNew) {
					result++;
				}
			} 
			return result;
		}

		public function setAllNew(b : Boolean) : void {
			for (var i : int = 0; i < followers.length; i++) {
				var metaFollower:MetaFollower = followers[i];
				metaFollower.isNew = b;
			}
		}

		public function containsName(name:String):Boolean {
			for (var i : int = 0; i < followers.length; i++) {
				var metaFollower:MetaFollower = followers[i];
				if(metaFollower.name == name) return true;
			}
			return false;
		}
		
		public function addIfNameNotInList(metaFollower : MetaFollower) : Boolean {
			if(containsName(metaFollower.name)) return false;
			add(metaFollower);
			return true;
		}
		
		public function isEmpty():Boolean {
			return followers.length <= 0;
		}
		
		static public function createFromTwitchData(data:String):MetaFollowerList {
			var jsonData:Object = JSON.parse(data);
			var result:MetaFollowerList = new MetaFollowerList();
			var rawFollowObjects:Array = jsonData["data"];
			var pagination:Object = jsonData["pagination"];
			var total:int = jsonData["total"] as int;
			var cursorString = pagination["cursor"];
			TwitchConnection.instance.channelData.numFollowers = total;
			
			var i:int;
			if(rawFollowObjects == null) return result;
			for(i = 0; i < rawFollowObjects.length; i++){
				var name:String = rawFollowObjects[i]["from_name"];
				var rawDateString:String = rawFollowObjects[i]["followed_at"];
				var date:Date = parseDateFromTwitchFormat(rawDateString);
				var metaFollow:MetaFollower = MetaFollower.create2(name, date);
				metaFollow.isNew = false;
				result.add(metaFollow);
			}
			result.sortByDate();
			return result;
		}
			
		static private function parseDateFromTwitchFormat(rawDateString:String):Date{
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
