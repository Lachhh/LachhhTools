package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaSubcriberAlert;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlaySubAlert extends MetaCmd {
		public var metaSubAlert:MetaSubcriberAlert;
		

		public function MetaCmdPlaySubAlert(m : MetaSubcriberAlert) {
			metaSubAlert = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			var ui:UI_NewSubAnim = new UI_NewSubAnim(metaSubAlert);
			ui.callbackOnDestroy = new Callback(endCmd, this, null); 
		}
	}
}
