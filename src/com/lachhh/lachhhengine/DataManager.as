package com.lachhh.lachhhengine {
	import com.lachhh.io.Callback;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class DataManager {
		static private var GAME_NAME:String = "GAME" ;
		static private var DATANAME:String = "GAMEDATA_FGL" ;
		static private var _sharedObject:SharedObject = SharedObject.getLocal(GAME_NAME);
		static public var isEmpty:Boolean = (_sharedObject.data[DATANAME] == "" || _sharedObject.data[DATANAME] == null);
		
		static public var loadedData:String ;
		static public var lastError:Error;
		static public var loader:URLLoader;
		
		static public function save(string:String):void {
			_sharedObject.data[DATANAME] = string;
		 	_sharedObject.flush();
		}
		
		static private function loadSharedObject():String {
			return _sharedObject.data[DATANAME];
		}
		
		static public function loadLocally():Dictionary {
			return stringToDictionnary(DataManager.loadSharedObject());
		}
		
		static public function saveLocally(d:Dictionary):void {
			var obj:Object = dictToObject(d); 
			save(JSON.stringify(obj));
		}
		
		static private function stringToJSON(string:String):Object {
			return JSON.parse(string);
		}
		
		static public function stringToDictionnary(string:String):Dictionary {
			return objToDictionary(stringToJSON(string));
		}
		
		static public function objToDictionary(obj:Object):Dictionary {
			var result:Dictionary = new Dictionary();
			for (var index : String in obj) {
				var child:Object = obj[index];
				switch(true) {
					case child is Number :
					case child is int :  
					case child is String : 
					case child is Boolean : result[index] = child; break; 
					case child is Object : result[index] = objToDictionary(child); break;  
				}
			}
			return result;
		}
		
		static public function dictToObject(obj:Dictionary):Object{
			var result:Object = new Object();
			for (var index : String in obj) {
				var child:Object = obj[index];
				switch(true) {
					case child is Number :
					case child is int :  
					case child is String : 
					case child is Boolean : result[index] = child; break;
					//case child is Array : result[index] = child; break;
					case child is Dictionary : result[index] = dictToObject(child as Dictionary); break;  
				}
			}
			return result;
		}
		
		static public function loadExternalNames(channelName:String, success:Callback, error:Callback):void {
			var url:String = "https://tmi.twitch.tv/group/user/" +  channelName.toLocaleLowerCase() + "/chatters";
			var request:URLRequest = new URLRequest(url);
			var onDataLoaded:Function = function (event:Event) : void {
			 	var loader:URLLoader = URLLoader(event.target);
			 	loadedData = loader.data;
				DataManager.cancel();
			 	if(success) success.call();  
			};
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onDataLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, error.onEvent);
			loader.load(request);
		}
		
		static public function cancel():void {
			if(loader) {
				loader.close();
				loader = null;
			}
		}
		
		static public function loadImage(url:String, success:Callback, error:Callback):void {
			var loader:Loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
				function (event : Event) : void {
					success.callWithParams([loader.content as Bitmap]);
				});
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, error.onEvent);
			loader.load(new URLRequest(url));
		}
	  
	}
}
