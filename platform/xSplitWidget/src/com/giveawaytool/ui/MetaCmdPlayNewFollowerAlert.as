package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlayNewFollowerAlert extends MetaCmd {
		public var metaNewFollower:MetaNewFollowerAlert;
		

		public function MetaCmdPlayNewFollowerAlert(m : MetaNewFollowerAlert) {
			metaNewFollower = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			var ui:UI_NewFollowerAnim = new UI_NewFollowerAnim(metaNewFollower);
			ui.callbackOnDestroy = new Callback(endCmd, this, null); 
		}
	}
}
