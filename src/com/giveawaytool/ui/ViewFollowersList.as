package com.giveawaytool.ui {
	import com.giveawaytool.ui.views.ViewFollowBtn;
	import com.giveawaytool.ui.views.ViewFollowerToolTip;
	import com.giveawaytool.ui.views.ViewDonationToolTip;
	import com.giveawaytool.ui.views.ViewFollowerDynamic;
	import com.giveawaytool.ui.views.ViewDonationDynamic;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.giveawaytool.ui.views.ViewGenericListWithPages;

	import flash.display.DisplayObject;

	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class ViewFollowersList extends ViewGenericListWithPages {
		public var toolTip:ViewFollowerToolTip;
		public function ViewFollowersList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}

		override public function createChildView() : ViewBase {
			return new ViewFollowerDynamic(screen, contentMc);
		}

		override public function refresh() : void {
			super.refresh();
			titleTxt.text = "Last Followers";
			totalTxt.visible = false;
		}

		override public function onClickView(v : ViewBase) : void {
			super.onClickView(v);
			if(!toolTip) return ;
			toolTip.onClickFollowerView(v as ViewFollowBtn);
		}
	}
}
