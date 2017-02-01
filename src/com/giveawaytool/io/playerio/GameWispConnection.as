package com.giveawaytool.io.playerio {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;

	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class GameWispConnection {
		static public var instance: GameWispConnection; 
		
		private var windowOptions : NativeWindowInitOptions;
		private var htmlLoader : HTMLLoader;
		public var accessToken : String;
		public var gameWispSecret : String;
		public var isTokenValid : Boolean;
		private var authCode : String;
		private var callbackOnSuccess : Callback;
		private var callbackOnError : Callback;
		

		static public function getInstance() : GameWispConnection {
			if(instance == null) {
				instance = new GameWispConnection();
			}
			return instance;
		}
		
		public function hasAccessToken():Boolean {
			if(accessToken == "") return false;
			if(accessToken == null) return false;
			return true;
			
		}
		
		public function fecthNewAccessToken(cOnSuccess:Callback, cOnError:Callback) : void {
			callbackOnSuccess = cOnSuccess;
			callbackOnError = cOnError;
			windowOptions = new NativeWindowInitOptions();
			windowOptions.type = NativeWindowType.UTILITY;
			windowOptions.systemChrome = NativeWindowSystemChrome.STANDARD;
			windowOptions.transparent = false;
			windowOptions.resizable = true;
			windowOptions.minimizable = false;
			windowOptions.renderMode = NativeWindowRenderMode.DIRECT;	
			
			htmlLoader = HTMLLoader.createRootWindow(  true, windowOptions, false, new Rectangle( 610, 78, 880, 880) );
			htmlLoader.stage.nativeWindow.alwaysInFront = true;
			htmlLoader.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
			htmlLoader.addEventListener(Event.COMPLETE, onComplete_htmlLoader);

			var request : URLRequest = new URLRequest(); 
			var headers :Array = [ new URLRequestHeader("Client-ID",  VersionInfoDONTSTREAMTHIS.GAMEWISP_ID)];
			
			request.requestHeaders = headers;
			request.method = URLRequestMethod.GET;
			request.url = getConnectURL();

			htmlLoader.load(request);
		}

		private function getConnectURL() : String {
			return "https://api.gamewisp.com/pub/v1/oauth/authorize?client_id=" + VersionInfoDONTSTREAMTHIS.GAMEWISP_ID + 
				   "&redirect_uri=" + VersionInfoDONTSTREAMTHIS.GAMEWISP_CLIENT_REDIRECT +
				   "&response_type=code&scope=read_only,subscriber_read_limited&state=ASKDLFJsisisks23k"; 
		}

		private function onComplete_htmlLoader(event : Event) : void {
			trace("onComplete_htmlLoader :  " + htmlLoader.stage.nativeWindow.closed);
			
			if(htmlLoader.stage.nativeWindow.closed) {
				//if(isConnected()) return ;	
				//if(onConnectError) onConnectError.call();	
			}
			
		
		}
		
		private function onLocationChange(event : LocationChangeEvent) : void {
			trace("onLocationChange : " + event.location);
			
			var newUrl:String = event.location;
			var str:String = "http://www.lachhhAndFriends.com/twitch/oauth.html?code=";
			
			if(newUrl.indexOf(str) == 0) {
				
				//onLocationChange : http://www.lachhhAndFriends.com/twitch/oauth.html?code=GxE6QUgUWxlCEbftwGh9XidFMDggYyInGHuttGDc&state=ASKDLFJsisisks23k
				if(newUrl.indexOf("?code=") != -1) {
					var a:Array = newUrl.split("?code=");
					var str1:String = a[1];
					var a2:Array = str1.split("&");
					authCode = a2[0];
					trace(authCode) ;
					onStep1Done();
				} else {
					if(callbackOnError) callbackOnError.call();
				}
				
				htmlLoader.stage.nativeWindow.close();
			
			}
			/*} else if(newUrl == "http://twitch.tv/logout") {
				twitchRedirect = false;
				closeOnNext = true;
			} else if (newUrl == "https://passport.twitch.tv/authentications/new") {
				twitchRedirect = true;	
			} else if(closeOnNext) {
				twitchRedirect = false;
				htmlLoader.stage.nativeWindow.close();
				closeOnNext = false;
				if(onLogout) onLogout.call();
				
			} else {
				twitchRedirect = false;
			}*/
			
			
		}

		private function onStep1Done() : void {
		
			var requestVars:URLVariables = new URLVariables();
			requestVars.grant_type = "authorization_code";
			requestVars.client_id = VersionInfoDONTSTREAMTHIS.GAMEWISP_ID;
			requestVars.client_secret = gameWispSecret;
			requestVars.redirect_uri = VersionInfoDONTSTREAMTHIS.GAMEWISP_CLIENT_REDIRECT;
			requestVars.code = authCode;
			
			
			var url:String = "https://api.gamewisp.com/pub/v1/oauth/token";
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			request.data = requestVars;

			var loader:URLLoader = new URLLoader() ;
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIoError, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onHttpResponseStatus, false, 0, true);
			
			
			loader.load(request);
		}

		private function onHttpResponseStatus(event : HTTPStatusEvent) : void {
			trace("onHttpResponseStatus:" + event.responseURL + "/" + event.responseHeaders + "/" + event.type);
			for (var i : int = 0; i < event.responseHeaders.length; i++) {
				var rh:URLRequestHeader = event.responseHeaders[i] as URLRequestHeader; 
				trace(rh.name + "/" + rh.value);
			}
			
		}

		private function onComplete(event : Event) : void {
			var rawData:String = event.target.data;
			var d:Dictionary = DataManager.stringToDictionnary(rawData);
			trace(d);
			accessToken = d["access_token"];
			isTokenValid = true;
			if(callbackOnSuccess) callbackOnSuccess.call();
		}

		private function onIoError(event : IOErrorEvent) : void {
			trace(event);
			if(callbackOnError) callbackOnError.call();
		}
		
		
		function httpStatusHandler( e:HTTPStatusEvent ):void {
			trace("httpStatusHandler:" + e.status + "/"+  e.responseURL + "/" + e.type);
		}
		function securityErrorHandler( e:SecurityErrorEvent ):void {
			trace("securityErrorHandler:" + e);
		}
		
		public function validateToken(onComplete:Callback):void {
			isTokenValid = false;
			var gameWispValidateTokenRequest : GameWispRequestValidateToken = new GameWispRequestValidateToken(accessToken);
			gameWispValidateTokenRequest.callbackOnSuccess = new Callback(onValidate, this, [gameWispValidateTokenRequest, onComplete]);
			gameWispValidateTokenRequest.callbackOnError = new Callback(onValidate, this, [gameWispValidateTokenRequest, onComplete]);
			gameWispValidateTokenRequest.loadRequest();
		}

		private function onValidate(request:GameWispRequestValidateToken, callback:Callback) : void {
			isTokenValid = request.isTokenValid;
			if(callback) callback.call();
		}
	}
}
