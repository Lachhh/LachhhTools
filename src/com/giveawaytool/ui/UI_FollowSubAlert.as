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

		public function UI_FollowSubAlert() {
			super(AnimationFactory.ID_UI_FOLLOWSUBALERT);
			viewFollower = new ViewFollowerSettings(this, followAlertsMc);
			viewSubscriber = new ViewSubscriberSettings(this, subAlertMc);
			refresh();
		}
		
		public function get followAlertsMc() : MovieClip { return visual.getChildByName("followAlertsMc") as MovieClip;}
		public function get subAlertMc() : MovieClip { return visual.getChildByName("subAlertMc") as MovieClip;}
	}
}
