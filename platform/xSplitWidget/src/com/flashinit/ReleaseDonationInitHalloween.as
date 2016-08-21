package com.flashinit {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.ui.UI_Charity;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.events.Event;
	/**
	 * @author LachhhSSD
	 */
	public class ReleaseDonationInitHalloween extends ReleaseDonationInit {
		public function ReleaseDonationInitHalloween() {
			super();
			
			VersionInfo.charityOnly = true;
			VersionInfo.showSub = false;
			VersionInfo.showGaz = false;
		}

		override protected function onAddedToStage(e : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
			m.startNormalDonation();
			new UI_Charity();
		}
	}
}
