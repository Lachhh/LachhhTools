package com.giveawaytool.io {
	import com.lachhh.io.CallbackGroup;
	import com.lachhh.io.Callback;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * @author LachhhSSD
	 */
	public class DonationSourceRequest {
		public var isLoading:Boolean = false;
		public var url:String;
		public var rawData : Object;
		public var errorMsg : IOErrorEvent;
		
		public var onSuccess:CallbackGroup = new CallbackGroup();
		public var onError:CallbackGroup = new CallbackGroup();
		private var loader : URLLoader;
		
		
		
		public function DonationSourceRequest(pUrl:String) {
			isLoading = false;
			url = pUrl;
		}
		
		public function sendRequest():void {
			var request:URLRequest = new URLRequest(url);
			trace("Send Request : " + url);
			var onDataLoaded:Function = function (event:Event) : void {
			 	var loader:URLLoader = URLLoader(event.target);
				rawData = loader.data;
				isLoading = false;
			 	onSuccess.call();  
			};
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onDataLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
				errorMsg = e;
				isLoading = false;
				
				onError.call();
			}
			);
			isLoading = true;
			loader.load(request);
		}

	}
}
