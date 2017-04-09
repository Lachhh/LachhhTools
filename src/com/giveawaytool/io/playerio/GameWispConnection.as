package com.giveawaytool.io.playerio {
	import playerio.Message;

	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;
	import com.lachhh.utils.Utils;
	/**
	 * @author LachhhSSD
	 */
	public class GameWispConnection {
		static public var instance: GameWispConnection; 
		
		public var accessTokenClient : String;
		public var isServerTokenValid : Boolean = false;
		public var isClientTokenValid : Boolean = false;
		private var authCode : String;
		
		private var callbackOnSuccess : Callback;
		private var callbackOnError : Callback;
		public var metaChannelInfo : MetaGameWispChannelInfo;
		public var metaChannelSubsGroup : MetaGameWispSubGroup = new MetaGameWispSubGroup();

		static public function getInstance() : GameWispConnection {
			if(instance == null) {
				instance = new GameWispConnection();
			}
			return instance;
		}
		
		public function hasAccessToken():Boolean {
			if(accessTokenClient == "") return false;
			if(accessTokenClient == null) return false;
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
			onStep1Done();
		}

		private function onStep1Done() : void {
			isClientTokenValid = false;
			MetaServerProgress.instance.getGameWispAccessToken(authCode, new Callback(onAuthSuccess, this, null), new Callback(onAuthError, this, null));
			
		}

		private function onAuthSuccess() : void {
			var msg : Message = PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connectionGameRoom.getGamewispTokenSuccess.msg;
			accessTokenClient = msg.getString(0);
			isClientTokenValid = true;
			requestChannelInfo(new Callback(onAuthSuccessPart2, this, [callbackOnSuccess]));
		}

		private function onAuthSuccessPart2(c:Callback) : void {
			refreshSubs(c, metaChannelInfo);
		}

		private function onAuthError() : void {
			isClientTokenValid = false;
			if(callbackOnError) callbackOnError.call();
		}
				
		public function validateServerToken(pAccessToken:String,  onComplete:Callback):void {
			isServerTokenValid = false;
			var gameWispRequest : GameWispRequestValidateToken = new GameWispRequestValidateToken(pAccessToken);
			gameWispRequest.callbackOnSuccess = new Callback(onValidateServerToken, this, [gameWispRequest, onComplete]);
			gameWispRequest.callbackOnError = new Callback(onValidateServerToken, this, [gameWispRequest, onComplete]);
			gameWispRequest.loadRequest();
		}
		
		private function onValidateServerToken(request:GameWispRequestValidateToken, callback:Callback) : void {
			isServerTokenValid = request.isTokenValid;
			if(callback) callback.call();
		}
		
		public function validateClientToken(pAccessToken:String,  onComplete:Callback):void {
			isClientTokenValid = false;
			accessTokenClient = pAccessToken;
			var gameWispRequest : GameWispRequestGetChannelInfo = new GameWispRequestGetChannelInfo(pAccessToken);
			gameWispRequest.callbackOnSuccess = new Callback(onValidateClientToken, this, [gameWispRequest, onComplete]);
			gameWispRequest.callbackOnError = new Callback(onValidateClientToken, this, [gameWispRequest, onComplete]);
			gameWispRequest.loadRequest();
		}
		
		private function onValidateClientToken(request:GameWispRequestGetChannelInfo, callback:Callback) : void {
			isClientTokenValid = request.isSuccess;
			metaChannelInfo = request.metaChannelInfo;
			refreshSubs(callback, metaChannelInfo);
		}
		
		public function requestChannelInfo(onComplete:Callback):GameWispRequestGetChannelInfo {
			var gameWispRequest : GameWispRequestGetChannelInfo = new GameWispRequestGetChannelInfo(accessTokenClient);
			gameWispRequest.callbackOnSuccess = new Callback(onChannelInfo, this, [gameWispRequest, onComplete]);
			gameWispRequest.callbackOnError = new Callback(onChannelInfo, this, [gameWispRequest, onComplete]);
			gameWispRequest.loadRequest();
			return gameWispRequest;
		}

	
		private function onChannelInfo(request:GameWispRequestGetChannelInfo, callback:Callback) : void {
			metaChannelInfo = request.metaChannelInfo;
			if(callback) callback.call();
		}
		
		public function refreshSubs(onComplete:Callback, pMetaChannelInfo:MetaGameWispChannelInfo) : void {
			GameWispConnection.getInstance().metaChannelSubsGroup.clear();
			var gameWispRequest : GameWispRequestFetchMySubs = new GameWispRequestFetchMySubs(accessTokenClient, pMetaChannelInfo);
			gameWispRequest.callbackOnSuccess = new Callback(onRefreshSub, this, [gameWispRequest, onComplete]);
			gameWispRequest.callbackOnError = new Callback(onRefreshSub, this, [gameWispRequest, onComplete]);
			gameWispRequest.loadRequest();
		}
		
		private function onRefreshSub(request:GameWispRequestFetchMySubs, callback:Callback) : void {
			metaChannelSubsGroup = request.metaChannelSubsGroup;
			if(callback) callback.call();
		}

		public function logout() : void {
			accessTokenClient = "";
			isClientTokenValid = false;
		}

		public function isConnected() : Boolean {
			return isClientTokenValid;
		}

		
	}
}
