package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.ModelDonationAward;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationAward extends ViewBase {
		//public var modelAward:
		public var modelDonation:ModelDonationAward;
		public function ViewDonationAward(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			visualMc.gotoAndStop(1);
		}
		
		
		
		override public function refresh() : void {
			super.refresh();
			if(modelDonation.isNull) {
				visualMc.visible = false;
				return ;
			}
			visualMc.gotoAndStop(modelDonation.frame);
			visualMc.visible = true;
		}
	}
}
