package com.flashinit {
	import com.lachhh.lachhhengine.VersionInfo;
	/**
	 * @author LachhhSSD
	 */
	public class ReleaseDonationInitWithoutNewsWithTExtDebug extends ReleaseDonationInit {
		public function ReleaseDonationInitWithoutNewsWithTExtDebug() {
			super();
			
			VersionInfo.showNewsWhenNothing = false;
			addDebugTextfield();
		}
		
	
	}
}
