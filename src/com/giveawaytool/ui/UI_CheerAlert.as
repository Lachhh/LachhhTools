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
		private var viewHost : ViewHostSettings;
		private var viewCheer : ViewCheerSettings;
		public function UI_CheerAlert() {
			super(AnimationFactory.ID_UI_CHEERSALERTS);
			viewCheer = new ViewCheerSettings(this, cheerPanelMc);
			viewHost = new ViewHostSettings(this, hostPanelMc);
			
			
			refresh();
		}
		
		public function get cheerPanelMc() : MovieClip { return visual.getChildByName("cheerPanelMc") as MovieClip;}
		public function get hostPanelMc() : MovieClip { return visual.getChildByName("hostPanelMc") as MovieClip;}
		
	}
}
