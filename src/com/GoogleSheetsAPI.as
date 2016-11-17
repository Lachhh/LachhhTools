package com {
	import com.lachhh.io.Callback;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import com.lachhh.io.CallbackGroup;
	/**
	 * @author Eel
	 */
	public class GoogleSheetsAPI {
		
		private const sheetAPIRoot:String = "https://sheets.googleapis.com/v4/spreadsheets/";
		
		public var onFinishedCallback:CallbackGroup = new CallbackGroup();
		public var onErrorCallback:CallbackGroup = new CallbackGroup();
		
		private var _isInit:Boolean = false;
		
		private var sheetID:String;
		private var apiKey:String;
		
		public function GoogleSheetsAPI(){
			
		}
		
		public function init(pSheetID:String, pApiKey:String):void{
			sheetID = pSheetID;
			apiKey = pApiKey;
			_isInit = true;
		}
		
		public function loadSheetData(sheetName:String, onFinishedCb:Callback = null, onErrorCb:Callback = null):void{
			var url:String = buildURL(sheetName);
			var loader:URLLoader = new URLLoader();
			var request : URLRequest = new URLRequest(url);
			loader.addEventListener(Event.COMPLETE, onResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.load(request);
			onFinishedCallback.addCallback(onFinishedCb);
			onErrorCallback.addCallback(onErrorCb);
		}
		
		public function buildURL(sheetName:String):String{
			return sheetAPIRoot + sheetID + "/values/" + sheetName + "?key=" + apiKey;
		}
		
		private function onResponse(event:Event):void{
			var loader:URLLoader = URLLoader(event.target);
			var data:Object = JSON.parse(loader.data);
			onFinishedCallback.callWithParams([data]);
		}
		
		private function onError(event:Event):void{
			trace(event);
			onErrorCallback.call();
		}
		
		public function get isInit():Boolean{
			return _isInit;
		}
		
	}
}