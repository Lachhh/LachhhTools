package com.flashinit {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.ui.UI_Donation;
	import com.giveawaytool.ui.UI_GiveawayMenu;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;
	/**
	 * @author LachhhSSD
	 */
	public class DebugDonationInit extends Sprite {
		public function DebugDonationInit() {
			super();
			
			VersionInfo.isDebug = true;
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
			new UI_Donation();
		}
	}
}
