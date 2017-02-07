package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaHostAlert;
	import com.lachhh.io.Callback;
	import com.lachhh.io.SimpleSocket;
	import com.lachhh.lachhhengine.sfx.JukeBox;

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
			JukeBox.MUSIC_VOLUME = pMetaConfig.metaCustomAnim.metaCustomAnimNewHost.volume;
			JukeBox.SFX_VOLUME = pMetaConfig.metaCustomAnim.metaCustomAnimNewHost.volume;
			
			if (pMetaConfig.metaCustomAnim.metaCustomAnimNewHost.hasCustomAnim()) {
				try {
					var ca : WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget(pMetaConfig.metaCustomAnim.metaCustomAnimNewHost.getPathAsWidgetLocal());
					var d:Dictionary = new Dictionary();
					d["name"] = metaHostAlert.name;
					d["numViewers"] = metaHostAlert.numViewers;
					ca.showAnim(d, new Callback(onAnimEnded, this, null));
				} catch(e:Error) {
					SimpleSocket.DEBUGTRACE("Error New Host" + e.toString());
					CallbackTimerEffect.addWaitCallFctToActor(MainGame.dummyActor, endCmd, 1000);
				}
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
