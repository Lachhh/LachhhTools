package com.giveawaytool.io.playerio {
	import playerio.Client;
	import playerio.Connection;

	import com.lachhh.io.Callback;

	/**
	 * @author LachhhSSD
	 */
	public class PlayerIOGameRoomConnection extends PlayerIORoomConnection {
		
		public var getStreamLabsAccessTokenSuccess : PlayerIORoomCommand;
		public var getStreamLabsAccessTokenFailure : PlayerIORoomCommand;
			
		public var sendNewGamewispTokenSuccess : PlayerIORoomCommand;
		public var sendNewGamewispTokenFailure : PlayerIORoomCommand;
		
		public var getGamewispDataSuccess : PlayerIORoomCommand;
		public var getGamewispDataFailure : PlayerIORoomCommand;
		
		public var getGamewispTokenSuccess : PlayerIORoomCommand;
		public var getGamewispTokenFailure : PlayerIORoomCommand;
		
		public var getTwitchTokenSuccess : PlayerIORoomCommand;
		public var getTwitchTokenFailure : PlayerIORoomCommand;

		public function PlayerIOGameRoomConnection(pClient : Client, pDebug : Boolean) {
			super(pClient, pDebug);
		}

		override protected function onRoomGameConnected(con : Connection) : void {
			super.onRoomGameConnected(con);
			
			
			sendNewGamewispTokenSuccess = new PlayerIORoomCommand(this, "sendNewGamewispTokenSuccess");
			sendNewGamewispTokenFailure = new PlayerIORoomCommand(this, "sendNewGamewispTokenFailure");
			
			getGamewispDataSuccess = new PlayerIORoomCommand(this, "getGamewispDataSuccess");
			getGamewispDataFailure = new PlayerIORoomCommand(this, "getGamewispDataFailure");
			
			getStreamLabsAccessTokenSuccess = new PlayerIORoomCommand(this, "getStreamLabsAccessTokenSuccess");
			getStreamLabsAccessTokenFailure = new PlayerIORoomCommand(this, "getStreamLabsAccessTokenFailure");
			
			getTwitchTokenSuccess = new PlayerIORoomCommand(this, "getTwitchTokenSuccess");
			getTwitchTokenFailure = new PlayerIORoomCommand(this, "getTwitchTokenFailure");
			
			getGamewispTokenSuccess = new PlayerIORoomCommand(this, "getGamewispTokenSuccess");
			getGamewispTokenFailure = new PlayerIORoomCommand(this, "getGamewispTokenFailure");
			
		}
		
		public function getTwitchAccesssToken(authCode: String, success : Callback, failure : Callback) : void {
			getTwitchTokenSuccess.onMsg = success;
			getTwitchTokenFailure.onMsg = failure;
			connection.send("getTwitchAccessToken", authCode);
		}
		
		public function getStreamLabsAccesssToken(authCode: String, success : Callback, failure : Callback) : void {
			getStreamLabsAccessTokenSuccess.onMsg = success;
			getStreamLabsAccessTokenFailure.onMsg = failure;
			connection.send("getStreamLabsAccessToken", authCode);
		}


		public function SendNewGameWispToken(accessToken : String, success : Callback, failure : Callback) : void {
			sendNewGamewispTokenSuccess.onMsg = success;
			sendNewGamewispTokenFailure.onMsg = failure;
			connection.send("sendNewGamewispToken", accessToken);
		}
		
		public function GetGameWispData(success : Callback, failure : Callback) : void {
			getGamewispDataSuccess.onMsg = success;
			getGamewispDataFailure.onMsg = failure;
			connection.send("getGamewispData");
		}

		public function getGamewispAccessToken(authCode : String, success : Callback, failure : Callback) : void {
			getGamewispTokenSuccess.onMsg = success;
			getGamewispTokenFailure.onMsg = failure;
			connection.send("getGamewispAccessToken", authCode);
		}
	}
}

