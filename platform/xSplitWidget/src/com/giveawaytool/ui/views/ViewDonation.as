package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaDonation;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonation extends ViewBase {
		public var metaDonation:MetaDonation = MetaDonation.createDummy();
		public var amount:Number = 0;
		public function ViewDonation(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
		}
	
		
		override public function refresh() : void {
			super.refresh();
			nameTxt.text = metaDonation.getDonatorName();
			msgTxt.text = metaDonation.getDonationMsg();
			amountTxt.text = "$" + amount.toFixed(2);
		}
		
		public function get nameTxt() : TextField { return visual.getChildByName("nameTxt") as TextField;}
		public function get amountTxt() : TextField { return amountMc.getChildByName("amountTxt") as TextField;}
		public function get msgTxt() : TextField { return visual.getChildByName("msgTxt") as TextField;}
		
		public function get amountMc() : MovieClip { return visual.getChildByName("amountMc") as MovieClip;}
		
	}
}
