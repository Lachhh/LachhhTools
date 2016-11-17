package com.giveawaytool.io.twitch {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchRequestSubBadge {
		private var twitchConnection : TwitchConnection;
		public var onSuccessCallback:Callback;
		public var onErrorCallback:Callback;
		
		public var logoBmpData:BitmapData ;
		

		public function TwitchRequestSubBadge(pTwitchConnection : TwitchConnection) {
			twitchConnection = pTwitchConnection;
		}

		public function fetchLogo() : void {
			if(!twitchConnection.isLoggedIn) return ;
			
			var url:String = getUrl();
			var loader:URLLoader = new URLLoader() ;
			var headers :Array = [ new URLRequestHeader("Client-ID",  VersionInfoDONTSTREAMTHIS.LANF_ID)];
			var request:URLRequest = new URLRequest(url);
			request.requestHeaders = headers;
			loader.load(request);

			loader.addEventListener(Event.COMPLETE, onBadgeURLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}

		private function onBadgeURLoaded(event : Event) : void {
			
			var d:Dictionary = DataManager.stringToDictionnary(event.target.data);
			var sub:Dictionary = d["subscriber"];
			var urlBadge:String = sub["image"];
			DataManager.loadImage(urlBadge, new Callback(onBmpLoaded, this, null), new Callback(onIOError, this, null));
		}
		
		private function getUrl():String {
			return "https://api.twitch.tv/kraken/chat/" + TwitchConnection.getNameOfAccount() + "/badges";
		}
		
		
		function onBmpLoaded(bmp:Bitmap):void{
			logoBmpData = bmp.bitmapData;
			if(onSuccessCallback) onSuccessCallback.call();
		}
		
		function onIOError(event:Event):void{
			trace("IOERROR!");
			trace(event);
			if(onErrorCallback) onErrorCallback.call();
		}
	}
}
