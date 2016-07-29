package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.DisplayObject;
	/**
	 * @author LachhhSSD
	 */
	public class ViewCharityList extends ViewGenericListWithPages {

		public function ViewCharityList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}

		override public function createChildView() : ViewBase {
			return new ViewCharityDynamicBtn(screen, contentMc);
		}

		override public function onClickView(v : ViewBase) : void {
			super.onClickView(v);
			//if(!toolTip) return;
				
			//toolTip.onClickDonationView(v as ViewDonationBtn);
		}
	}
}
