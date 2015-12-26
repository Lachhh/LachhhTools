package com.giveawaytool.components {
	import com.MetaIRCMessage;
	import com.SimpleIRCBot;
	import com.giveawaytool.ui.MetaHostAlert;
	import com.giveawaytool.ui.UI_Donation;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicHostAlert extends ActorComponent {
		private var simpleIRCBot : SimpleIRCBot;
		public var uiDonation : UI_Donation;

		public function LogicHostAlert(pSimpleIRCBot : SimpleIRCBot) {
			super();
			simpleIRCBot = pSimpleIRCBot; 
			simpleIRCBot.callbackMsgReceived.addCallback(new Callback(onMsgReceived, this, null));
			
		}

		private function onMsgReceived() : void {
			if(uiDonation == null) return ;
			var lastMsg:MetaIRCMessage = simpleIRCBot.lastMsgReceived;
			processIRCMsg(lastMsg);
		}
		
		public function processIRCMsg(ircMsg:MetaIRCMessage):void {
			if(ircMsg == null) return ;
			if(ircMsg.isHostAlert()) {
				var newHost:MetaHostAlert = MetaHostAlert.createFromIRCMsg(ircMsg);
				uiDonation.sendHostAlert(newHost);
			}
		}

		
		
		static public function addToActor(actor: Actor, irc:SimpleIRCBot): LogicHostAlert {
			var result: LogicHostAlert = new LogicHostAlert(irc);
			actor.addComponent(result);
			return result;
		}
	}
}
