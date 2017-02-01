package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.lachhh.io.SimpleSocket;
	import com.flashinit.ReleaseDonationInitWithoutNewsWithTExtDebug;
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
			
			if(pMetaConfig.metaCustomAnim.metaCustomAnimNewFollow.hasCustomAnim()) {
				try {
					var ca:WidgetCustomAsset = WidgetCustomAssetManager.getOrCreateCustomWidget(pMetaConfig.metaCustomAnim.metaCustomAnimNewFollow.getPathAsWidgetLocal());
					var d:Dictionary = new Dictionary();
					d["newFollower"] = metaNewFollower.name;
					ca.showAnim(d, new Callback(endCmd, this, null));
				} catch(e:Error) {
					SimpleSocket.DEBUGTRACE("ErrorNew Follow" + e.toString());
					CallbackTimerEffect.addWaitCallFctToActor(MainGame.dummyActor, endCmd, 1000);
				}
			} else {
				var ui:UI_NewFollowerAnim = new UI_NewFollowerAnim(metaNewFollower);
				ui.callbackOnDestroy = new Callback(endCmd, this, null);
			} 
		}		
	}
}
