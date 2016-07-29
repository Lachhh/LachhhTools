package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewFollowerBtn extends ViewBase {
		private var viewDonation:ViewDonation;
		//public var metaDonation:MetaDonation;
		public function ViewFollowerBtn(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewDonation = new ViewDonation(pScreen, donationMc);
		}
		
		
		override public function refresh() : void {
			super.refresh();
			viewDonation.metaDonation = getMetaDonation();
			viewDonation.refresh();
		}
		
		public function getMetaDonation():MetaDonation { return metaData as MetaDonation;}
		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
	}
}
