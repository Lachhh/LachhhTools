package com.giveawaytool.components {
	import com.MetaIRCMessage;
	import com.giveawaytool.ui.MetaHostAlert;
	import com.giveawaytool.ui.UI_Donation;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicHostAlert extends ActorComponent {
		private var logicChat : LogicTwitchChat;

		public function LogicHostAlert(pLogicChat : LogicTwitchChat) {
			super();
			logicChat = pLogicChat;
			logicChat.callbackMsgReceived.addCallback(new Callback(onMsgReceived, this, null));
		}

		private function onMsgReceived() : void {
			var lastMsg:MetaIRCMessage = logicChat.lastMsgReceived;
			processIRCMsg(lastMsg);
		}
		
		public function processIRCMsg(ircMsg:MetaIRCMessage):void {
			if(ircMsg == null) return ;
			if(ircMsg.isHostAlert()) {
				var newHost:MetaHostAlert = MetaHostAlert.createFromIRCMsg(ircMsg);
				UI_Menu.instance.logicNotification.logicSendToWidget.sendHostAlert(newHost);
			}
		}

		
		
		static public function addToActor(actor: Actor, chat:LogicTwitchChat): LogicHostAlert {
			var result: LogicHostAlert = new LogicHostAlert(chat);
			actor.addComponent(result);
			return result;
		}
	}
}
