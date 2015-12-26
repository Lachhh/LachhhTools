package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationBtn extends ViewBase {
		private var viewDonation:ViewDonation;
		public var metaDonation:MetaDonation;
		public function ViewDonationBtn(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewDonation = new ViewDonation(pScreen, donationMc);
		}
		
		
		override public function refresh() : void {
			super.refresh();
			viewDonation.metaDonation = metaDonation;
			viewDonation.refresh();
		}
		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
	}
}
