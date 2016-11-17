package com.giveawaytool.ui {
	import com.giveawaytool.MetaCheerAlert;
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.lachhh.io.Callback;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlayCheerAlert extends MetaCmd {
		public var metaCheerAlert:MetaCheerAlert;
		

		public function MetaCmdPlayCheerAlert(m : MetaCheerAlert) {
			metaCheerAlert = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			if (pMetaConfig.metaCustomAnim.metaCustomAnimNewCheers.hasCustomAnim()) {
				var ca : WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget("CustomAnims/NewCheers.swf");
				var d:Dictionary = new Dictionary();
				d["name"] = metaCheerAlert.name;
				d["numBits"] = metaCheerAlert.numBits;
				ca.showAnim(d, new Callback(onAnimEnded, this, null));
			} else {
				var ui : UI_NewCheerAnim = new UI_NewCheerAnim(metaCheerAlert);
				ui.callbackOnFinish = new Callback(onAnimEnded, this, null);
				endCmd(); 
			}  
		}
		
		private function onAnimEnded():void {
			endCmd();
		}
	}
}
