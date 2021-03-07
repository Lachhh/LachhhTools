package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.lachhh.lachhhengine.ui.UIBase;
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
			
			WidgetCustomAssetManager.clearCache();
		}

	}
}
