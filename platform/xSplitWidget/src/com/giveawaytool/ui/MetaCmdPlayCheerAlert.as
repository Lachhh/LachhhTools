package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.MetaCheerAlert;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.lachhh.io.Callback;
	import com.lachhh.io.SimpleSocket;
	import com.lachhh.lachhhengine.sfx.JukeBox;

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
			JukeBox.MUSIC_VOLUME = pMetaConfig.metaCustomAnim.metaCustomAnimNewCheers.volume;
			JukeBox.SFX_VOLUME = pMetaConfig.metaCustomAnim.metaCustomAnimNewCheers.volume;
			
			if (pMetaConfig.metaCustomAnim.metaCustomAnimNewCheers.hasCustomAnim()) {
				try {
					var ca : WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget(pMetaConfig.metaCustomAnim.metaCustomAnimNewCheers.getPathAsWidgetLocal());
					var d:Dictionary = new Dictionary();
					d["name"] = metaCheerAlert.name;
					d["numBits"] = metaCheerAlert.numBits;
					ca.showAnim(d, new Callback(onAnimEnded, this, null));
				} catch(e:Error) {
					SimpleSocket.DEBUGTRACE("Error New Cheer" + e.toString());
					CallbackTimerEffect.addWaitCallFctToActor(MainGame.dummyActor, endCmd, 1000);
				}
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
