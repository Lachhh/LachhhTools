package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.VersionInfo;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlayTwitterAlert extends MetaCmd {
		public var metaTwitterAlert:MetaTwitterAlert;
		

		public function MetaCmdPlayTwitterAlert(m : MetaTwitterAlert) {
			metaTwitterAlert = m;
		}

		override public function execute(pMetaConfig : MetaDonationsConfig) : void {
			if(VersionInfo.lachhhistersTweet) {
				
				var ui2 : UI_NewTweetLachhhisters = new UI_NewTweetLachhhisters(metaTwitterAlert);
				ui2.callbackOnDestroy = new Callback(endCmd, this, null);	
			} else {
				var ui : UI_NewTweet = new UI_NewTweet(metaTwitterAlert);
				ui.callbackOnDestroy = new Callback(endCmd, this, null);
			} 
		}
	}
}
