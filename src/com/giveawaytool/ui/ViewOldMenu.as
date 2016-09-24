package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;

	/**
	 * @author LachhhSSD
	 */
	public class ViewOldMenu extends ViewBase {
		public function ViewOldMenu(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			screen.registerClick(tutorialBtn, onTutorial);
			screen.registerClick(fullscreenBtn, onFullScreen);
			//screen.registerClick(musicBtn, onMusic);
			//screen.registerClick(lachhhBtn, onLachhh);
		}


		private function onLachhh() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);
		}
		
		private function onMusic() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_YOUTUBE_FAMILYJULES_7X);
		}

		private function onFullScreen() : void {
			MetaGameProgress.instance.metaToolConfig.nextScreenSize();
			
			refresh();
		}

		private function onTutorial() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TUTORIAL);
		}

		override public function refresh() : void {
			super.refresh();
			
			//screen.setNameOfDynamicBtn(tutorialBtn, "Tutorial");
			//screen.setNameOfDynamicBtn(musicBtn, "Music From\nFamilyJules7x");
			//screen.setNameOfDynamicBtn(lachhhBtn, "Lachhh's\nTwitch");
			
			if(!MetaGameProgress.instance.metaToolConfig.isFullscreen()) {
				var scale:Number = MetaGameProgress.instance.metaToolConfig.scaleOfWindow();
				var w:int = 1296;
				var h:int = 758;
				//screen.setNameOfDynamicBtn(fullscreenBtn, "Window " + (scale*100) + "%");
				visual.stage.displayState = StageDisplayState.NORMAL;
				visual.stage.nativeWindow.width = Math.floor(w*scale);
    			visual.stage.nativeWindow.height = Math.floor(h*scale);
				iconMc.gotoAndStop(1);
			} else {
				visual.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				iconMc.gotoAndStop(2);
				//screen.setNameOfDynamicBtn(fullscreenBtn, "FullScreen");
			}
		}

		public function get fullscreenBtn() : MovieClip {return visual.getChildByName("fullscreenBtn") as MovieClip;}
		public function get iconMc() : MovieClip { return fullscreenBtn.getChildByName("iconMc") as MovieClip;}		
		public function get tutorialBtn() : MovieClip { return visual.getChildByName("tutorialBtn") as MovieClip;}
		//public function get musicBtn() : MovieClip { return visual.getChildByName("musicBtn") as MovieClip;}
		//public function get lachhhBtn() : MovieClip { return visual.getChildByName("lachhhBtn") as MovieClip;}
	}
}
