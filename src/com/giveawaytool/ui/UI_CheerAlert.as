package com.giveawaytool.ui {
	import com.giveawaytool.ui.views.MetaHost;
	import com.giveawaytool.ui.views.MetaCheer;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_CheerAlert extends UIBase {
		
		private var viewCheer : ViewCheerSettings;
		public function UI_CheerAlert() {
			super(AnimationFactory.ID_UI_CHEERSALERTS);
			viewCheer = new ViewCheerSettings(this, cheerPanelMc);
			refresh();
		}
		
		public function get cheerPanelMc() : MovieClip { return visual.getChildByName("cheerPanelMc") as MovieClip;}
		
		
	}
}
