package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.EffectFadeInAlpha;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class UI_NoConnection extends UIBase {

		public function UI_NoConnection() {
			super(AnimationFactory.ID_UI_NOCONNECTION);
			
			renderComponent.animView.isLooping = false;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_BELOW);
		}
		
		static public function closeAllNoConnection():void {
			var uiNews:UI_NoConnection = UIBase.manager.getFirst(UI_NoConnection) as UI_NoConnection;
			if(uiNews) uiNews.destroy();
		}

		public static function show() : void {
			var uiNews:UI_NoConnection = UIBase.manager.getFirst(UI_NoConnection) as UI_NoConnection;
			if(uiNews == null) uiNews = new UI_NoConnection();
		}
	}
}


