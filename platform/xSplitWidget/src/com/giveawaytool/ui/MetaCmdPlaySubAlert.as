package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.io.WidgetCustomAsset;
	import com.giveawaytool.io.WidgetCustomAssetManager;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaSubcriberAlert_widget;
	import com.lachhh.io.Callback;
	import com.lachhh.io.SimpleSocket;
	import com.lachhh.lachhhengine.sfx.JukeBox;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlaySubAlert extends MetaCmd {
		public var metaSubAlert:MetaSubcriberAlert_widget;
		

		public function MetaCmdPlaySubAlert(m : MetaSubcriberAlert_widget) {
			metaSubAlert = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			JukeBox.MUSIC_VOLUME = pMetaConfig.metaCustomAnim.metaCustomAnimNewSub.volume;
			JukeBox.SFX_VOLUME = pMetaConfig.metaCustomAnim.metaCustomAnimNewSub.volume;
			
			if (pMetaConfig.metaCustomAnim.metaCustomAnimNewSub.hasCustomAnim()) {
				try {
					var ca : WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget(pMetaConfig.metaCustomAnim.metaCustomAnimNewSub.getPathAsWidgetLocal());
					var d:Dictionary = new Dictionary();
					d["newSub"] = metaSubAlert.name;
					d["numMonthInARow"] = metaSubAlert.numMonthInARow;
					d["subSource"] = metaSubAlert.modelSubSource;
					d["gameWispTierStatus"] = metaSubAlert.metaGameWispSubInfo.status;
					d["gameWispTierCost"] = metaSubAlert.metaGameWispSubInfo.tierCostStr;
					d["gameWispTierTitle"] = metaSubAlert.metaGameWispSubInfo.tierTitle;
					d["gameWispTierDesc"] = metaSubAlert.metaGameWispSubInfo.tierDesc;
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
