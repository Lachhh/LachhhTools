package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.lachhh.lachhhengine.ui.UIBase;
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
