package com.giveawaytool.meta.twitch {
	import com.lachhh.lachhhengine.DataManager;
	import flash.events.Event;
	import flash.display.Bitmap;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.io.Callback;
	import com.lachhh.io.CallbackGroup;
	import flash.display.BitmapData;
	/**
	 * @author Eel
	 */
	public class TwitchRequestEmoteBitmap {
		
		public var id:int = -1;
		public var bitmapResult:BitmapData;
		
		public var onComplete:CallbackGroup = new CallbackGroup();
		public var onError:CallbackGroup = new CallbackGroup();
		
		public function TwitchRequestEmoteBitmap(pId:int){
			id = pId;
		}
		
		public function sendRequest(complete:Callback, error:Callback):void{
			if(complete) onComplete.addCallback(complete);
			if(error) onError.addCallback(error);
			
			var url:String = VersionInfo.URL_TWITCH_EMOTE_TEMPLATE;
			url = url.replace("[EMOTE_ID]", id+"");
			
			DataManager.loadImage(url, new Callback(onBmpLoaded, this, null), new Callback(onIOError, this, null));
		}
		
		function onBmpLoaded(bmp:Bitmap):void{
			bitmapResult = bmp.bitmapData;
			onComplete.call();
		}
		
		function onIOError(event:Event):void{
			trace("IOERROR FETCHING EMOTE IMAGE!");
			trace(event);
			onError.call();
		}
		
		public static function createAndSendRequest(pId:int, success:Callback, error:Callback):TwitchRequestEmoteBitmap{
			var request:TwitchRequestEmoteBitmap = new TwitchRequestEmoteBitmap(pId);
			request.sendRequest(success, error);
			return request;
		}
		
	}
}