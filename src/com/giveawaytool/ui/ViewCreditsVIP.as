package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.utils.Utils;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCreditsVIP extends ViewBase {
		public function ViewCreditsVIP(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			screen.registerClick(emilieBtn, onEmilie);
			screen.registerClick(marcBtn, onMarc);
			screen.registerClick(lachhhBtn, onLachhhTWitch);
			
			screen.registerClick(emilieTwitterBtn, onEmilie);
			screen.registerClick(marcTwitterBtn, onMarc);
			screen.registerClick(lachhhTwitterBtn, onLachhh);
			
			screen.registerClick(lachhhTwitchBtn, onLachhhTWitch);
		}

		private function onEmilie() : void {Utils.navigateToURLAndRecord(VersionInfo.URL_TWITTER_EM);}
		private function onMarc() : void {Utils.navigateToURLAndRecord(VersionInfo.URL_TWITTER_MARC);}
		private function onLachhh() : void {Utils.navigateToURLAndRecord(VersionInfo.URL_TWITTER_LACHHH);}		
		private function onLachhhTWitch() : void {Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);}
		
		public function get emilieBtn() : MovieClip { return visual.getChildByName("emilieBtn") as MovieClip;}
		public function get marcBtn() : MovieClip { return visual.getChildByName("marcBtn") as MovieClip;}
		public function get lachhhBtn() : MovieClip { return visual.getChildByName("lachhhBtn") as MovieClip;}
		
		public function get emilieTwitterBtn() : MovieClip { return visual.getChildByName("emilieTwitterMc") as MovieClip;}
		public function get marcTwitterBtn() : MovieClip { return visual.getChildByName("marcTwitterMc") as MovieClip;}
		public function get lachhhTwitterBtn() : MovieClip { return visual.getChildByName("lachhhTwitterMc") as MovieClip;}
		public function get lachhhTwitchBtn() : MovieClip { return visual.getChildByName("lachhhTwitchMc") as MovieClip;}
	}
}
