package com.giveawaytool.io.playerio {
	import playerio.Message;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class PlayerIORoomCommand {
		private var room:PlayerIORoomConnection;
		public var onMsg:Callback;
		public var cmdIn:String;
		public var msg:Message;
		
		private var hasInit:Boolean;

		public function PlayerIORoomCommand(pRoom:PlayerIORoomConnection, cmdStr:String) {
			room = pRoom;
			hasInit = false;
			cmdIn = cmdStr;
			init();
		}
		
		public function init():void {
			if(!room.isConnected()) return ;
			if(hasInit) return ;
			room.connection.addMessageHandler(cmdIn, onCmdIn);
			room.connection.addDisconnectHandler(onDisconnect);
		}

		private function onDisconnect() : void {
			hasInit = false;
		}

		private function onCmdIn(m:Message) : void {
			msg = m;
			if(onMsg) onMsg.call();
		}		
	}
}
