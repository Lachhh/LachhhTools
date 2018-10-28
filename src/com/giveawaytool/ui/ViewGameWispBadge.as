package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.utils.Utils;
	import com.giveawaytool.io.playerio.MetaGameWispSub;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewGameWispBadge extends ViewBase {
		public var metaGameSub : MetaGameWispSub;

		public function ViewGameWispBadge(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			gameWispInfoMc.gotoAndStop(1);
			badgeMc.gotoAndStop(1);
			screen.registerClick(pVisual, onClick);
		}

		private function onClick() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);
		}

		override public function refresh() : void {
			super.refresh();
			if(metaGameSub == null || metaGameSub.isInactive()) {
				visual.visible = false;
				return ;
			}
			visual.visible = true;
			if(metaGameSub.hasPledgeGold()) {
				badgeMc.gotoAndStop(3);
			} else if(metaGameSub.hasPledgeSilver()) {
				badgeMc.gotoAndStop(2);
			} else if(metaGameSub.hasPledgeBronze()) {
				badgeMc.gotoAndStop(1);
			}
			
			if(metaGameSub.isExpiring()) {
				iconMc.gotoAndStop(4);
				gameWispInfoMc.gotoAndStop(2);
			} else {
				iconMc.gotoAndStop(badgeMc.currentFrame);
				gameWispInfoMc.gotoAndStop(1);
			}
		}

		public function get gameWispInfoMc() : MovieClip { return visual.getChildByName("gameWispInfoMc") as MovieClip;}
		public function get nameTxt() : TextField {return gameWispInfoMc.getChildByName("nameTxt") as TextField;}
		public function get iconMc() : MovieClip { return badgeMc.getChildByName("iconMc") as MovieClip;}
		public function get badgeMc() : MovieClip { return gameWispInfoMc.getChildByName("badgeMc") as MovieClip;}
		
	}
}
