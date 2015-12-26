package com.giveawaytool.components {
	import com.SimpleIRCBot;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_Donation;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicNotifications extends ActorComponent {
		public var logicDonationsAutoFetch : LogicAutoFetchDonation;
		public var logicSubAlert : LogicSubAlert;
		public var logicHostAlert : LogicHostAlert;
		public var logicTweetAutoFetch : LogicAutoFetchTweet;
		
		public var metaGameProgress:MetaGameProgress;
		public var uiDonation : UI_Donation ;
		
		private var simpleIRCBot : SimpleIRCBot;
		
		public function LogicNotifications(m:MetaGameProgress) {
			super();
			metaGameProgress = m;
			simpleIRCBot = new SimpleIRCBot();
		}

		override public function start() : void {
			super.start();
			logicDonationsAutoFetch = actor.addComponent(new LogicAutoFetchDonation(metaGameProgress.metaDonationsConfig.metaAutoFetch)) as LogicAutoFetchDonation;
			logicDonationsAutoFetch.uiDonationEdit = uiDonation.viewDonationsEdit;			
			
			if(VersionInfo.hasTweetsAlert) {
				logicTweetAutoFetch = actor.addComponent(new LogicAutoFetchTweet(metaGameProgress.metaTweetAlertConfig)) as LogicAutoFetchTweet;
				logicTweetAutoFetch.uiDonation = uiDonation;
			}
			
			if(VersionInfo.hasSubAlert) {
				logicSubAlert = actor.addComponent(new LogicSubAlert(simpleIRCBot)) as LogicSubAlert;
				logicSubAlert.uiDonation = uiDonation;
			}
			
			if(VersionInfo.hasHostAlert) {
				logicHostAlert = actor.addComponent(new LogicHostAlert(simpleIRCBot)) as LogicHostAlert;
				logicHostAlert.uiDonation = uiDonation;
			}
		}

	}
}
