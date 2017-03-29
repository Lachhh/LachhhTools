package com.giveawaytool.io.playerio {
	import com.lachhh.io.Callback;
	import playerio.Client;
	import playerio.Connection;
	/**
	 * @author LachhhSSD
	 */
	public class PlayerIORoomConnection {
		private var client : Client;
		public var lastError:String;
		public var debugMode:Boolean ;
		public var onSuccess:Callback;
		public var onError:Callback;
		public var connection:Connection;
		public function PlayerIORoomConnection(pClient:Client, pDebug:Boolean) {
			client = pClient;
			debugMode = pDebug ;
		}
		
		public function connectToRoom(roomId:String):void {
			if(debugMode) {
				client.multiplayer.developmentServer = "localhost:8184";
			}
			client.multiplayer.createJoinRoom(null, roomId, false, {}, {}, 
				function(con:Connection):void {
					onRoomGameConnected(con);
					if(onSuccess) onSuccess.call();
				}
				, onConnectError
			);			
		}

		protected function onRoomGameConnected(con : Connection) : void {
			connection = con;			
		}
		
		protected function onConnectError(e:Error):void {	
			lastError = e.getStackTrace();
		}
		
		public function isConnected():Boolean {
			if(!connection) return false;
			return connection.connected;
		}
		
		public function disconnect():void {
			if(!isConnected()) return ;
			connection.disconnect();
		}
		
		
	}
}
