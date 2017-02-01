package com.giveawaytool.ui {
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_VIPPromo extends UIBase {
		//public var viewCreditsVIP : ViewCreditsVIP   ;
		public var viewHallOfFame : ViewHallOfFame;
		public function UI_VIPPromo() {
			super(AnimationFactory.ID_UI_VIPPROMO);
			//viewCreditsVIP = new ViewCreditsVIP(this, creditsMc);
			viewHallOfFame = new ViewHallOfFame(this, hallOfFameMc);
			
			registerClick(patreonBtn, onClickPatreon);
			registerClick(jsbBtn, onClickJSB);
			registerClick(btn_googlePlay, onGooglePlay);
			registerClick(btn_ios, oniOs);
			//registerClick(promoteBtn, onPromote);

			setNameOfDynamicBtn(jsbBtn, "Website");
			
			refresh();
		}

		private function onPromote() : void {
			//new UI_YoutubePreview(VersionInfo.URL_TUTORIAL_PROMO);
		}

		private function onGooglePlay() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_ZOMBIDLE_ANDROID);
		}

		private function oniOs() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_ZOMBIDLE_IOS);
		}

		private function onClickJSB() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_JSB);
		}
		
		private function onClickPatreon() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_GAMEWISP_LACHHHTOOLS);
			CallbackTimerEffect.addWaitCallFctToActor(this, showSubMsg, 3000);
		}
		
		private function showSubMsg():void {
			UI_PopUp.createOkOnly("It may take a couple of minutes before your sub activate.  Once you finished the payment,  close the app and reopen it in 15 minutes. Thanks!\n-Lachhh", null); 
		}
				
		public function get creditsMc() : MovieClip { return visual.getChildByName("creditsMc") as MovieClip;}
		
		public function get patreonBtn() : MovieClip { return visual.getChildByName("patreonBtn") as MovieClip;}
		public function get jsbBtn() : MovieClip { return visual.getChildByName("jsbBtn") as MovieClip;}
		
		public function get btn_googlePlay() : MovieClip { return visual.getChildByName("btn_googlePlay") as MovieClip;}
		public function get btn_ios() : MovieClip { return visual.getChildByName("btn_ios") as MovieClip;}
		public function get promoteBtn() : MovieClip { return visual.getChildByName("promoteBtn") as MovieClip;}
		public function get hallOfFameMc() : MovieClip { return visual.getChildByName("hallOfFameMc") as MovieClip;}
		
			
	}
}
