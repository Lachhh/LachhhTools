package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;

	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UIPopupDonationsSettings extends UI_PopUp {
		public function UIPopupDonationsSettings(pMsg : String) {
			super(pMsg);
		}
		
		
		override public function refresh() : void {
			super.refresh();
		}
		
		public function get clientIdTxt() : TextField { return panel.getChildByName("clientIdTxt") as TextField;}
		public function get accessTokenTxt() : TextField { return panel.getChildByName("accessTokenTxt") as TextField;}
		
		static public function createInsertDonationSettings(msg:String, onApply:Callback, onHelp:Callback):UIPopupDonationsSettings {
			var result:UIPopupDonationsSettings = new UIPopupDonationsSettings(msg);
			result.setAnim(AnimationFactory.ID_UI_POPUPDONATIONSETTINGS);
			result.btn1Callback = null;
			result.btn2Callback = onApply;
			result.btn3Callback = onHelp;
			result.setNameOfBtnByIndex(1, "Cancel");
			result.setNameOfBtnByIndex(2, "Apply");
			result.setNameOfBtnByIndex(3, "Help");
			
			return result;
		}
		
		public function setNameOfBtnByIndex(i:int, name:String):void {
			switch(i) {
				case 1 : setNameOfDynamicBtn(btn1, name); break;
				case 2 : setNameOfDynamicBtn(btn2, name); break;
				case 3 : setNameOfDynamicBtn(btn3, name); break; 
			}
		}
	}
}
