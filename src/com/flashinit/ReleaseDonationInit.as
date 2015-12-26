package com.flashinit {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.ui.UI_Donation;
	import com.giveawaytool.ui.UI_GiveawayMenu;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;
	/**
	 * @author LachhhSSD
	 */
	public class ReleaseDonationInit extends Sprite {
		public function ReleaseDonationInit() {
			super();
			
			VersionInfo.isDebug = false;
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
			new UI_Donation();
		}
	}
}
