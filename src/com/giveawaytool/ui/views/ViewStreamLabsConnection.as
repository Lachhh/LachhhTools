package com.giveawaytool.ui.views {
	import com.giveawaytool.io.DonationSourceConnection;
	import com.giveawaytool.meta.donations.MetaDonationSourceConnection;
	import com.giveawaytool.ui.UIPopupDonationsSettings;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.UI_PopUp;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import mx.utils.StringUtil;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewStreamLabsConnection extends ViewBase {
		public var donationSourceConnection:DonationSourceConnection;
		public var onNewSettings : Callback;

		public function ViewStreamLabsConnection(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			donationSourceConnection = UI_Menu.instance.logicNotification.logicDonationsAutoFetch.donationSourceConnectionStreamLabs;

			statusMsgMc.gotoAndStop(1);
			screen.setNameOfDynamicBtn(settingsBtn, "Login");
			screen.registerClick(settingsBtn, onLogin);
			
		}
		 
		private function onLogin() : void {
			UI_Menu.instance.logicNotification.logicDonationsAutoFetch.logicStreamLabs.showLogin();
		}
	
		override public function refresh() : void {
			super.refresh();
			if(donationSourceConnection.active) {
				statusMsgMc.gotoAndStop(3);
				screen.setNameOfDynamicBtn(settingsBtn, "Reconnect");
			} else {
				statusMsgMc.gotoAndStop(1);
				screen.setNameOfDynamicBtn(settingsBtn, "Login");
			}
			
			titleTxt.text = "Fetch from " + donationSourceConnection.metaStreamTipConnection.modelSource.name;
		}
		
		public function get settingsBtn() : MovieClip { return visual.getChildByName("settingsBtn") as MovieClip;}
		public function get statusMc() : MovieClip { return visual.getChildByName("statusMc") as MovieClip;}
		public function get statusMsgMc() : MovieClip { return statusMc.getChildByName("statusMsgMc") as MovieClip;}
		
		public function get titleTxt() : TextField { return visual.getChildByName("titleTxt") as TextField;}	
		
	}
}
