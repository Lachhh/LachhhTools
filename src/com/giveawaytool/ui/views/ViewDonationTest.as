package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationTest extends ViewDonation {
		public function ViewDonationTest(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			pScreen.registerEvent(nameTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(amountTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(msgTxt, FocusEvent.FOCUS_OUT, onEdit);
			
		}
		
		private function onEdit() : void {
			if(metaDonation == null) return ;
			var amount:int = FlashUtils.myParseFloat(amountTxt.text);
			
			if(!isNaN(amount)) metaDonation.amount = amount;
			metaDonation.donatorName = nameTxt.text;
			metaDonation.donatorMsg = msgTxt.text;
			
			MetaGameProgress.instance.saveToLocal();
			
			refresh(); 
		}
		
		override public function refresh() : void {
			super.refresh();
		}
		
		
		public function get testBtn() : MovieClip { return visual.getChildByName("testBtn") as MovieClip;}
	}
}
