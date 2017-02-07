package com.giveawaytool.io.twitch.streamlabs {
	import playerio.Message;

	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.giveawaytool.io.playerio.MetaServerProgress;
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
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class StreamLabsConnection {
		static public var instance:StreamLabsConnection;
		public var accessToken : String ;
		public var authCode : String ;
		
		
		private var htmlLoader : HTMLLoader;
		private var windowOptions : NativeWindowInitOptions;
		public var onConnect:Callback;
		public var onConnectError : Callback;
		public var connectErrorMsg : String = "";
		public var onLogout : Callback;
		public var isLoggedIn : Boolean = false;
		private var closeOnNext : Boolean;
		private var isTokenValid : Boolean;

		public function StreamLabsConnection() {
			accessToken = "";
			authCode = "";
		}
		
		public function clear():void {
			accessToken = "";
			authCode = "";
			isLoggedIn = false;
		}
		
		public function showLogin():void {
			connectStep1FetchAuthCode();
		}
		
		public function connectStep1FetchAuthCode():void {
			windowOptions = new NativeWindowInitOptions();
			windowOptions.type = NativeWindowType.UTILITY;
			windowOptions.systemChrome = NativeWindowSystemChrome.STANDARD;
			windowOptions.transparent = false;
			windowOptions.resizable = true;
			windowOptions.minimizable = false;
			windowOptions.renderMode = NativeWindowRenderMode.DIRECT;	
			
			htmlLoader = HTMLLoader.createRootWindow(  true, windowOptions, false, new Rectangle( 610, 78, 780, 580) );
			//htmlLoader.paintsDefaultBackground = false;
			htmlLoader.stage.nativeWindow.alwaysInFront = true;
			htmlLoader.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
			htmlLoader.addEventListener(Event.COMPLETE, onComplete_htmlLoader);
			
			var request : URLRequest = new URLRequest(); 
			/*var headers :Array = [ new URLRequestHeader("Client-ID",  VersionInfoDONTSTREAMTHIS.LANF_ID)];*/
			
			/*request.requestHeaders = headers;
			request.method = URLRequestMethod.GET; */
			request.url = getConnectURL();
			
			htmlLoader.load(request);
		}
		
		/*public function logout(c:Callback):void {
			windowOptions = new NativeWindowInitOptions();
			windowOptions.type = NativeWindowType.UTILITY;
			windowOptions.systemChrome = NativeWindowSystemChrome.STANDARD;
			windowOptions.transparent = false;
			windowOptions.resizable = true;
			windowOptions.minimizable = false;
			
			windowOptions.renderMode = NativeWindowRenderMode.DIRECT;	
			
			
			htmlLoader = HTMLLoader.createRootWindow(  true, windowOptions, false, new Rectangle( 610, 78, 780, 680) );
			//htmlLoader.paintsDefaultBackground = false;
			
			htmlLoader.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
			//htmlLoader.addEventListener(Event.COMPLETE, onComplete_htmlLoader);
			
			htmlLoader.load(new URLRequest("http://twitch.tv/logout"));
			onLogout = c;
		}*/
				
		private function onComplete_htmlLoader(event : Event) : void {
			trace("onComplete_htmlLoader :  " + htmlLoader.stage.nativeWindow.closed);
			
			if(htmlLoader.stage.nativeWindow.closed) {
				if(isConnected()) return ;	
				if(onConnectError) onConnectError.call();	
			}
		}
		
	
		
		private function onLocationChange(event : LocationChangeEvent) : void {
			trace("onLocationChange : " + event.location);
			
			var newUrl:String = event.location;
			var str:String = "http://www.lachhhAndFriends.com/twitch/oauth.html";
			if(newUrl.indexOf(str) == 0) {
				if(newUrl.indexOf("?code=") != -1) {
					var a:Array = newUrl.split("?code=");
					var str1:String = a[1];
					var a2:Array = str1.split("&");
					authCode = a2[0];
					//trace(accessToken) ;
					onStep1Done();
				} else {
					//if(onConnectError) onConnectError.call();
				}
				
				htmlLoader.stage.nativeWindow.close();
					 
			} else if(newUrl == "http://twitch.tv/logout") {
				closeOnNext = true;
			} else if(closeOnNext) {
				htmlLoader.stage.nativeWindow.close();
				closeOnNext = false;
				
				clear();
				
				if(onLogout) onLogout.call();
				
			}	
		}
		

		private function onErrorConnectOnStreamLabs(event : Event) : void {
			trace(event);
			if(onConnectError) {
				onConnectError.call();
			}
		}
	 		 
		static public function removeNameFromList(list:Array, name:String):void {
			for (var i : int = 0; i < list.length; i++) {
				var crnt:String = list[i];
				if(crnt.toLowerCase() == name.toLowerCase()) {
					list.splice(i, 1);
					return ;
				}
			}
		}
				
		public function getConnectURL():String {
			var url:String = "https://www.twitchalerts.com/api/v1.0/authorize?response_type=code"; 
			url = url + "&client_id=" + VersionInfoDONTSTREAMTHIS.STREAMLABS_CLIENT_ID ;
			url = url + "&redirect_uri=" + VersionInfoDONTSTREAMTHIS.STREAMLABS_CLIENT_REDIRECT ;
			url = url + "&scope=donations.read";

			return url;
		}
		
		protected function onStep1Done():void {
			MetaServerProgress.instance.getStreamLabsAccessToken(authCode, new Callback(onAuthCodeSendSuccess, this, null), onConnectError);

			/*var requestVars : URLVariables = new URLVariables();
			requestVars.grant_type = "authorization_code";
			requestVars.client_id = VersionInfoDONTSTREAMTHIS.STREAMLABS_CLIENT_ID;
			requestVars.client_secret = "";
			requestVars.redirect_uri = VersionInfoDONTSTREAMTHIS.STREAMLABS_CLIENT_REDIRECT;
			requestVars.code = authCode;
			
			
			var url:String = "https://www.twitchalerts.com/api/v1.0/token";
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			request.data = requestVars;

			var loader:URLLoader = new URLLoader() ;
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIoError, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onHttpResponseStatus, false, 0, true);
			
			
			loader.load(request);*/
		}

		private function onAuthCodeSendSuccess() : void {
			var msg : Message = PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connectionGameRoom.getStreamLabsAccessTokenSuccess.msg;
			accessToken = msg.getString(0);
			if(accessToken != null) {
				isTokenValid = true;
				if(onConnect) onConnect.call();
			} else {
				isTokenValid = false;
				if(onConnectError) onConnectError.call();
			}
		}
		
		public function isConnected():Boolean {
			return accessToken != ""; 
		}
		
		private function onComplete(event : Event) : void {
			var rawData:String = event.target.data;
			var d:Dictionary = DataManager.stringToDictionnary(rawData);
			trace(d);
			accessToken = d["access_token"];
			if(accessToken != null) {
				isTokenValid = true;
				if(onConnect) onConnect.call();
			} else {
				isTokenValid = false;
				if(onConnectError) onConnectError.call();
			}
		}

		private function onIoError(event : IOErrorEvent) : void {
			trace(event);
			if(onConnectError) onConnectError.call();
		}
		
		private function onHttpResponseStatus(event : HTTPStatusEvent) : void {
			trace("onHttpResponseStatus:" + event.responseURL + "/" + event.responseHeaders + "/" + event.type);
			for (var i : int = 0; i < event.responseHeaders.length; i++) {
				var rh:URLRequestHeader = event.responseHeaders[i] as URLRequestHeader; 
				trace(rh.name + "/" + rh.value);
			}
			
		}
		
		function httpStatusHandler( e:HTTPStatusEvent ):void {
			trace("httpStatusHandler:" + e.status + "/"+  e.responseURL + "/" + e.type);
		}
		function securityErrorHandler( e:SecurityErrorEvent ):void {
			trace("securityErrorHandler:" + e);
		}
		
		public function connectStep2FetchDonations():void {
			
		}

		
		public function getAuthToken() : String {
			return accessToken;
		}

		public function get connected() : Boolean {
			return isLoggedIn;
		}

		public function get loggedIn() : Boolean {
			return isLoggedIn;
		}

		public function get nameOfSystem() : String {
			return "Twitch";
		}
		
		static public function getInstance():StreamLabsConnection {
			if(instance == null) instance = new StreamLabsConnection();
			return instance;
		}

		public static function isLoggedIn() : Boolean {
			if(instance == null) return false;
			return instance.isLoggedIn;
		}
	}
}
