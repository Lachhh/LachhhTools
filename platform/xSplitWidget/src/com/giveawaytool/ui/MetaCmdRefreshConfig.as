package com.giveawaytool.ui {
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.lachhh.io.Callback;
	import com.giveawaytool.io.WidgetCustomAssetLoader;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.giveawaytool.MainGame;
	import com.giveawaytool.meta.MetaDonationsConfig;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdRefreshConfig extends MetaCmd {
		public var metaNewConfig : MetaDonationsConfig;

		public function MetaCmdRefreshConfig(mConfig:MetaDonationsConfig) {
			metaNewConfig = mConfig;
		}

		override public function execute(pMetaConfig : MetaDonationsConfig) : void {
			super.execute(pMetaConfig);
			MainGame.logicListenToMain.metaDonationConfig = metaNewConfig;
			UIBase.manager.refresh();
			var uiWidget:UI_DonationWidget = UIBase.manager.getFirst(UI_DonationWidget) as UI_DonationWidget;
			if(uiWidget) uiWidget.flashAllForRefresh();
			endCmd();
		}

		private function onReloaded() : void {
		}
	}
}
