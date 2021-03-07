package com.giveawaytool.ui {
	import com.lachhh.utils.Utils;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Help extends UIBase {
		public var viewCreditsVIP : ViewCreditsVIP   ;
		//public var viewHallOfFame : ViewHallOfFame;

		public function UI_Help() {
			super(AnimationFactory.ID_UI_CREDITSPROMO);
			viewCreditsVIP = new ViewCreditsVIP(this, creditsMc);
			//viewHallOfFame = new ViewHallOfFame(this, hallOfFameMc);

			registerClick(howToAlertsMc, onTutoAlerts);
			registerClick(howToGiveawayMc, onTutoGiveaway);
			registerClick(discordBtn, onDiscord);
			registerClick(discordMc, onDiscord);
			
			setNameOfDynamicBtn(howToGiveawayMc, "Giveaway tutorial");
			setNameOfDynamicBtn(howToAlertsMc, "Alerts tutorial");
			/*registerClick(jsbBtn, onClickJSB);
			registerClick(btn_googlePlay, onGooglePlay);
			registerClick(btn_ios, oniOs);
			registerClick(promoteBtn, onPromote);*/

			//setNameOfDynamicBtn(jsbBtn, "Website");
			
			refresh();
		}

		private function onDiscord() : void {Utils.navigateToURLAndRecord(VersionInfo.URL_DISCORD);}		
		private function onTutoAlerts() : void {new UI_YoutubePreview(VersionInfo.URL_TUTORIAL_V3_WIDGETALERTS);}	
		private function onTutoGiveaway() : void {new UI_YoutubePreview(VersionInfo.URL_TUTORIAL_GIVEAWAY);}
		
		
		private function showSubMsg():void {
			UI_PopUp.createOkOnly("It may take a couple of minutes before your sub activate.  Once you finished the payment,  close the app and reopen it in 15 minutes. Thanks!\n-Lachhh", null); 
		}
				
		public function get creditsMc() : MovieClip { return visual.getChildByName("creditsMc") as MovieClip;}
		public function get discordBtn() : MovieClip { return visual.getChildByName("discordBtn") as MovieClip;}
		public function get discordMc() : MovieClip { return visual.getChildByName("discordMc") as MovieClip;}
		public function get tutoBtn() : MovieClip { return visual.getChildByName("tutoBtn") as MovieClip;}
		public function get howToGiveawayMc() : MovieClip { return visual.getChildByName("howToGiveawayMc") as MovieClip;}
		public function get howToAlertsMc() : MovieClip { return visual.getChildByName("howToAlertsMc") as MovieClip;}
		
		
		
			
	}
}
