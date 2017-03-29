package com.giveawaytool.io.playerio {
	import playerio.Message;

	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;
	import com.lachhh.utils.Utils;

	import flash.display.NativeWindowInitOptions;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.SecurityErrorEvent;
	import flash.html.HTMLLoader;
	import flash.net.URLRequestHeader;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class GameWispConnection {
		static public var instance: GameWispConnection; 
		
		private var windowOptions : NativeWindowInitOptions;
		private var htmlLoader : HTMLLoader;
		public var accessToken : String;
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
			UI_Menu.instance.logicNotification.logicSendToWidgetAuth.setModelForGameWisp();
			callbackOnSuccess = cOnSuccess;
			callbackOnError = cOnError;
			Utils.navigateToURLAndRecord(getConnectURL());
		}

		private function getConnectURL() : String {
			return "https://api.gamewisp.com/pub/v1/oauth/authorize?client_id=" + VersionInfoDONTSTREAMTHIS.GAMEWISP_ID + 
				   "&redirect_uri=" + VersionInfoDONTSTREAMTHIS.GAMEWISP_CLIENT_REDIRECT +
				   "&response_type=code&scope=read_only,subscriber_read_limited&state=ASKDLFJsisisks23k"; 
		}
		
		public function setCodeFromWebSocket(code : String) : void {
			authCode = code;
			trace(authCode) ;
			onStep1Done();
		}

		private function onStep1Done() : void {
			MetaServerProgress.instance.getGameWispAccessToken(authCode, new Callback(onAuthSuccess, this, null), new Callback(onAuthError, this, null));
			
		}

		private function onAuthSuccess() : void {
			var msg : Message = PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connectionGameRoom.getGamewispTokenSuccess.msg;
			accessToken = msg.getString(0);
			isTokenValid = true;
			if(callbackOnSuccess) callbackOnSuccess.call();
		}

		private function onAuthError() : void {
			if(callbackOnError) callbackOnError.call();
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
