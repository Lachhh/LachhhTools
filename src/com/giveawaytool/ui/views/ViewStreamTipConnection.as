package com.giveawaytool.ui.views {
	import mx.utils.StringUtil;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.giveawaytool.io.DonationSourceConnection;
	import com.giveawaytool.meta.donations.MetaDonationSourceConnection;
	import com.giveawaytool.ui.UI_PopUp;
	import com.giveawaytool.ui.UIPopupDonationsSettings;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewStreamTipConnection extends ViewBase {
		public var donationSourceConnection:DonationSourceConnection;
		public var metaConnection:MetaDonationSourceConnection;
		private var uiSettings:UIPopupDonationsSettings ;
		public var onNewSettings:Callback;
		public function ViewStreamTipConnection(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			donationSourceConnection = new DonationSourceConnection();

			statusMsgMc.gotoAndStop(1);
			screen.setNameOfDynamicBtn(settingsBtn, "Settings");
			screen.registerClick(settingsBtn, onSettings);
		}
		
		///test_479c924413fe9168952891e9a30 
		private function onSettings() : void {
			uiSettings = UIPopupDonationsSettings.createInsertDonationSettings(VersionInfo.donationSource.name + " Settings", new Callback(onApply, this, null), new Callback(onHelp, this, null));
			uiSettings.clientIdTxt.text = metaConnection.clientId;
			uiSettings.accessTokenTxt.text = metaConnection.accessToken;
		}
	
		private function onHelp() : void {
			UI_PopUp.createOkOnlySimple("Go on your StreamTip account to check for something called 'API Client ID' and 'API Access Token'.  It's in your account information. (Button on top right). You can do it! I believe in you! :D");
		}

		private function onApply() : void {
			metaConnection.clientId = StringUtil.trim(uiSettings.clientIdTxt.text);
			metaConnection.accessToken = StringUtil.trim(uiSettings.accessTokenTxt.text);
			
			if(onNewSettings) onNewSettings.call();
		}
		
		override public function refresh() : void {
			super.refresh();
			donationSourceConnection.metaStreamTipConnection = metaConnection;
			if(donationSourceConnection.active) {
				statusMsgMc.gotoAndStop(3);
			} else {
				statusMsgMc.gotoAndStop(1);
			}
			
			
			titleTxt.text = "Fetch from " + VersionInfo.donationSource.name;
		}
		
		public function get settingsBtn() : MovieClip { return visual.getChildByName("settingsBtn") as MovieClip;}
		public function get statusMc() : MovieClip { return visual.getChildByName("statusMc") as MovieClip;}
		public function get statusMsgMc() : MovieClip { return statusMc.getChildByName("statusMsgMc") as MovieClip;}
		
		public function get titleTxt() : TextField { return visual.getChildByName("titleTxt") as TextField;}	
		
	}
}
