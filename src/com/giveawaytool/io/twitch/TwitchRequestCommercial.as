package com.giveawaytool.io.twitch {
	import com.lachhh.io.Callback;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchRequestCommercial {
		private var twitchConnection : TwitchConnection;
		public var onSuccessCallback:Callback;
		public var onErrorCallback:Callback;
		
	
		public function TwitchRequestCommercial(pTwitchConnection : TwitchConnection) {
			twitchConnection = pTwitchConnection;
		}

		public function showCommercial() : void {
			/*var url:String = "https://api.twitch.tv/kraken/channels/" + twitchConnection.getNameOfAccount() + "/commercial?oauth_token=" + twitchConnection.accessToken;
			var loader:URLLoader = new URLLoader() ;
			var urlREQ:URLRequest = new URLRequest(url);
			urlREQ.method = URLRequestMethod.POST ;
			loader.load(urlREQ);
			loader.addEventListener(Event.COMPLETE, onSuccess);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);*/
			
			//https://api.twitch.tv/kraken/channels/" + this.twitchConnection.getNameOfAccount() + "/commercial"
			showCommercial2();	
		}
		
		public function showCommercial2():void {
			var loader:URLLoader = new URLLoader() ;
			var url:String = "https://api.twitch.tv/kraken/channels/" + twitchConnection.getNameOfAccount() + "/commercial";
			var headers:Array = [
			    new URLRequestHeader("Accept", "application/vnd.twitchtv.v3+json"),
			    new URLRequestHeader("Authorization", "OAuth " + this.twitchConnection.accessToken.replace("oauth:",""))
			];
			var requestVars:URLVariables = new URLVariables();
			var urlREQ:URLRequest = new URLRequest(url);
			requestVars.length = "30";
			//and then on the URLRequest variable do
			urlREQ.requestHeaders = headers;
			urlREQ.data = requestVars;
			urlREQ.method = URLRequestMethod.POST;
			loader.load(urlREQ);
			loader.addEventListener(Event.COMPLETE, onSuccess);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onError2);
		}

		private function onError(event : IOErrorEvent) : void {
			//trace(event);
			//PlayerIOZombIdleController.writeErrorMsg(event.toString());
			if(onErrorCallback) onErrorCallback.call();
		}
		
		private function onError2(event : HTTPStatusEvent) : void {
			
		}
		

		private function onSuccess(event : Event) : void {
			if(onSuccessCallback) onSuccessCallback.call();
		}
		
	}
}
