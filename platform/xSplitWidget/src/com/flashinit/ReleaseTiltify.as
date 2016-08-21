package com.flashinit {
	import com.giveawaytool.ui.MetaCmdAddDonation;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	/**
	 * @author LachhhSSD
	 */
	public class ReleaseTiltify extends ReleaseDonationInit {
		public function ReleaseTiltify() {
			super();
			
			VersionInfo.showNewsWhenNothing = false;
			MetaCmdAddDonation.AMOUNT_TO_TRIGGER_BIG = 100;
			JukeBox.MUSIC_MUTED = true;
			JukeBox.MUSIC_VOLUME = 0;
		}
	}
}
