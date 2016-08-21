package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCheer extends ViewBase {
		public var metaCheer : MetaCheer = MetaCheer.NULL;

		public function ViewCheer(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}
		
				
		override public function refresh() : void {
			super.refresh();
			if(metaCheer == null || metaCheer.isNull()) {
				nameTxt.text = "---";
				amountTxt.text = "---";
				visualMc.gotoAndStop(1);
				return ;
			}
			visualMc.gotoAndStop(1);
			nameTxt.text = metaCheer.name + "";
			amountTxt.text = metaCheer.numBits+"";
		}
		
		public function get nameTxt() : TextField { return visual.getChildByName("nameTxt") as TextField;}
		public function get amountTxt() : TextField { return visual.getChildByName("amountTxt") as TextField;}	
	}
}
