package com.giveawaytool.io.playerio {
	import com.giveawaytool.io.twitch.streamlabs.StreamLabsConnection;
	import playerio.Message;

	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class LogicServerGameWispCheck extends ActorComponent {
		public var isTokenValid : Boolean = false;
		public var callbackSendNewTokenToServerSuccess:Callback;
		public var callbackSendNewTokenToServerError:Callback;
		public function LogicServerGameWispCheck() {
			super();
			//
		}
		
		public function fetchServerData():void {
			MetaServerProgress.instance.getGamewispData(new Callback(onGameWispTokenReceived, this, null), null); 
		}
		
		private function onGameWispTokenReceived() : void {
			var msg : Message = PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connectionGameRoom.getGamewispDataSuccess.msg;
			var newAccessToken:String = msg.getString(0); 
			
			GameWispConnection.getInstance().accessToken = newAccessToken;
			
			validateToken(new Callback(UIBase.manager.refresh, UIBase.manager, null));
		}	
		

		public function isConnected() : Boolean {
			return GameWispConnection.getInstance().isTokenValid;
		}
		
		public function tryToSendNewAccessTokenToDB(success : Callback, callbackOnError : Callback) : void {
			callbackSendNewTokenToServerSuccess = success;
			callbackSendNewTokenToServerError = callbackOnError;
			GameWispConnection.getInstance().fecthNewAccessToken(new Callback(validateToken, this, [callbackSendNewTokenToServerSuccess]), callbackSendNewTokenToServerError);			
		}
				
		private function validateToken(c:Callback) : void {
			GameWispConnection.getInstance().validateToken(c);
		}
		
	}
}
