package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	/**
	 * @author LachhhSSD
	 */
	public class UI_NewCheerAnimExplode extends UIBase {

		public function UI_NewCheerAnimExplode() {
			super(AnimationFactory.ID_UI_NEWCHEEREXPLODE);
			
			renderComponent.animView.addEndCallback(new Callback(onEndAnim, this, null));
			renderComponent.animView.addCallbackOnFrame(new Callback(burp, this, null), 6);
		}

		private function burp() : void {
			JukeBox.playSoundAtVolume(SfxFactory.ID_SFX_BURP, 0.5);
		}

		private function onEndAnim() : void {
			destroy();
		}
		
	}
}
