package com.giveawaytool.ui.views {
	import com.giveawaytool.ui.MetaSubscriber;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubscriber extends ViewBase {
		public var metaSubscriber : MetaSubscriber = MetaSubscriber.NULL;

		public function ViewSubscriber(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}
		
				
		override public function refresh() : void {
			super.refresh();
			if(metaSubscriber == null || metaSubscriber.isNull()) {
				nameTxt.text = "---";
				amountTxt.text = "---";
				visualMc.gotoAndStop(1);
				return ;
			}
			visualMc.gotoAndStop((metaSubscriber.isNew ? 2 : 1));
			nameTxt.text = metaSubscriber.name + "";
			amountTxt.text = metaSubscriber.getMonthNumShort();
		}
		
		public function get nameTxt() : TextField { return visual.getChildByName("nameTxt") as TextField;}
		public function get amountTxt() : TextField { return visual.getChildByName("amountTxt") as TextField;}	
	}
}
