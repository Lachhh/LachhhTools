package com.lachhh.lachhhengine {
	import com.lachhh.io.Callback;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	/**
	 * @author LachhhSSD
	 */
	public class SwfLoaderManager {
		static public var DEFAULT_PATH:String = File.applicationStorageDirectory.nativePath;
		static public var pathOnDisk:String = DEFAULT_PATH;
		
		static private var tempFile:File ;
		static public var saveCompleteCallback:Callback;
		static public var errorCallback:Callback;
		
		//private var _swfExporter:SwfExporter;
		
		//private var _deleteEndCallback:Callback;
		//private var _deleteFile:File;
		//static public var AUTO_OVERWRITE:Boolean = true;
		public function SwfLoaderManager(/*swfExporter:SwfExporter*/) {
		//	_swfExporter = swfExporter;
		}
		
		static public function browseForFile(callback:Callback) : void {
			
			tempFile = new File();
			tempFile.addEventListener(Event.SELECT, function(event : Event) : void {
					SwfLoaderManager.pathOnDisk = tempFile.nativePath ;
					if(callback) callback.call();
				});
			
			var f:FileFilter = new FileFilter("Flash Animation", "*.swf");
			tempFile.browseForOpen("Select Animation Swf", [f]);
			
		}

		static public function loadSwf(url:String, success:Callback, error:Callback):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
				function (event : Event) : void {
					success.callWithParams([loader.content]);
				});
			if(error) loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, error.onEvent);
			loader.load(new URLRequest(url));
		}
		

		
		static private function onLoadError(event : Event) : void {
			trace("ERROR " + event.type);
			if(errorCallback) errorCallback.call();
		}
	}
}
