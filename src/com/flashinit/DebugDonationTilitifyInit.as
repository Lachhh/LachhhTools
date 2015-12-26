package com.flashinit {
	import com.giveawaytool.meta.donations.ModelDonationSourceEnum;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.flashinit.ReleaseDonationInit;

	/**
	 * @author LachhhSSD
	 */
	public class DebugDonationTilitifyInit extends ReleaseDonationInit {
		public function DebugDonationTilitifyInit() {
			VersionInfo.isTiltify = true;
			VersionInfo.hasTweetsAlert = false;
			
			VersionInfo.donationSource = ModelDonationSourceEnum.TILTIFY;
			super();
			
		}
	}
}
