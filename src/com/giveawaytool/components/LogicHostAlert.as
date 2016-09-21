package com.giveawaytool.components {
	import com.giveawaytool.ui.UI_CheerAlert;
	import com.MetaIRCMessage;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.MetaHostAlert;
	import com.giveawaytool.ui.UI_FollowSubAlert;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.views.MetaHost;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

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
				MetaGameProgress.instance.metaHostAlertConfig.metaHosts.add(MetaHost.create2(newHost.name, new Date(), newHost.numViewers));
				if(canAlert()) UI_Menu.instance.logicNotification.logicSendToWidget.sendHostAlert(newHost);
				MetaGameProgress.instance.saveToLocal();
				UIBase.manager.refreshAll(UI_CheerAlert);
			}
		}

		private function canAlert() : Boolean {
			if(!UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessHost()) return false;
			return MetaGameProgress.instance.metaHostAlertConfig.alertOnNewHost;
		}
		
		
		static public function addToActor(actor: Actor, chat:LogicTwitchChat): LogicHostAlert {
			var result: LogicHostAlert = new LogicHostAlert(chat);
			actor.addComponent(result);
			return result;
		}
	}
}
