package com.giveawaytool.io.twitch.streamlabs {
	import playerio.Message;

	import com.giveawaytool.components.LogicSendToWidget;
	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.giveawaytool.io.playerio.MetaServerProgress;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.UI_PopUp;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;
	import com.lachhh.utils.Utils;

	import flash.display.NativeWindowInitOptions;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.html.HTMLLoader;
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
		private var mySocket : LogicSendToWidget;

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
			/*windowOptions = new NativeWindowInitOptions();
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
			
			request.url = getConnectURL();
			
			htmlLoader.load(request);*/
			UI_Menu.instance.logicNotification.logicSendToWidgetAuth.setModelForStreamlabs();
			UI_PopUp.createOkOnly("A webpage will open, please authorize LachhhTools and come back here!", null);
			Utils.navigateToURLAndRecord(getConnectURL());
		}
		
		private function onErrorConnectOnStreamLabs(event : Event) : void {
			trace(event);
			if(onConnectError) {
				onConnectError.call();
			}
		}
		
		public function setCodeFromWebSocket(code : String) : void {
			authCode = code;
			onStep1Done();
		}
		
		function httpStatusHandler( e:HTTPStatusEvent ):void {
			trace("httpStatusHandler:" + e.status + "/"+  e.responseURL + "/" + e.type);
		}
		function securityErrorHandler( e:SecurityErrorEvent ):void {
			trace("securityErrorHandler:" + e);
		}
		
		private function onHttpResponseStatus(event : HTTPStatusEvent) : void {
			trace("onHttpResponseStatus:" + event.responseURL + "/" + event.responseHeaders + "/" + event.type);
			for (var i : int = 0; i < event.responseHeaders.length; i++) {
				var rh:URLRequestHeader = event.responseHeaders[i] as URLRequestHeader; 
				trace(rh.name + "/" + rh.value);
			}
			
		}

		private function onFetchAccessToken(event : Event) : void {
			var rawData:String = event.target.data;
			var d:Dictionary = DataManager.stringToDictionnary(rawData);
			trace(d);
			mySocket.clearShitOnURL();
			if(d["access_token"] != null) {
				accessToken = d["access_token"];
				onStep1Done();
				mySocket.sendRaw("Success! You can now close this page.");
			} else {
				mySocket.sendRaw("Oops! Something went wrong...");
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
			var url:String = "https://streamlabs.com/api/v1.0/authorize?response_type=code"; 
			url = url + "&client_id=" + VersionInfoDONTSTREAMTHIS.STREAMLABS_CLIENT_ID ;
			url = url + "&redirect_uri=" + VersionInfoDONTSTREAMTHIS.STREAMLABS_CLIENT_REDIRECT ;
			url = url + "&state=" + getStateRandom();
			url = url + "&scope=donations.read";

			return url;
		}
		
		protected function onStep1Done():void {
			MetaServerProgress.instance.getStreamLabsAccessToken(authCode, new Callback(onAuthCodeSendSuccess, this, null), new Callback(onAuthCodeSendError, this, null));

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
				UI_PopUp.closeAllPopups();
				UI_PopUp.createOkOnly("Connected to StreamLabs successfully!", null)
				if(onConnect) onConnect.call();
			} else {
				isTokenValid = false;
				onAuthCodeSendError();
			}
		}
		
		private function onAuthCodeSendError() : void {
			UI_PopUp.closeAllPopups();
			if(onConnectError) onConnectError.call();
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
		
		
		private function getStateRandom():String { 
			return getDigits(5) + "-" + getDigits(5) + "-" + getDigits(5) + "-" + getDigits(5) ;
		}
		
		private function getDigits(n:int):String {
			var result:String = "";
			for (var i : int = 0; i < n; i++) {
				result += getDigit();
			}
			return result;
		}
		
		private function getDigit():String {
			var i:int = Math.random()*10;
			return i.toString();
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
