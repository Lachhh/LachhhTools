package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewHost extends ViewBase {
		public var metaHost: MetaHost = MetaHost.NULL;

		public function ViewHost(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}
		
				
		override public function refresh() : void {
			super.refresh();
			if(metaHost == null || metaHost.isNull()) {
				nameTxt.text = "---";
				amountTxt.text = "---";
				visualMc.gotoAndStop(1);
				return ;
			}
			visualMc.gotoAndStop(1);
			nameTxt.text = metaHost.name + "";
			amountTxt.text = metaHost.numViewers+"";
		}
		
		public function get nameTxt() : TextField { return visual.getChildByName("nameTxt") as TextField;}
		public function get amountTxt() : TextField { return visual.getChildByName("amountTxt") as TextField;}	
	}
}
