package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.donations.MetaCharityConfig;
	import com.giveawaytool.meta.donations.MetaCharityDonation;
	import com.giveawaytool.ui.UIPopUp;
	import com.giveawaytool.ui.UI_Donation;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCharity extends ViewBase {
		public var metaCharity : MetaCharityConfig;
		public var viewCharityList : ViewCharityDonationsList;
		public var viewCharityExamples : ViewCharityOrganizationExampleGroup;

		public function ViewCharity(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			viewCharityList = new ViewCharityDonationsList(screen, lastCharityMc);
			
			viewCharityExamples = new ViewCharityOrganizationExampleGroup(pScreen, organizationsListMc);
			
			pScreen.registerEvent(prctTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(titleTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(amountTxt, FocusEvent.FOCUS_OUT, onEdit);

			pScreen.registerClick(enableBtn, onEnable);
			pScreen.registerClick(addBtn, onAdd);
			pScreen.registerClick(applySaveBtn, onRefreshConfig);

			screen.setNameOfDynamicBtn(addBtn, "Record");
			screen.setNameOfDynamicBtn(applySaveBtn, "Apply & Save");
			
		}

		private function onRefreshConfig() : void {
			var ui:UI_Donation = (screen as UI_Donation);
			ui.sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
			
			MetaGameProgress.instance.metaDonationsConfig.isDirty = false;
			screen.doBtnPressAnim(applySaveBtn);
			MetaGameProgress.instance.saveToLocal();
			refresh();
		}

		private function onEnable() : void {
			metaCharity.settings.enabled = !metaCharity.settings.enabled;
			refresh();
		}

		private function onAdd() : void {
			if(!validateAmountToDonate()) return ; 
			var result:MetaCharityDonation = new MetaCharityDonation();
			result.nameOfOrganisation = organisationTxt.text;
			result.amount = metaCharity.settings.crntAmount;
			
			var msg:String = "Record that you have given [x] to [y]?";
			msg = FlashUtils.myReplace(msg, "[x]", metaCharity.settings.getAmountTxt());
			msg = FlashUtils.myReplace(msg, "[y]", result.nameOfOrganisation);
			UIPopUp.createYesNo(msg, new Callback(onYes, this, [result]), null);
			
			MetaGameProgress.instance.saveToLocal();
			
		}

		private function onYes(m:MetaCharityDonation) : void {
			metaCharity.addCharityDonation(m);
			UIBase.manager.refresh();
			
			UIPopUp.createOkOnly("Donation added!  Congrats! That's super awesome of you :).", null);
		}
		
		private function validateAmountToDonate():Boolean {
			if(organisationTxt.text == "") {
				UIPopUp.createOkOnly("The name or the organisation is empty.  Don't you want to remember who you gave it to?", null);
				return false;
			}
			
			if(metaCharity.settings.crntAmount <= 0) {
				UIPopUp.createOkOnly("The amount of money you want to give to that organisation is '0'.  That's kind of a jerk move isn't it?", null);
				return false;
			}
			return true;
		}

		private function onEdit() : void {
			if(metaCharity == null) return ;
			var prct:int = FlashUtils.myParseFloat(prctTxt.text);
			var crntAmount:Number = FlashUtils.myParseFloat(amountTxt.text);
			
			if(!isNaN(prct)) metaCharity.settings.prct = Utils.minMax(prct, 1, 100);
			if(!isNaN(crntAmount)) metaCharity.settings.crntAmount = Math.max(crntAmount, 0);
			metaCharity.settings.title = titleTxt.text;
			metaCharity.settings.enabled = enableBtn.isSelected; 
						
			MetaGameProgress.instance.saveToLocal();
			MetaGameProgress.instance.metaDonationsConfig.isDirty = true;
			screen.refresh(); 
		}

		override public function refresh() : void {
			super.refresh();
			if(metaCharity == null) return;
			viewCharityList.metaDonations = metaCharity.listOfPastDonations;
			viewCharityList.refresh();
			
			prctTxt.text = metaCharity.settings.prct+"";
			enableBtn.selectIfBoolean(metaCharity.settings.enabled);
			titleTxt.text = metaCharity.settings.title;
			amountTxt.text = metaCharity.settings.getAmountTxt();
			
			totalTxt.text = metaCharity.listOfPastDonations.getTotalAmountTxt();
			enableCheckedMc.visible = metaCharity.settings.enabled;
			
			organisationTxt.text = metaCharity.charityOrganization.name;
			dirtyNoticeMc.visible = MetaGameProgress.instance.metaDonationsConfig.isDirty;
		}
		
		public function get prctTxt():TextField { return (visual.getChildByName("prctTxt")) as TextField;}
		public function get enableBtn():ButtonSelect { return (visual.getChildByName("enableBtn")) as ButtonSelect;}
		public function get titleTxt():TextField { return (visual.getChildByName("titleTxt")) as TextField;}
		public function get amountTxt():TextField { return (visual.getChildByName("amountTxt")) as TextField;}
		public function get applySaveBtn() : MovieClip { return visual.getChildByName("applySaveBtn") as MovieClip;}
		public function get dirtyNoticeMc() : MovieClip { return visual.getChildByName("dirtyNoticeMc") as MovieClip;}
		
		
		
		
		public function get totalTxt():TextField { return (visual.getChildByName("totalTxt")) as TextField;}
		public function get lastCharityMc():MovieClip { return (visual.getChildByName("lastCharityMc")) as MovieClip;}
		public function get addBtn():MovieClip { return (visual.getChildByName("addBtn")) as MovieClip;}
		public function get organisationTxt():TextField { return (visual.getChildByName("organisationTxt")) as TextField;}
		public function get enableCheckedMc() : MovieClip { return enableBtn.getChildByName("checkedMc") as MovieClip;}
		
		public function get organizationsListMc() : MovieClip { return visual.getChildByName("organizationsListMc") as MovieClip;}
		
	}
}
