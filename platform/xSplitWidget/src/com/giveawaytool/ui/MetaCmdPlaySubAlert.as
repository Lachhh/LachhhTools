package com.giveawaytool.ui {
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaSubcriberAlert;
	import com.lachhh.io.Callback;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlaySubAlert extends MetaCmd {
		public var metaSubAlert:MetaSubcriberAlert;
		

		public function MetaCmdPlaySubAlert(m : MetaSubcriberAlert) {
			metaSubAlert = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			if (pMetaConfig.metaCustomAnim.metaCustomAnimNewSub.hasCustomAnim()) {
				var ca : WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget("CustomAnims/NewSub.swf");
				var d:Dictionary = new Dictionary();
				d["newSub"] = metaSubAlert.name;
				d["numMonthInARow"] = metaSubAlert.numMonthInARow;
				ca.showAnim(d, new Callback(endCmd, this, null));
			} else {
				var ui:UI_NewSubAnim = new UI_NewSubAnim(metaSubAlert);
				ui.callbackOnDestroy = new Callback(endCmd, this, null);
			}  
		}

	}
}
