package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class UI_DummyOverlay extends UIBase {
		public function UI_DummyOverlay() {
			super(AnimationFactory.ID_DUMMYOVERLAY);
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_BELOW);
		}
	}
}
