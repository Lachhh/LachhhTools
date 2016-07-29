package com.giveawaytool.io.twitch {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	
	public class SimpleTwitchAPI_DEPRECATED {
		
		const TWITCH_API_BASE:String = "https://api.twitch.tv/kraken/";
		const TWITCH_API_VERSION:String = "application/vnd.twitchtv.v3+json";
		
		// http://www.twitch.tv/settings/connections // register your program here for clientID
		// http://www.twitch.tv/kraken/oauth2/clients/new // direct link to 'new application registration' page
		
		
		// User-specific application-specific oauth token.
		// https://github.com/justintv/Twitch-API/blob/master/authentication.md
		// just to test it out, I directly pasted the authentication URL into chrome, and copied the access_token it generated
		// i.e. I went to https://api.twitch.tv/kraken/oauth2/authorize
		//					?response_type=token
		//					&client_id=[your client ID]
		//					&redirect_uri=[your registered redirect URI]
		//					&scope=[space separated list of scopes]
		//
		// with channel_subscriptions+user_subscriptions+channel_check_subscription listed for &scope=
		//
		// and copied the resulting access_token inside https://[your registered redirect URI]/
		//														#access_token=[an access token]
		//														&scope=[authorized scopes]
		// to the variable below.
		//
		// also I couldn't get it to work. So I may have done something very wrong XD
		//const TWITCH_DEV_ACCESS_TOKEN:String = "<oauth user access token>"; // <-- literally not used yet
		
		var loader:URLLoader;
		
		public var lastDataRecieved:String;
		//public var callbackOnDataLoaded:Callback; // uncomment
		
		public var DEBUG_newfollowerchecker:LogicFollowAlert; // you can safely remove this

		public function SimpleTwitchAPI_DEPRECATED() {
			
		}
		
		public function SendGetFollowersRequest(limit:int = 25, offset:int = 0):Array{
			var result:Array = new Array();
			if(!TwitchConnection.instance.isConnected()) return result;
			var parameters:String = "?direction=DESC"; // newest to oldest
			parameters += "&limit=" + limit; // how many objects returned. 25 = default, 100 = max
			parameters += "&offset=" + offset; // where to start in the list
			parameters += "&client_id=" + VersionInfoDONOTSTREAM_Twitch.TPZ_CLIENT_LNF_ID; // for good measure
			
			var request:URLRequest = new URLRequest(TWITCH_API_BASE + "channels/" + TwitchConnection.instance.getNameOfAccount() + "/follows" + parameters);
			request.contentType = TWITCH_API_VERSION;
			
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, OnLoadedGetFollowerRequest);
			loader.addEventListener(IOErrorEvent.IO_ERROR, OnIOError);
			loader.load(request);
			
			return result;
		}
		

		public function GetLastDataRecieved():String{
			return lastDataRecieved;
		}
		
		public function DEBUG_UPDATE_SimpleCheckForNewFollowers():void{
			DEBUG_newfollowerchecker.OnDataLoaded();
		}
		
		function OnLoadedGetFollowerRequest(event:Event):void{
		
			lastDataRecieved = loader.data;
			DEBUG_UPDATE_SimpleCheckForNewFollowers(); // this is here because I don't have callbacks
		}
			
		function OnIOError(event:Event):void{
			trace("IOERROR!");
			trace(event);
		}
		
	}
	
}
