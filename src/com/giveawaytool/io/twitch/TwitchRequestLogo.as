package com.giveawaytool.io.twitch {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchRequestLogo {
		private var twitchConnection : TwitchConnection;
		public var onSuccessCallback:Callback;
		public var onErrorCallback:Callback;
		
		public var logoBmpData:BitmapData ;
		

		public function TwitchRequestLogo(pTwitchConnection : TwitchConnection) {
			twitchConnection = pTwitchConnection;
		}

		public function fetchLogo(url:String) : void {
			
			DataManager.loadImage(url, new Callback(onBmpLoaded, this, null), new Callback(onIOError, this, null));
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
