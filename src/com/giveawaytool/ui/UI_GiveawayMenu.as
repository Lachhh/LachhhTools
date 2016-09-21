package com.giveawaytool.ui {
	import com.animation.exported.UI_MENU;
	import air.update.utils.VersionUtils;

	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.effect.EffectFlashColorFadeIn;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewCountdownEdit;
	import com.giveawaytool.ui.views.ViewExportPNG;
	import com.giveawaytool.ui.views.ViewShareOnTwitter;
	import com.lachhh.draw.SwfExporterToFileOnDisk;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.AnimationManager;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.text.TextField;
	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class UI_GiveawayMenu extends UIBase {
		public var viewExportPNG : ViewExportPNG;
		public var viewCountdown : ViewCountdownEdit;
		public var viewShareOnTwitter : ViewShareOnTwitter;
		
		public var viewGiveaway : ViewGiveaway;
		public var isStep123:Boolean = true;
		
		public function UI_GiveawayMenu() {
			
			super(AnimationFactory.ID_UI_GIVEAWAY);
			viewGiveaway = new ViewGiveaway(this, giveawayPanel);
			
			viewExportPNG = new ViewExportPNG(this, exportPNGMc);
			viewCountdown = new ViewCountdownEdit(this, countdownMc);
			viewShareOnTwitter = new ViewShareOnTwitter(this, shareMc);
			
			registerClick(viewGiveaway.startAnimBtn, onStart);
			
			registerClick(shareBtn, onShare);
			registerClick(backBtn, onBack);
			
			refresh();
			SwfExporterToFileOnDisk.errorCallback = new Callback(onError, this, null);
			
			UI_Overlay.show();
			AnimationManager.factoryCache.ClearCache();
			renderComponent.animView.gotoAndStop(1);
			//flashNewWinner();
		}

		private function onShare() : void {
			isStep123 = false;
		}

		private function onBack() : void {
			isStep123 = true;
		}

		private function onError() : void {
			UI_PopUp.createOkOnly("Oops, something went wrong :( !", null);
		}
		
		private function onStart() : void {
			doBtnPressAnim(viewGiveaway.startAnimBtn);
			if(viewGiveaway.viewNameList.getNames().length <= 0) {
				UI_PopUp.createOkOnly("There's nobody on the list. Add some people in there :)!", null);
				return ;
			}

			enableAllClicks(false);
			UI_Overlay.hide();
			EffectFlashColorFadeIn.create(0x000000, 15, new Callback(onClose, this, null));
		}
		
		private function onClose():void {
			destroy();
			
			if(MetaGameProgress.instance.metaGiveawayConfig.metaAnimation.useDefault) {
				new UI_LoterySpin(viewGiveaway.viewNameList.getNames());
			} else {
				var d:Dictionary = MetaGameProgress.instance.metaGiveawayConfig.encode();
				d["participants"] = MetaGameProgress.instance.metaGiveawayConfig.participants;
				new UI_PlayCustomAnimation(MetaGameProgress.instance.metaGiveawayConfig.metaAnimation, d);
			}
		}
		
		override public function update() : void {
			super.update();
			if(isStep123) {
				visual.prevFrame(); 
			} else {
				visual.nextFrame();
			}
		}
		
		public function flashNewWinner():void {
			EffectBlinking.addToActorWithSpecificMc(this, viewExportPNG.winnersTxt, 60, 0x465A66);
			EffectBlinking.addToActorWithSpecificMc(this, viewCountdown.targetTxt, 60, 0x465A66);
		}
		
		public function flashTweet():void {
			EffectBlinking.addToActorWithSpecificMc(this, viewShareOnTwitter.tweetTxt, 60, 0x465A66);
		}

		public function isFullScreen():Boolean {
			return (visual.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE);
		}
	
		
		public function get listOfNameMc() : MovieClip { return giveawayPanel.getChildByName("listOfNameMc") as MovieClip;}
		public function get exportPNGMc() : MovieClip { return visual.getChildByName("exportPNGMc") as MovieClip;}
		public function get countdownMc() : MovieClip { return visual.getChildByName("countdownMc") as MovieClip;}
		public function get shareMc() : MovieClip { return visual.getChildByName("shareMc") as MovieClip;}
		public function get giveawayPanel() : MovieClip { return visual.getChildByName("giveawayPanel") as MovieClip;}
		public function get settingMc() : MovieClip { return giveawayPanel.getChildByName("settingMc") as MovieClip;}
		
		
		
		public function get backBtn() : MovieClip { return visual.getChildByName("backBtn") as MovieClip;}
		public function get shareBtn() : MovieClip { return visual.getChildByName("shareBtn") as MovieClip;}
		
		
	}
}
