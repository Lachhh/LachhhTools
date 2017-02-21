package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonation extends ViewBase {
		public var metaDonation:MetaDonation = MetaDonation.NULL;
		public function ViewDonation(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			visualMc.gotoAndStop(2);
		}
				
		override public function refresh() : void {
			super.refresh();
			if(metaDonation == null || metaDonation.isNull()) {
				nameTxt.text = "---";
				amountTxt.text = "---";
				visualMc.gotoAndStop(1);
				return ;
			}
			visualMc.gotoAndStop((metaDonation.isNew ? 2 : 1));
			nameTxt.text = metaDonation.donatorName+"";
			amountTxt.text = metaDonation.getAmountTxt2Digit()+"";
		}
		
		public function get nameTxt() : TextField { return visual.getChildByName("nameTxt") as TextField;}
		public function get amountTxt() : TextField { return visual.getChildByName("amountTxt") as TextField;}
		public function get msgTxt() : TextField { return visual.getChildByName("msgTxt") as TextField;}
	}
}
