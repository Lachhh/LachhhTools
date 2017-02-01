package com.giveawaytool.ui {
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
	public class UI_LachhhToolsAds extends UIOpenClose {
		public function UI_LachhhToolsAds() {
			super(AnimationFactory.ID_UI_ZOMBIDLEAD, 920, 925);
			registerClick(xBtn, close);
			registerClick(btn_googlePlay, onGP);
			registerClick(btn_ios, onIos);
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			
			var d:DropShadowFilter = new DropShadowFilter();
			d.distance = 5;
			d.blurX = 3;
			d.blurY = 3;
			d.angle = 215;
			
			visual.filters = [d];
		}

		private function onGP() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_ZOMBIDLE_ANDROID);
		}

		private function onIos() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_ZOMBIDLE_IOS);
		}
		
		public function get zombidleMc() : MovieClip { return visual.getChildByName("zombidleMc") as MovieClip;}
		public function get btn_googlePlay() : MovieClip { return zombidleMc.getChildByName("btn_googlePlay") as MovieClip;}
		public function get btn_ios() : MovieClip { return zombidleMc.getChildByName("btn_ios") as MovieClip;}
		public function get xBtn() : MovieClip { return visual.getChildByName("xBtn") as MovieClip;}
		
		static public function hide():void {
			var ui:UI_LachhhToolsAds = UIBase.manager.getFirst(UI_LachhhToolsAds) as UI_LachhhToolsAds;
			if(ui) ui.close();
		}
	}
}
