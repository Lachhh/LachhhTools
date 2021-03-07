package com {
	import com.giveawaytool.MainGameTools;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.io.Callback;
	import com.lachhh.utils.Utils;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchLachhhIsLiveSimpleCheckUp {
		static public var isLachhLive : Boolean = false;
		static public var onRefreshed:Callback;
		
		static private var checkTimer:CallbackTimerEffect;
		
		static public function checkIfChannelIsLive(onComplete:Function, onError:Function):void{
			var url:String ;
			//if(VersionInfo.modelExternalAPI.id == ModelExternalPremiumAPIEnum.YAHOO.id) {
			//	url = "https://yahoogames.fgl.com/zombidle/twitch.php?channelName=" + name;
			//} else {
			// 	url = "http://www.zombidle.com/assets/twitch.php?channelName=" + name;
			//}
			
			url = "https://knightsofthestream.com/api/1/team/live";
			
		   var request:URLRequest = new URLRequest(url);
		   var loader:URLLoader = new URLLoader();
		   
		   loader.addEventListener(Event.COMPLETE, onComplete);
		   loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		   
		   loader.load(request);
		}
		
		static public function checkIfDevsAreLive():void{
			if(checkTimer) return;
			checkTimer = CallbackTimerEffect.addWaitCallbackToActor(MainGameTools.dummyActor, new Callback(onTimer, TwitchLachhhIsLiveSimpleCheckUp, null), 1000*60*5);
			checkTimer.isLoop = true;
			onTimer();
		}
		
		static private function onTimer():void{
			checkIfChannelIsLive(onChannelInfo, onChannelInfoError);
		}
		
		static private function onChannelInfoError(event : Event) : void {
			// do nothing
		}
	  
	 	static public function onChannelInfo(event:Event) : void {
		    var loader:URLLoader = URLLoader(event.target);
			var list:Array;
			try {
		    	list = getStreamsLiveList(loader);
			} catch(e:Error) {
				trace(e);
			}
			
			isLachhLive = (list != null && Utils.IsInArray(list, "lachhh"));
			
			
			if(onRefreshed) onRefreshed.call();
	 	 }
		 
		 static private function getStreamsLiveList(loader:URLLoader):Array{;
			var obj:Object = FlashUtils.myJSONParse(loader.data);
			var data:Object = obj["data"];
			if(data){
				var streams:Array = data["streams"] as Array;
				if(streams){
					trace(streams);
					return streams;
				}
			}
			
			return new Array();
		 }
	}
}
