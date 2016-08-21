package com.giveawaytool.components {
	import com.MetaIRCMessage;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_GiveawayMenu;
	import com.giveawaytool.ui.UI_CountDown;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class LogicGiveawayAutoChat extends ActorComponent {
		private var logicChat : LogicTwitchChat;

		public function LogicGiveawayAutoChat(pLogicChat : LogicTwitchChat) {
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
			
			checkForCountdown(ircMsg);
			checkForGiveawayAdd(ircMsg);
		}
		
		private function checkForCountdown(ircMsg:MetaIRCMessage):void {
			if(!ircMsg.isCountdownAutoClaimCmd(MetaGameProgress.instance.metaCountdownConfig)) return ;
			if(!MetaGameProgress.instance.metaCountdownConfig.autoChatClaim) return;
			 
			var ui:UI_CountDown = UIBase.manager.getFirst(UI_CountDown) as UI_CountDown;
			if(ui == null) return ;
			ui.saveTheGuy();
		}
		
		private function checkForGiveawayAdd(ircMsg:MetaIRCMessage):void {
			if(!ircMsg.isGiveawayAutoAddCmd(MetaGameProgress.instance.metaGiveawayConfig)) return ;
			if(!MetaGameProgress.instance.metaGiveawayConfig.autoChatAdd) return; 
			var ui:UI_GiveawayMenu = UIBase.manager.getFirst(UI_GiveawayMenu) as UI_GiveawayMenu;
			if(ui == null) return ;
			ui.viewGiveaway.viewGiveawayAddParticipants.addFromChat(ircMsg.name); 
		}

		
		
		static public function addToActor(actor: Actor, chat:LogicTwitchChat): LogicHostAlert {
			var result: LogicHostAlert = new LogicHostAlert(chat);
			actor.addComponent(result);
			return result;
		}
	}
}
