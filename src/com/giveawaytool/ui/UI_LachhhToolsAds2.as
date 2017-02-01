package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import flash.filters.DropShadowFilter;
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIOpenClose;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_LachhhToolsAds2 extends UIOpenClose {
		public function UI_LachhhToolsAds2() {
			super(AnimationFactory.ID_UI_JSB_ADS, 430, 435);
			registerClick(xBtn, close);
			registerClick(jsbBtn, onJSB);
			setNameOfDynamicBtn(jsbBtn, "Website");
			
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			
			var d:DropShadowFilter = new DropShadowFilter();
			d.distance = 5;
			d.blurX = 3;
			d.blurY = 3;
			d.angle = 215;
			
			visual.filters = [d];

			renderComponent.animView.addCallbackOnFrame(new Callback(onShake, this, null), 135);
		}

		private function onShake() : void {
			UI_Menu.instance.shakeAll();
		}

		private function onJSB() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_JSB);
		}

		
		public function get jsbPanelMc() : MovieClip { return visual.getChildByName("jsbPanelMc") as MovieClip;}
		public function get jsbBtn() : MovieClip { return jsbPanelMc.getChildByName("jsbBtn") as MovieClip;}
		public function get xBtn() : MovieClip { return visual.getChildByName("xBtn") as MovieClip;}
		
		static public function hide():void {
			var ui:UI_LachhhToolsAds = UIBase.manager.getFirst(UI_LachhhToolsAds) as UI_LachhhToolsAds;
			if(ui) ui.close();
		}
	}
}
