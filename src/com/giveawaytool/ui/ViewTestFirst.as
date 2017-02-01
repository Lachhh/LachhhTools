package com.giveawaytool.ui {
	import com.animation.exported.UI_MENU;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewTestFirst extends ViewBase {
		public var logicOnOff : LogicOnOffNextFrame;
		public var metaHasBeenTested : MetaHasBeenTested;
		public var callbackOnTest : Callback;
		public function ViewTestFirst(pScreen:UIBase, pVisual:DisplayObject) {
			super(pScreen, pVisual);
			logicOnOff = screen.addComponent(new LogicOnOffNextFrame(visualMc)) as LogicOnOffNextFrame;
			logicOnOff.invisibleOnFirstFrame = false;
			screen.registerClick(activateBtn, onActivate);
			screen.registerClick(previewYoutube, onPreview);
		}

		private function onPreview() : void {
			new UI_YoutubePreview(metaHasBeenTested.modelAlertType.urlPreviewOnYoutube);
			
		}

		private function onActivate() : void {
			if(!TwitchConnection.isLoggedIn()) {
				UI_Menu.instance.viewTwitchConnect.onLogin();
				return ;
			}
			
			if(!canTest())  {
				UI_Menu.instance.viewMenuAlerts.shakeNoWidget();
				new UI_TutorialWidget();
				return;
			}
			metaHasBeenTested.testWidget();
			UI_Loading.show("Sending alert to widget in OBS/xSplit...");
			CallbackTimerEffect.addWaitCallFctToActor(screen, onFinish, 2000);
		}

		private function onFinish() : void {
			UI_Loading.hide();
			UI_PopUp.createYesNo("Did the animation appear in xSplit/OBS ?", new Callback(onYes, this, null), new Callback(onNo, this, null));
		}

		private function onNo() : void {
			UI_PopUp.createOkOnly("Hmmm, let me show up the tutorial again. Are you sure you've selected the correct file in your USER DOCUMENTS?", new Callback(onTutorial, this, null));
		}

		private function onTutorial() : void {
			new UI_TutorialWidget();
		}

		private function onYes() : void {
			metaHasBeenTested.hasBeenTested = true;
			MetaGameProgress.instance.saveToLocal();
			UI_PopUp.createOkOnly("Sweet! You're good to go, have fun!", new Callback(refresh, this, null));
		}

		override public function refresh() : void {
			super.refresh();
			if(metaHasBeenTested == null) return ;
			logicOnOff.isOn = metaHasBeenTested.hasBeenTested && canTest();
			previewYoutubeTxt.text = metaHasBeenTested.modelAlertType.getPlayOnTxt();
			
			refreshQuickFix();
		}

		private function refreshQuickFix() : void {
			if(!TwitchConnection.isLoggedIn()) {
				testTxt.text = "Not connected on Twitch!";
				testTxt.textColor = 0xCEAE00;
				txt.text = "Login on Twitch".toUpperCase();
			} else if(!UI_Menu.instance.logicNotification.logicSendToWidget.hasAWidgetConnected()) {
				testTxt.text = "Widget not found :(";
				testTxt.textColor = 0xCEAE00;
				txt.text = "How to install".toUpperCase();
			} else {
				testTxt.text = "Press to test!";
				testTxt.textColor = 0x00CC00;
				txt.text = "Test alert".toUpperCase();
			}
		}
		
		public function canTest():Boolean {
			if(!UI_Menu.instance.logicNotification.logicSendToWidget.hasAWidgetConnected()) return false;
			if(!TwitchConnection.isLoggedIn()) return false;
			return true;
		}
		
		public function skipAnim():void {
			logicOnOff.isOn = metaHasBeenTested.hasBeenTested;
			logicOnOff.quickGoto();
		}
		

		public function get activateBtn() : MovieClip {return visual.getChildByName("activateBtn") as MovieClip;}
		public function get txt() : TextField { return activateBtn.getChildByName("txt") as TextField;}
		public function get testTxt() : TextField { return activateBtn.getChildByName("testTxt") as TextField;}
		public function get previewYoutube() : MovieClip { return visual.getChildByName("previewYoutube") as MovieClip;}
		public function get previewYoutubeTxt() : TextField { return previewYoutube.getChildByName("txt") as TextField;}
		
	}
}
