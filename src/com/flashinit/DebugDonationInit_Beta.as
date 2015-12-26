package com.flashinit {
	import com.lachhh.lachhhengine.VersionInfo;
	/**
	 * @author LachhhSSD
	 */
	public class DebugDonationInit_Beta extends ReleaseDonationInit {
		public function DebugDonationInit_Beta() {
			VersionInfo.hasTweetsAlert = false;
			VersionInfo.hasSubAlert = false;
			VersionInfo.hasHostAlert = false;
			super();
		}
	}
}
