package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.ResolutionManager;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.UIOpenClose;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_AnnoyingPopup extends UIOpenClose {
		private var viewHall:ViewHallOfFame;
		public function UI_AnnoyingPopup() {
			super(AnimationFactory.ID_UI_ANNOYINGPOPUP, 30, 45);
			viewHall = new ViewHallOfFame(this, hallOfFameMc);
			registerClick(xBtn, onX);

			registerClick(lachhhTwitchMc, onLachhh);
			registerClick(lachhhBtn, onLachhh);
			
			registerClick(theBtnMc, onBerzerk);
			registerClick(berzerkCircleMc, onBerzerk);
			
			registerClick(gameWispCircleMc, onLachhSub);
			registerClick(gameWispBtn, onLachhSub);

			px = ResolutionManager.getGameWidth() * 0.5;
			py = ResolutionManager.getGameHeight()*0.5;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			
			UI_Menu.instance.viewMenuUISelect.onChest();
			refresh();
		}

		private function onLachhh() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);
		}

		private function onBerzerk() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_BERZERK);
		}

		private function onLachhSub() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF_SUB);
		}

		private function onX() : void {
			close();
		}
		
		static public function hide():void {
			var ui:UI_AnnoyingPopup = UIBase.manager.getFirst(UI_AnnoyingPopup) as UI_AnnoyingPopup;
			if(ui) ui.close();
		}
		
		public function get panel() : MovieClip { return visual.getChildByName("panel") as MovieClip;}
		public function get hallOfFameMc() : MovieClip { return panel.getChildByName("hallOfFameMc") as MovieClip;}
		public function get lachhhMc() : MovieClip { return panel.getChildByName("lachhhMc") as MovieClip;}
		
		public function get berzerkMc() : MovieClip { return panel.getChildByName("berzerkMc") as MovieClip;}
		public function get gameWispMc() : MovieClip { return panel.getChildByName("gameWispMc") as MovieClip;}
		public function get xBtn() : MovieClip { return panel.getChildByName("xBtn") as MovieClip;}
		
		public function get lachhhTwitchMc() : MovieClip { return lachhhMc.getChildByName("lachhhTwitchMc") as MovieClip;}
		public function get lachhhBtn() : MovieClip { return lachhhMc.getChildByName("lachhhBtn") as MovieClip;}
		
		public function get theBtnMc() : MovieClip { return berzerkMc.getChildByName("theBtnMc") as MovieClip;}
		public function get berzerkCircleMc() : MovieClip { return berzerkMc.getChildByName("circleMc") as MovieClip;}
		
		public function get gameWispBtn() : MovieClip { return gameWispMc.getChildByName("subTwitchMc") as MovieClip;}
		public function get gameWispCircleMc() : MovieClip { return gameWispMc.getChildByName("circleMc") as MovieClip;}
		
	}
}
