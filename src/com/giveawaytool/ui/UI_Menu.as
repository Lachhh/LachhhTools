package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.components.LogicNotifications;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Menu extends UIBase {
		private var viewCredits : ViewCredits;
		static private var logicNotification : LogicNotifications;

		public function UI_Menu() {
			super(AnimationFactory.ID_UI_MENU);
			viewCredits = new ViewCredits(this, creditsBtn);
			
			if(MainGame.dummyActor.getComponent(LogicNotifications) == null) {
				logicNotification = MainGame.dummyActor.addComponent(new LogicNotifications(MetaGameProgress.instance)) as LogicNotifications;			
			}
		}

		override public function refresh() : void {
			super.refresh();
			
			alertMc.visible = false;
		}

		public function get yourChannelMc() : MovieClip {
			return visual.getChildByName("yourChannelMc") as MovieClip;
		}
		
		public function get applyAndSaveBtn() : MovieClip { return visual.getChildByName("applyAndSaveBtn") as MovieClip;}
		public function get alertMc() : MovieClip { return visual.getChildByName("alertMc") as MovieClip;}
		public function get creditsBtn() : MovieClip { return visual.getChildByName("creditsBtn") as MovieClip;}
	}
}
