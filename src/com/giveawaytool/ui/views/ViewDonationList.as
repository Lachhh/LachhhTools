package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.DisplayObject;
	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationList extends ViewGenericListWithPages {
		public var toolTip : ViewDonationToolTip;

		public function ViewDonationList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
		}

		override public function createChildView() : ViewBase {
			return new ViewDonationDynamic(screen, contentMc);
		}

		override public function onClickView(v : ViewBase) : void {
			super.onClickView(v);
			if(!toolTip) return;
				
			toolTip.onClickDonationView(v as ViewFollowerBtn);
		}

		override public function refresh() : void {
			super.refresh();
			titleTxt.text = "Last donations";
		}
	}
}
