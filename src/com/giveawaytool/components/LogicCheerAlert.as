package com.giveawaytool.components {
	import com.MetaIRCMessage;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_CheerAlert;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.views.MetaCheer;
	import com.giveawaytool.ui.views.MetaCheerAlert;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class LogicCheerAlert extends ActorComponent {
		private var logicChat : LogicTwitchChat;

		public function LogicCheerAlert(pLogicChat : LogicTwitchChat) {
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
			
			if(ircMsg.isCheerAlert()) {
				var newCheer:MetaCheerAlert = MetaCheerAlert.createFromIRCMsg(ircMsg);
				MetaGameProgress.instance.metaCheerAlertConfig.metaCheers.add(MetaCheer.create2(newCheer.name, new Date(), newCheer.numBits));
				if(canAlert()) UI_Menu.instance.logicNotification.logicSendToWidget.sendCheerAlert(newCheer);
				MetaGameProgress.instance.saveToLocal();
				UIBase.manager.refreshAll(UI_CheerAlert);
			}
		}

		private function canAlert() : Boolean {
			if(!UI_Menu.instance.logicNotification.logicPatreonAccess.canSendCheersIfNotLive()) return false;
			return MetaGameProgress.instance.metaCheerAlertConfig.alertOnNewCheer;
		}
		
		
		static public function addToActor(actor: Actor, chat:LogicTwitchChat): LogicHostAlert {
			var result: LogicHostAlert = new LogicHostAlert(chat);
			actor.addComponent(result);
			return result;
		}
	}
}
