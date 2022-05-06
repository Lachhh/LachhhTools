package com.giveawaytool.io.twitch {
	import com.giveawaytool.ui.views.MetaFollowerList;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchRequestFollower {
		const TWITCH_API_BASE:String = "https://api.twitch.tv/helix/users/follows";
		
		private var offSetFollow : String;
		private var twitchConnection : TwitchConnection;
		public var onSuccessCallback:Callback;
		public var onErrorCallback:Callback;
		private var loader:URLLoader;
		
		public var metaDataReceived:MetaFollowerList = new MetaFollowerList() ;
		

		public function TwitchRequestFollower(pTwitchConnection : TwitchConnection) {
			twitchConnection = pTwitchConnection;
		}

		public function fetchLast100Followers() : void {
			offSetFollow = "";
			fecthByBatchOf100();
		}
		
		private function fecthByBatchOf100():void {
			var parameters:String = "?to_id=" + TwitchConnection.getAccountId(); // newest to oldest
			parameters += "&first=" + 100; // how many objects returned. 25 = default, 100 = max
			parameters += "&after=" + offSetFollow; // where to start in the list
			
			var request:URLRequest = new URLRequest(TWITCH_API_BASE + parameters);
			//request.contentType = TWITCH_API_VERSION;
			
			loader = new URLLoader() ;
			var headers :Array = twitchConnection.getHeaders();
			
			request.requestHeaders = headers;
			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onLoadedGetFollowerRequest);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}
		
		function onLoadedGetFollowerRequest(event:Event):void{
			metaDataReceived = MetaFollowerList.createFromTwitchData(loader.data);
			
			if(onSuccessCallback) onSuccessCallback.call();
		}
		
		function onIOError(event:Event):void{
			trace("IOERROR!");
			trace(event);
			if(onErrorCallback) onErrorCallback.call();
		}
	}
}
