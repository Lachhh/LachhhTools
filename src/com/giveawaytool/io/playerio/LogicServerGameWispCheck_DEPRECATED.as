package com.giveawaytool.io.playerio {
	import com.giveawaytool.ui.UI_PopUp;
	import playerio.Message;

	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class LogicServerGameWispCheck_DEPRECATED extends ActorComponent {
		public var isTokenValid : Boolean = false;
		public var callbackSendNewTokenToServerSuccess:Callback;
		public var callbackSendNewTokenToServerError:Callback;
		public function LogicServerGameWispCheck_DEPRECATED() {
			super();
			//
		}
		
		public function fetchServerData():void {
			//MetaServerProgress.instance.getGamewispData(new Callback(onGameWispTokenReceived, this, null), new Callback(onGameWispServerTokenError, this, null)); 
		}
		
		private function onGameWispTokenReceived() : void {
			var msg : Message = PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connectionGameRoom.getGamewispDataSuccess.msg;
			var newAccessToken:String = msg.getString(0); 
			
			validateToken(newAccessToken, new Callback(UIBase.manager.refresh, UIBase.manager, null));
		}	
		
		private function onGameWispServerTokenError() : void {
			var msg : Message = PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connectionGameRoom.getGamewispDataSuccess.msg;
			var errorMsg:String = msg.getString(0); 
			UI_PopUp.createOkOnly(errorMsg, null);
			
			//validateToken(newAccessToken, new Callback(UIBase.manager.refresh, UIBase.manager, null));
		}	
		

		public function isConnected() : Boolean {
			return false;
		}
		
		public function tryToSendNewAccessTokenToDB(success : Callback, callbackOnError : Callback) : void {
			callbackSendNewTokenToServerSuccess = success;
			callbackSendNewTokenToServerError = callbackOnError;
			//GameWispConnection_DEPRECATED.getInstance().fecthNewAccessToken(new Callback(validateToken2, this, [callbackSendNewTokenToServerSuccess]), callbackSendNewTokenToServerError);			
		}
		
		public function validateToken2(c:Callback) : void {
			//GameWispConnection.getInstance().validateServerToken(GameWispConnection.getInstance().isServerTokenValid, c);
		}
				
		public function validateToken(token:String, c:Callback) : void {
			//GameWispConnection_DEPRECATED.getInstance().validateServerToken(token, c);
		}
		
	}
}
