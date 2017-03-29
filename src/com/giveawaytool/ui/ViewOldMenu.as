package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;

	/**
	 * @author LachhhSSD
	 */
	public class ViewOldMenu extends ViewBase {
		public function ViewOldMenu(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			screen.registerClick(fullscreenBtn, onFullScreen);
		}




		private function onFullScreen() : void {
			MetaGameProgress.instance.metaToolConfig.nextScreenSize();
			refresh();
		}


		override public function refresh() : void {
			super.refresh();
			
			refreshScreensize();
				
		}
		
		private function refreshScreensize():void {
			if(!MetaGameProgress.instance.metaToolConfig.isFullscreen()) {
				setFullscreen();
				iconMc.gotoAndStop(2);
			} else {
				setWindow();
				iconMc.gotoAndStop(1);
			}
		}
		
		private function setFullscreen():void {
			if(visual.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) return ;
			visual.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
		}
		
		private function setWindow():void {
			if(visual.stage.displayState == StageDisplayState.NORMAL) return ;
			var scale:Number = MetaGameProgress.instance.metaToolConfig.scaleOfWindow();
			var w:int = 1296;
			var h:int = 758;
			//screen.setNameOfDynamicBtn(fullscreenBtn, "Window " + (scale*100) + "%");
			visual.stage.displayState = StageDisplayState.NORMAL;
			visual.stage.nativeWindow.width = Math.floor(w*scale);
			visual.stage.nativeWindow.height = Math.floor(h*scale);
		
		}

		public function get fullscreenBtn() : MovieClip {return visual.getChildByName("fullscreenBtn") as MovieClip;}
		public function get iconMc() : MovieClip { return fullscreenBtn.getChildByName("iconMc") as MovieClip;}		
		//public function get tutorialBtn() : ButtonSelect { return visual.getChildByName("tutorialBtn") as ButtonSelect;}
		//public function get musicBtn() : MovieClip { return visual.getChildByName("musicBtn") as MovieClip;}
		//public function get lachhhBtn() : MovieClip { return visual.getChildByName("lachhhBtn") as MovieClip;}
	}
}
