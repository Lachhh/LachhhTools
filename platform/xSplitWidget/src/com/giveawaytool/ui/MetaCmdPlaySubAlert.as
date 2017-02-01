package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaSubcriberAlert;
	import com.lachhh.io.Callback;
	import com.lachhh.io.SimpleSocket;

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
				try {
					var ca : WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget(pMetaConfig.metaCustomAnim.metaCustomAnimNewSub.getPathAsWidgetLocal());
					var d:Dictionary = new Dictionary();
					d["newSub"] = metaSubAlert.name;
					d["numMonthInARow"] = metaSubAlert.numMonthInARow;
					ca.showAnim(d, new Callback(endCmd, this, null));
				} catch(e:Error) {
					SimpleSocket.DEBUGTRACE("Error New Sub" + e.toString());
					CallbackTimerEffect.addWaitCallFctToActor(MainGame.dummyActor, endCmd, 1000);
				}
			} else {
				var ui:UI_NewSubAnim = new UI_NewSubAnim(metaSubAlert);
				ui.callbackOnDestroy = new Callback(endCmd, this, null);
			}  
		}

	}
}
