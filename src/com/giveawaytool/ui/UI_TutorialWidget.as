package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.utils.Utils;
	import com.giveawaytool.DefaultMainGame;
	import flash.geom.Point;
	import com.giveawaytool.MainGame;
	import com.lachhh.ResolutionManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIOpenClose;

	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	/**
	 * @author LachhhSSD
	 */
	public class UI_TutorialWidget extends UIOpenClose {
		

		public function UI_TutorialWidget() {
			super(AnimationFactory.ID_UI_TUTORIALWIDGET, 30, 45);
			registerClick(xBtn, onClickX);
			registerClick(backMc, onClickX);
			registerClick(adobeLinkMc, onClickAdobeLink);

			px = ResolutionManager.getGameWidth() * 0.5;
			py = ResolutionManager.getGameHeight()*0.5;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			refresh();
		}

		private function onClickAdobeLink() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_ADOBE_LINK);
		}
		
		
		private function onClickX() : void {
			close();
		}

		public function get panel() : MovieClip {return visual.getChildByName("panel") as MovieClip;}
		public function get youtubeContainerMc() : MovieClip {return panel.getChildByName("youtubeContainerMc") as MovieClip;}
		public function get xBtn() : MovieClip { return panel.getChildByName("xBtn") as MovieClip;}
		public function get backMc() : MovieClip { return visual.getChildByName("backMc") as MovieClip;}
		public function get adobeLinkMc() : MovieClip { return panel.getChildByName("adobeLinkMc") as MovieClip;}
		
		
	}
}
