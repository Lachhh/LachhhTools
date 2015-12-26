package com.giveawaytool.ui {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;

	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UIPopupEditDonations extends UIPopUp {
		public var metaDonationToChange:MetaDonation ;
		public var metaDonationPending:MetaDonation ;
		public var onSaveCallback:Callback; 
		
		public function UIPopupEditDonations(pMetaDonation : MetaDonation) {
			super("Edit Donation");
			metaDonationToChange = pMetaDonation;
			metaDonationPending = metaDonationToChange.clone();
			setAnim(AnimationFactory.ID_UI_POPUPEDITDONATION);
			registerClick(btn3, onSave);
			registerClick(newBtn, onNewBtn);
			
			registerEvent(nameTxt, FocusEvent.FOCUS_OUT, onEdit);
			registerEvent(msgTxt, FocusEvent.FOCUS_OUT, onEdit);
			registerEvent(amountTxt, FocusEvent.FOCUS_OUT, onEdit);
			panel.gotoAndStop(1);
			renderComponent.animView.controlChildrenTimeLineRecursively = false;
			refresh();
		}

		private function onNewBtn() : void {
			if(metaDonationPending.modelSource.isCalculated()) return ; 
			metaDonationPending.isNew = !metaDonationPending.isNew;
			refresh(); 
		}

		private function onEdit() : void {
			var amount:Number = FlashUtils.myParseFloat(amountTxt.text);
			
			if(!isNaN(amount)) {
				metaDonationPending.amount = Math.max(amount, 0);
			}
			
			metaDonationPending.donatorName = nameTxt.text;
			if(!metaDonationPending.modelSource.isCalculated()) metaDonationPending.donatorMsg = msgTxt.text;
			refresh(); 
		}
		
		
		override public function refresh() : void {
			super.refresh();
			if(metaDonationPending == null) return ;
			panel.gotoAndStop(metaDonationPending.modelSource.isCalculated() ? 2 : 1);
			nameTxt.text = metaDonationPending.donatorName;
			amountTxt.text = metaDonationPending.amount+"";
			checkedMc.visible = metaDonationPending.isNew;
			
			if(metaDonationPending.modelSource.isCalculated()) {
				Utils.PutBlackAndWhite(newBtn, true);
				msgTxt.text = "---";
			} else {
				Utils.PutBlackAndWhite(newBtn, false);
				msgTxt.text = metaDonationPending.donatorMsg;
			}
		}
		
		public function onSave() : void {
			metaDonationToChange.decode(metaDonationPending.encode());
		}
		
		static public function createEditDonation(metaDonation:MetaDonation, onSave:Callback):UIPopupEditDonations {
			var result:UIPopupEditDonations = new UIPopupEditDonations(metaDonation);
			
			result.btn1Callback = null;
			result.btn2Callback = null;
			result.btn3Callback = onSave;
			result.setNameOfBtnByIndex(1, "Cancel");
			result.setNameOfBtnByIndex(2, "");
			result.setNameOfBtnByIndex(3, "Save");
			result.btn2.visible = false;
			
			return result;
		}

		
		
		public function setNameOfBtnByIndex(i:int, name:String):void {
			switch(i) {
				case 1 : setNameOfDynamicBtn(btn1, name); break;
				case 2 : setNameOfDynamicBtn(btn2, name); break;
				case 3 : setNameOfDynamicBtn(btn3, name); break; 
			}
		}
		
		
		public function get nameTxt():TextField { return (panel.getChildByName("nameTxt")) as TextField;}
		public function get amountTxt():TextField { return (panel.getChildByName("amountTxt")) as TextField;}
		public function get newBtn():MovieClip { return (panel.getChildByName("newBtn")) as MovieClip;}
		public function get msgTxt():TextField { return (panel.getChildByName("msgTxt")) as TextField;}
		public function get checkedMc():MovieClip { return (newBtn.getChildByName("checkedMc")) as MovieClip;}
		
	}
}
