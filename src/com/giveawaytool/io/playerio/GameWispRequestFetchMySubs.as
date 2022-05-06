package com.giveawaytool.io.playerio {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class GameWispRequestFetchMySubs {
		public var rawData : String ;
		public var callbackOnSuccess : Callback;
		public var callbackOnError : Callback;
		private var accessToken : String;
		public var metaChannelSubsGroup : MetLachhhToolSubGroup;
		private var metaChannelInfo : MetaGameWispChannelInfo;
		private var cursor : String;
		private var limit : int = 50;

		public function GameWispRequestFetchMySubs(pAccessToken : String, pMetaChannelInfo : MetaGameWispChannelInfo) {
			accessToken = pAccessToken;
			metaChannelInfo = pMetaChannelInfo;
		}

		public function loadRequest() : void {		
			cursor = "";	
			metaChannelSubsGroup = new MetLachhhToolSubGroup();
			loadRequestNextCursor();
		}
		
		private function loadRequestNextCursor() : void {		
			var url:String = buildFetchSubsRequestURL();
			var request:URLRequest = new URLRequest(url);

			var loader : URLLoader = new URLLoader() ;
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIoError, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onHttpResponseStatus, false, 0, true);
			loader.load(request);
		}

		private function onComplete(event : Event) : void {
			var metaChannelSubsGroupBatch:MetLachhhToolSubGroup = new MetLachhhToolSubGroup();
			try {
				rawData = event.target.data;
				var d:Dictionary = DataManager.stringToDictionnary(rawData);
				metaChannelSubsGroupBatch = MetLachhhToolSubGroup.createFromRawData(d);
			} catch(e:Error) {
				
			}
			
			metaChannelSubsGroup.append(metaChannelSubsGroupBatch);
			if(metaChannelSubsGroupBatch.listOfSub.length >= limit) {
				cursor = "";
				loadRequestNextCursor();
			} else {
				if(callbackOnSuccess) callbackOnSuccess.call();
			}
		}
		
		private function isDataValid(rawData:Dictionary):Boolean {
			 if(rawData == null) return false;
			 if(rawData["result"] == null) return false;
			 if(rawData["data"] == null) return false;
			 return true;	 
		}
		

		private function onIoError(event : IOErrorEvent) : void {
			if(callbackOnError) callbackOnError.call();
		}

		private function httpStatusHandler(event : HTTPStatusEvent) : void {
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
		}

		private function onHttpResponseStatus(event : HTTPStatusEvent) : void {
		}
		
		public function buildFetchSubsRequestURL():String {
			var result:String = "https://api.gamewisp.com/pub/v1/channel/subscribers?access_token=" + accessToken + "&limit=" + limit + "&order=asc&status=active,grace_period&include=user";
			if(cursor != "") result += "&cursor=" + cursor;
			return result;
			
		}
	}
}
