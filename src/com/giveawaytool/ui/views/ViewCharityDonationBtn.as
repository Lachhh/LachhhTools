package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.donations.MetaCharityDonation;
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCharityDonationBtn extends ViewBase {
		private var viewDonation:ViewCharityDonation;
		public var metaDonation : MetaCharityDonation;

		public function ViewCharityDonationBtn(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewDonation = new ViewCharityDonation(pScreen, donationMc);
		}
		
		
		override public function refresh() : void {
			super.refresh();
			viewDonation.metaDonation = metaDonation;
			viewDonation.refresh();
		}
		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
	}
}
