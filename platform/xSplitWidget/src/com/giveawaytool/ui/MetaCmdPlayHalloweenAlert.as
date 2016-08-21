package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlayHalloweenAlert extends MetaCmd {

		public function MetaCmdPlayHalloweenAlert() {
		}

		override public function execute(pMetaConfig : MetaDonationsConfig) : void {
			var uiHallowen:UI_Charity = UIBase.manager.getFirst(UI_Charity) as UI_Charity;
			if(uiHallowen) {
				uiHallowen.playSpook();
				endCmd();
			}
		}
	}
}
