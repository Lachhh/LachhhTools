package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewHostBtn extends ViewBase {
		private var viewDonation : ViewHost;

		public function ViewHostBtn(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewDonation = new ViewHost(pScreen, donationMc);
		}	
		
		override public function refresh() : void {
			super.refresh();
			viewDonation.metaHost = getMetaHost();
			viewDonation.refresh();
		}

		public function getMetaHost() : MetaHost {
			return metaData as MetaHost;
		}
		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
	}
}
