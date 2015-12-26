package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.donations.MetaCharityOrganization;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCharityOrganizationExample extends ViewBase {
		public var metaDonationOrganization : MetaCharityOrganization;
		public function ViewCharityOrganizationExample(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			pScreen.setNameOfDynamicBtn(visitBtn, "Visit");

			pScreen.registerClick(visitBtn, onVisit);
		}

		private function onVisit() : void {
			Utils.navigateToURLAndRecord(metaDonationOrganization.urlWebsite);
		}

		override public function refresh() : void {
			super.refresh();
			if(metaDonationOrganization == null) {
				visual.visible = false;
				return;
			}
			visual.visible = true;
			nameTxt.text = metaDonationOrganization.name;
			descTxt.text = metaDonationOrganization.description;
		}

		public function get nameTxt() : TextField {return (visual.getChildByName("nameTxt")) as TextField;}
		public function get descTxt():TextField { return (visual.getChildByName("descTxt")) as TextField;}
		public function get visitBtn():MovieClip { return (visual.getChildByName("visitBtn")) as MovieClip;}
		
	}
}
