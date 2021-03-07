package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaCharityPrct;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCharity extends ViewBase {
		public var value:Number = 0;
		public var metaCharity:MetaCharityPrct;
		public function ViewCharity(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}

		override public function refresh() : void {
			super.refresh();
			if(metaCharity == null) {
				visual.visible = false;
				return ;
			}
			visual.visible = metaCharity.isEnabled();
			 
			charityAmountTxt.text = "$" + value.toFixed(2);
			charityTitleTxt.text = metaCharity.title;
			prctTxt.text = "(" + metaCharity.prct + "%)";
		}

		public function get charityTitleTxt() : TextField {return visual.getChildByName("charityTitleTxt") as TextField;}
		public function get charityAmountTxt() : TextField { return visual.getChildByName("charityAmountTxt") as TextField;}
		public function get prctTxt() : TextField { return visual.getChildByName("prctTxt") as TextField;}
	}
}
