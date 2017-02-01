package com.giveawaytool.io.playerio {
	import playerio.Client;
	import playerio.PlayerIO;

	import com.lachhh.io.Callback;

	import flash.display.DisplayObject;

	/**
	 * @author Lachhh
	 */
	public class PlayerIOConnectionPublic extends PlayerIOConnection {
		public function PlayerIOConnectionPublic(gameId : String, root : DisplayObject, debugMode : Boolean, debugName : String) {
			super(gameId, root, debugMode, debugName);
		}
		
		public function PublicConnect(success : Callback, error : Callback):void {
			SetCallbacks(success, error);
			PlayerIO.connect(root.stage, gameId, "public","testuser", "", "", onConnectPublic, onConnectError);
		}
		
		private function onConnectPublic(client:Client):void {			
			DeclareSuccess(client, false);
			
			TraceMsg("Connected on 'public' connection.");
		}
	}
}
