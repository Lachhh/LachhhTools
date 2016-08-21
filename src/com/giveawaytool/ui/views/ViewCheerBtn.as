package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCheerBtn extends ViewBase {
		private var viewDonation : ViewCheer;

		public function ViewCheerBtn(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewDonation = new ViewCheer(pScreen, donationMc);
		}	
		
		override public function refresh() : void {
			super.refresh();
			viewDonation.metaCheer = getMetaCheer();
			viewDonation.refresh();
		}

		public function getMetaCheer() : MetaCheer {
			return metaData as MetaCheer;
		}
		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
	}
}
