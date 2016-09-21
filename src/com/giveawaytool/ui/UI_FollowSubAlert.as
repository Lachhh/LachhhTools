package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_FollowSubAlert extends UIBase {
		// Stending : Lachhh, will we be able to buy other stuff than character customisation with XP? I mean, I really want to buy some things directly from YOU. Like a Kazoo song, or something else!
		public var viewFollower : ViewFollowerSettings;
		public var viewSubscriber : ViewSubscriberSettings;
		public var viewHost : ViewHostSettings;
		public var logicOnOff:LogicOnOffNextFrame;

		public function UI_FollowSubAlert() {
			super(AnimationFactory.ID_UI_FOLLOWSUBALERT);
			renderComponent.animView.stop();
			viewFollower = new ViewFollowerSettings(this, followAlertsMc);
			viewSubscriber = new ViewSubscriberSettings(this, subAlertMc);
			viewHost = new ViewHostSettings(this, hostPanelMc);
			registerClick(moreBtn, onMore);
			registerClick(backBtn, onBack);
			logicOnOff = addComponent(new LogicOnOffNextFrame(visual)) as LogicOnOffNextFrame;
			logicOnOff.isOn = false;
			logicOnOff.invisibleOnFirstFrame = false;

			refresh();
		}

		private function onMore() : void {
			logicOnOff.isOn = true;
		}

		private function onBack() : void {
			logicOnOff.isOn = false;
		}
		
		public function get followAlertsMc() : MovieClip { return visual.getChildByName("followAlertsMc") as MovieClip;}
		public function get subAlertMc() : MovieClip { return visual.getChildByName("subAlertMc") as MovieClip;}
		public function get hostPanelMc() : MovieClip { return visual.getChildByName("hostPanelMc") as MovieClip;}
		public function get moreBtn() : MovieClip { return visual.getChildByName("moreBtn") as MovieClip;}
		public function get backBtn() : MovieClip { return visual.getChildByName("backBtn") as MovieClip;}		
	}
}
