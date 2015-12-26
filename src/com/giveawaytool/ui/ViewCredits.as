package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCredits extends ViewBase {
		public function ViewCredits(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			screen.registerClick(visual, onClick);
		}

		private function onClick() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);
		}
	}
}
