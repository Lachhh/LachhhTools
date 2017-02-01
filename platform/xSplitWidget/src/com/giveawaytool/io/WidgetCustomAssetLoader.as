package com.giveawaytool.io {
	import com.lachhh.io.SimpleSocket;
	import flash.utils.Dictionary;
	import flash.display.LoaderInfo;
	import com.giveawaytool.MainGame;
	import com.lachhh.io.Callback;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	/**
	 * @author miso
	 */
	public class WidgetCustomAssetLoader {
		
		private var loader:Loader;
	
		private var callbackLoadingError : Callback;
		private var callbackLoadingSuccess: Callback;
		public var dataPath : String;
		public var isLoaded : Boolean = false;
		public var content : DisplayObject;
		public var loaderInfo : LoaderInfo;

		public function WidgetCustomAssetLoader(pDataPAth : String) {
			dataPath = pDataPAth;
		}

		public function loadAssets(callback : Callback, callbackError : Callback = null) : void {
			
			Security.allowDomain("*");
			SimpleSocket.DEBUGTRACE("DataPath : " + dataPath); 
			callbackLoadingSuccess = callback;
			callbackLoadingSuccess = callback;
			callbackLoadingError = callbackError;
			unloadAssets();
			var dloader:URLLoader = new URLLoader();
			dloader.dataFormat = URLLoaderDataFormat.BINARY;
			dloader.addEventListener(Event.COMPLETE, dloaderCompleteHandler);
			dloader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			dloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			dloader.load(new URLRequest(dataPath));		
		}
		
		private function dloaderCompleteHandler(event:Event):void {
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			context.allowCodeImport = true;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			loader.loadBytes(event.target.data, context);	
		}

		private function onIoError(event : IOErrorEvent) : void {
			trace("onIoError : " + dataPath);
			if(callbackLoadingError) {
				callbackLoadingError.call();
				callbackLoadingError = null;
			}
		}
		
		private function onSecurityError(event : Event) : void {
			trace("onSecurityError : " + dataPath);
			if(callbackLoadingError) {
				callbackLoadingError.call();
				callbackLoadingError = null;
			}
		}
		
		private function loaderCompleteHandler(event:Event):void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			loaderInfo = event.target as LoaderInfo;
			content = loaderInfo.content;
			if(callbackLoadingSuccess) callbackLoadingSuccess.call();
		}
		
		public function get assetLoader():Loader { return loader; }
		
		public function unloadAssets():void {
			if (loader) {
				loader.unload();
			}
		}
		
	}
}
