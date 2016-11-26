package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaHostAlert;
	import com.lachhh.io.Callback;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlayHostAlert extends MetaCmd {
		public var metaHostAlert:MetaHostAlert;
		

		public function MetaCmdPlayHostAlert(m : MetaHostAlert) {
			metaHostAlert = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			UI_News.closeAllNews();
			
			if (pMetaConfig.metaCustomAnim.metaCustomAnimNewHost.hasCustomAnim()) {
				var ca : WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget(pMetaConfig.metaCustomAnim.metaCustomAnimNewHost.getPathAsWidgetLocal());
				var d:Dictionary = new Dictionary();
				d["name"] = metaHostAlert.name;
				d["numViewers"] = metaHostAlert.numViewers;
				ca.showAnim(d, new Callback(onAnimEnded, this, null));
			} else {
				var ui:UI_NewHostAnim = new UI_NewHostAnim(metaHostAlert);
				ui.callbackOnDestroy = new Callback(onAnimEnded, this, null);
			}  
		}
		
		private function onAnimEnded():void {
			MainGame.instance.createNews();
			endCmd();
		}
	}
}
