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
			var headers :Array = getHeaders();
			var request:URLRequest = new URLRequest(url);
			request.requestHeaders = headers;
			loader.load(request);

			loader.addEventListener(Event.COMPLETE, onBadgeURLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}

		private function onBadgeURLoaded(event : Event) : void {
			
			var d:Dictionary = DataManager.stringToDictionnary(event.target.data);
			var data:Dictionary = d["data"];
			var data0:Dictionary = findSubBadge(data);
			if(data0 == null) {
				onIOError(null);
				return;
			}
			var versions:Dictionary = data0["versions"];
			var urlBadge1x:String = versions[0]["image_url_1x"];
			var urlBadge2x:String = versions[0]["image_url_2x"];
			var urlBadge4x:String = versions[0]["image_url_4x"];
			DataManager.loadImage(urlBadge1x, new Callback(onBmpLoaded, this, null), new Callback(onIOError, this, null));
		}
		
		private function findSubBadge(dataArray:Dictionary):Dictionary {
			if(dataArray == null) return null;
			var i:int = 0;
			var dataI:Dictionary = dataArray[i];
			while(dataI != null) {
				var set_id:String = dataI["set_id"];
				if(set_id == "subscriber") return dataI;
				i++;
				dataI = dataArray[i];
			}
			return dataArray[0];
		}
		
		private function getUrl():String {
			return "https://api.twitch.tv/helix/chat/badges?broadcaster_id="+TwitchConnection.getAccountId();
		}
		
		public function getHeaders():Array {
			var result :Array = [
			new URLRequestHeader("Authorization",  "Bearer " + twitchConnection.accessToken), 
			new URLRequestHeader("Client-ID",  VersionInfoDONTSTREAMTHIS.TWITCH_CLIENT_ID)];
			return result;
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
