package com.giveawaytool.ui {
	import com.giveawaytool.ui.views.ViewDonationsEdit;
	import com.giveawaytool.ui.views.ViewSubTemp_DEPRECATED;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Donation extends UIBase {
		 //Stending : Lachhh, will we be able to buy other stuff than character customisation with XP? I mean, I really want to buy some things directly from YOU. Like a Kazoo song, or something else!
		public var viewDonationsEdit : ViewDonationsEdit;
		public var logicNavigation:LogicOnOffNextFrame;
		
		public function UI_Donation() {
			super(AnimationFactory.ID_UI_DONATION);
			
			logicNavigation = LogicOnOffNextFrame.addToActor(this, donationsMc);
			logicNavigation.invisibleOnFirstFrame = false;
			logicNavigation.isOn = false;
			
			txt.text = "Charity";
			lblTxt.text = "";
			registerClick(backBtn, onBack);
			registerClick(charityBtn, onClickCharity);

			viewDonationsEdit = new ViewDonationsEdit(this, donationsMc);
			//new ViewSubTemp(this, subMc);
			
			registerClick(creditsBtn, onCredits);
			
			refresh();
			
			viewDonationsEdit.initData();
		
		}

		private function onBack() : void {
			logicNavigation.isOn = false;
		}

		private function onClickCharity() : void {
			logicNavigation.isOn = true;
		}
		
		private function onCredits() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);
			//sendPlayMovie(MetaPlayMovie.createDummy());
		}
		
		public function get donationsMc() : MovieClip { return visual.getChildByName("donationsMc") as MovieClip;}
		public function get creditsBtn() : MovieClip { return visual.getChildByName("creditsBtn") as MovieClip;}
		//public function get subMc() : MovieClip { return visual.getChildByName("subMc") as MovieClip;}
		
		public function get charityBtn() : MovieClip { return donationsMc.getChildByName("charityBtn") as MovieClip;}
		public function get backBtn() : MovieClip { return donationsMc.getChildByName("backBtn") as MovieClip;}
		public function get txt() : TextField { return charityBtn.getChildByName("txt") as TextField;}
		public function get lblTxt() : TextField { return charityBtn.getChildByName("lblTxt") as TextField;}
		
			
	}
}
