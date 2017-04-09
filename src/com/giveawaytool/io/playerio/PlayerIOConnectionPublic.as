package com.giveawaytool.io.playerio {
	import playerio.Client;
	import playerio.PlayerIO;

	import com.lachhh.io.Callback;

	import flash.display.DisplayObject;

	/**
	 * @author Lachhh
	 */
	public class PlayerIOConnectionPublic extends PlayerIOConnection {
		public var connectionGameRoom : PlayerIOGameRoomConnection;

		public function PlayerIOConnectionPublic(gameId : String, root : DisplayObject, debugMode : Boolean, debugName : String) {
			super(gameId, root, debugMode, debugName);
		}

		public function PublicConnect(success : Callback, error : Callback) : void {
			SetCallbacks(success, error);
			PlayerIO.connect(root.stage, gameId, "public","testuser", "", "", onConnectPublic, onConnectError);
		}
		
		private function onConnectPublic(client:Client):void {			
			DeclareSuccess(client, false);
			
			TraceMsg("Connected on 'public' connection.");
		}
		
		public function connectToGameRoom(success:Callback):void {
			connectionGameRoom = new PlayerIOGameRoomConnection(client, debugMode);
			connectionGameRoom.onSuccess = success;
			connectionGameRoom.connectToRoom("GameRoom");
		}

		public function getTwitchAccesssToken(authCode : String, success : Callback, failure : Callback) : void {
			if(connectionGameRoom == null) {
				
				connectToGameRoom(new Callback(getTwitchAccesssToken, this, [authCode, success, failure]));
				return;
			}
			if(connectionGameRoom.isConnected()) {
				connectionGameRoom.getTwitchAccesssToken(authCode, new Callback(onAuthTokenSuccess, this, [success]), new Callback(onAuthTokenError, this, [failure]));
			}
		}
		
		private function onAuthTokenSuccess(s:Callback):void {
			if(s) s.call();
			disconnectFromRoom();
		}
		
		private function onAuthTokenError(s:Callback):void {
			if(s) s.call();
			disconnectFromRoom();
		}
		
		private function disconnectFromRoom():void {
			connectionGameRoom.disconnect();
			connectionGameRoom = null;
		}
	}
}
