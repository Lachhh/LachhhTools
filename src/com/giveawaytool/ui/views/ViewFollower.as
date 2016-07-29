package com.giveawaytool.ui.views {
	import com.lachhh.utils.Utils;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewFollower extends ViewBase {
		public var metaFollower:MetaFollower = MetaFollower.NULL;
		public function ViewFollower(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}
		
				
		override public function refresh() : void {
			super.refresh();
			if(metaFollower == null || metaFollower.isNull()) {
				nameTxt.text = "---";
				amountTxt.text = "---";
				visualMc.gotoAndStop(1);
				return ;
			}
			visualMc.gotoAndStop((metaFollower.isNew ? 2 : 1));
			nameTxt.text = metaFollower.name + "";
			amountTxt.text = metaFollower.getDateForView()+"";
			Utils.SetMaxSizeOfTxtField(amountTxt, 16);
		}
		
		public function get nameTxt() : TextField { return visual.getChildByName("nameTxt") as TextField;}
		public function get amountTxt() : TextField { return visual.getChildByName("amountTxt") as TextField;}	
	}
}
