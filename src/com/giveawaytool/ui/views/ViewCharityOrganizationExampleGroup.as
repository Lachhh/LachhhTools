package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.donations.MetaCharityOrganizationEnum;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewGroupBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCharityOrganizationExampleGroup extends ViewGroupBase {
		public function ViewCharityOrganizationExampleGroup(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			for (var i : int = 0; i < 4; i++) {
				var visualOfChild : MovieClip = getVisualAt(i);
				var newView : ViewCharityOrganizationExample = new ViewCharityOrganizationExample(pScreen, visualOfChild);
				newView.metaDonationOrganization = MetaCharityOrganizationEnum.getFromIndex(i);
			}
		}

		private function getVisualAt(i : int) : MovieClip {
			return visual.getChildByName("organisation" + i) as MovieClip;
		}
	}
}
