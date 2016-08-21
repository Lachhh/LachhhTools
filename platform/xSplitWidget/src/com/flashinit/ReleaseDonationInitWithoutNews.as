package com.flashinit {
	import com.lachhh.lachhhengine.VersionInfo;
	/**
	 * @author LachhhSSD
	 */
	public class ReleaseDonationInitWithoutNews extends ReleaseDonationInit {
		public function ReleaseDonationInitWithoutNews() {
			super();
			
			VersionInfo.showNewsWhenNothing = false;
		}
		
	
	}
}
