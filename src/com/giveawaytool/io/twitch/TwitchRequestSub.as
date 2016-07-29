package com.giveawaytool.io.twitch {
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchRequestSub {
		private var offSetSub : int;
		private var listOfSubs : MetaSubscribersList;
		private var twitchConnection : TwitchConnection;
		public var onConnectCallback:Callback;
		public var onErrorCallback:Callback;
		
		public function TwitchRequestSub(pTwitchConnection:TwitchConnection) {
			twitchConnection = pTwitchConnection;
		}

		public function fetchListOfSubsAdmin() : void {
			offSetSub = 0;
			listOfSubs = new MetaSubscribersList();
			fecthByBatchOf100();
		}
		
		private function fecthByBatchOf100():void {
			var url:String = "https://api.twitch.tv/kraken/channels/" + twitchConnection.getNameOfAccount() + "/subscriptions?oauth_token=" + twitchConnection.accessToken + "&scope=user_read&limit=250&offset="+offSetSub;
			var loader:URLLoader = new URLLoader() ;
			loader.load(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, onFetchListOfSubsAdmin);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}

		private function onError(event : IOErrorEvent) : void {
			if(onErrorCallback) onErrorCallback.call();
		}
		

		private function onFetchListOfSubsAdmin(event : Event) : void {
			var rawData:String = event.target.data;
			var d:Dictionary = DataManager.stringToDictionnary(rawData);
			var subs:Dictionary = d.subscriptions;
			var i:int = 0;
			
			while(subs[i] != null) {
				var aSub:Dictionary = subs[i];
				var aUser:Dictionary = aSub.user;
				var userName:String = aUser.name;
				listOfSubs.add(MetaSubscriber.create2(userName));
				i++;
			}
			
			if(i >= 100) {
				offSetSub += 100;
				fecthByBatchOf100();
			} else {
				if(onConnectCallback) onConnectCallback.call();
			}	
		}
		
		public function getListOfSub():MetaSubscribersList {
			return listOfSubs;
		}
	}
}
