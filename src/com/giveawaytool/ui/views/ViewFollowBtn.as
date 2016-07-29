package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewFollowBtn extends ViewBase {
		private var viewDonation : ViewFollower;

		public function ViewFollowBtn(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewDonation = new ViewFollower(pScreen, donationMc);
		}	
		
		override public function refresh() : void {
			super.refresh();
			viewDonation.metaFollower = getMetaFollower();
			viewDonation.refresh();
		}

		public function getMetaFollower() : MetaFollower {
			return metaData as MetaFollower;
		}
		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
	}
}
