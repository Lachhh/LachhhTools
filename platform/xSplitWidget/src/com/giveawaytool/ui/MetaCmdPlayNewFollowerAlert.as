package com.giveawaytool.ui {
	import flash.utils.Dictionary;
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
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
			
			if(hasCustomAnim()) {
				var ca:WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget(pMetaConfig.metaCustomAnim.metaCustomAnimNewDonation.getPathAsWidgetLocal());
				var d:Dictionary = new Dictionary();
				d["newFollower"] = metaNewFollower.name;
				ca.showAnim(d, new Callback(endCmd, this, null));
			} else {
				var ui:UI_NewFollowerAnim = new UI_NewFollowerAnim(metaNewFollower);
				ui.callbackOnDestroy = new Callback(endCmd, this, null);
			} 
		}
		
		private function hasCustomAnim(): Boolean {
			return true;
		}
		
	}
}
