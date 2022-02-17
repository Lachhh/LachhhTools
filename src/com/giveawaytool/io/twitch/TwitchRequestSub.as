package com.giveawaytool.io.twitch {
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchRequestSub {
		private var batchOf : int = 100;
		private var offSetSub : String = "";
		private var listOfSubs : MetaSubscribersList;
		private var twitchConnection : TwitchConnection;
		public var onConnectCallback:Callback;
		public var onErrorCallback:Callback;
		static private var thisDate:Date = new Date();
		
		public function TwitchRequestSub(pTwitchConnection:TwitchConnection) {
			twitchConnection = pTwitchConnection;
		}

		public function fetchListOfSubsAdmin() : void {
			offSetSub = "";
			listOfSubs = new MetaSubscribersList();
			fecthByBatchOf100();
		}
		
		private function fecthByBatchOf100():void {
			var url:String = "https://api.twitch.tv/helix/subscriptions?broadcaster_id=" + TwitchConnection.getAccountId() + "&first="+batchOf+"&after="+offSetSub;
			var loader:URLLoader = new URLLoader() ;
			var headers :Array = twitchConnection.getHeaders();
			
			var request:URLRequest = new URLRequest(url);
			request.requestHeaders = headers;
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, onFetchListOfSubsAdmin);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}

		private function onError(event : IOErrorEvent) : void {
			trace(event.text);
			if(onErrorCallback) onErrorCallback.call();
		}
		

		private function onFetchListOfSubsAdmin(event : Event) : void {
			var rawData:String = event.target.data;
			var d:Dictionary = DataManager.stringToDictionnary(rawData);
			var subs:Dictionary = d.data;
			var i:int = 0;
			
			while(subs[i] != null) {
				var aSub:Dictionary = subs[i];
				//var aUser:Dictionary = aSub.user;
				var userName:String = aSub.user_name;
				/*var created_at:String = aSub.created_at;
				created_at = created_at.substr(0, 10);
				var a:Array = created_at.split("-");
				var dateOfSubStart:Date = new Date(a[0], a[1], a[2]);
				var numMonthInaRow:int = getNumMonth(dateOfSubStart, thisDate);*/
				var metaSub:MetaSubscriber = MetaSubscriber.create2(userName, 1);
				//metaSub.date = dateOfSubStart;
				listOfSubs.add(metaSub);
				i++;
			}
			var pagination = d["pagination"];
			var cursor = pagination["cursor"];
			offSetSub = (cursor != null ? cursor : "");
			
			if(i >= batchOf) {
				fecthByBatchOf100();
			} else {
				if(onConnectCallback) onConnectCallback.call();
			}	
		}
		
		public function getNumMonth(d1:Date, d2:Date):int {
			var months:int = 0;
		    months = (d2.getFullYear() - d1.getFullYear()) * 12;
		    months -= d1.getMonth() + 1;
		    months += d2.getMonth();
		    return months <= 0 ? 0 : (months+1);
		}
		
		public function getListOfSub():MetaSubscribersList {
			return listOfSubs;
		}
	}
}
