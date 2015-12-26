package com.giveawaytool.components {
	import com.giveawaytool.ui.MetaSubcriberAlert;
	import com.giveawaytool.ui.UI_Donation;
	import com.MetaIRCMessage;
	import com.lachhh.io.Callback;
	import com.SimpleIRCBot;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.oosterwijk.irc.event.ServerEvent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicSubAlert extends ActorComponent {
		private var simpleIRCBot : SimpleIRCBot;
		public var uiDonation:UI_Donation;
		public function LogicSubAlert(pSimpleIRCBot:SimpleIRCBot) {
			super();
			simpleIRCBot = pSimpleIRCBot;
			simpleIRCBot.callbackMsgReceived.addCallback(new Callback(onMsgReceived, this, null));
			
		}

		private function onMsgReceived() : void {
			var lastMsg:MetaIRCMessage = simpleIRCBot.lastMsgReceived;
			
			if(lastMsg == null) return ;
			if(uiDonation == null) return ;
			
			if(lastMsg.isNewSubAlert() || lastMsg.isReSubAlert()) {
				var newSub:MetaSubcriberAlert = MetaSubcriberAlert.createFromIRCMsg(lastMsg);
				uiDonation.sendSubscriberAlert(newSub);
			}
		}

		
		static public function addToActor(actor: Actor, irc:SimpleIRCBot): LogicSubAlert {
			var result: LogicSubAlert = new LogicSubAlert(irc);
			actor.addComponent(result);
			return result;
		}
	}
}
