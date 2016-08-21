package com.giveawaytool.ui {
	import com.giveawaytool.MetaCheerAlert;
	import com.giveawaytool.MainGame;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaHostAlert;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlayCheerAlert extends MetaCmd {
		public var metaCheerAlert:MetaCheerAlert;
		

		public function MetaCmdPlayCheerAlert(m : MetaCheerAlert) {
			metaCheerAlert = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			//UI_News.closeAllNews();
			var ui : UI_NewCheerAnim = new UI_NewCheerAnim(metaCheerAlert);
			ui.callbackOnFinish = new Callback(onAnimEnded, this, null);
			endCmd(); 
		}
		
		private function onAnimEnded():void {
			endCmd();
		}
	}
}
