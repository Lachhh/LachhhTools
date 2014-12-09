package com.giveawaytool.ui {
	import flash.utils.Dictionary;
	import air.update.utils.VersionUtils;

	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.effect.EffectFlashColorFadeIn;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewCountdownEdit;
	import com.giveawaytool.ui.views.ViewExportPNG;
	import com.giveawaytool.ui.views.ViewNameListWithPages;
	import com.giveawaytool.ui.views.ViewShareOnTwitter;
	import com.lachhh.draw.SwfExporterToFileOnDisk;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.AnimationManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.sampler.getMasterString;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_MainMenu extends UIBase {
		public var viewNameList:ViewNameListWithPages ;
		public var viewExportPNG:ViewExportPNG;
		public var viewCountdown : ViewCountdownEdit;
		public var viewShareOnTwitter : ViewShareOnTwitter;
		public var isStep123:Boolean = true;
		private var DEBUG_NAMES:String = "MODERATORSLachhhandfriendsVIEWERSSetmeright Caliburone Tuldain Alphaqraw Shadeslaughter Sharky111111 Reversalyoutube Rafaelg10 Nullcore Krisss_gonko Em_idem Nxbxd Stending Brookzerker Tselmek Playkampfschaf Chrisjeffgames Jokebr0 Fmk0 Vinshady Metaldemon68 Mrmgod Buszok Riddsann Worldsender Qiaolimonmon Garvon Darknesssparda Reddestroyer_smd";
		public function UI_MainMenu() {
			
			super(AnimationFactory.ID_UI_MAINMENU);
			viewNameList = new ViewNameListWithPages(this, listOfNameMc);
			viewNameList.setNames(MetaGameProgress.instance.participants);
			viewExportPNG = new ViewExportPNG(this, exportPNGMc);
			viewCountdown = new ViewCountdownEdit(this, countdownMc);
			viewShareOnTwitter = new ViewShareOnTwitter(this, shareMc);
			
			registerClick(viewNameList.startAnimBtn, onStart);
			registerClick(creditsBtn, onCredits);
			registerClick(tutorialBtn, onTutorial);
			registerClick(fullscreenBtn, onFullScreen);
			registerClick(musicBtn, onMusic);
			registerClick(lachhhBtn, onLachhh);
			registerClick(shareBtn, onShare);
			registerClick(backBtn, onBack);
			registerClick(githubBtn, onGitHub);
			
			
			refresh();
			SwfExporterToFileOnDisk.errorCallback = new Callback(onError, this, null);
			
			UI_Overlay.show();
			AnimationManager.factoryCache.ClearCache();
			renderComponent.animView.gotoAndStop(1);
			//flashNewWinner();
		}

		private function onGitHub() : void {
			Utils.navigateToURLAndRecord("https://github.com/Lachhh/LachhhGiveawayTool");
		}

		private function onShare() : void {
			isStep123 = false;
		}

		private function onBack() : void {
			isStep123 = true;
		}

		private function onLachhh() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);
		}
		
		private function onMusic() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_YOUTUBE_FAMILYJULES_7X);
		}

		private function onFullScreen() : void {
			MetaGameProgress.instance.metaToolConfig.nextScreenSize();
			
			refresh();
		}

		private function onTutorial() : void {
			/*destroy();
			new UIMonsterCountDown("Sharky111111", 5);
			UI_Overlay.hide();*/
		}

		private function onSaveComplete() : void {
			UIPopUp.createOkOnly("Image saved with success!", null);
		}

		private function onError() : void {
			UIPopUp.createOkOnly("Oops, something went wrong :( !", null);
		}
		
		private function onCredits() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);

		}

		private function onStart() : void {
			doBtnPressAnim(viewNameList.startAnimBtn);
			if(viewNameList.getNames().length <= 0) {
				UIPopUp.createOkOnly("There's nobody on the list. Add some people in there :)!", null);
				return ;
			}

			enableAllClicks(false);
			UI_Overlay.hide();
			EffectFlashColorFadeIn.create(0x000000, 15, new Callback(onClose, this, null));
		}
		
		private function onClose():void {
			destroy();
			if(MetaGameProgress.instance.metaGiveawayConfig.metaAnimation.useDefault) {
				new UI_LoterySpin(viewNameList.getNames());
			} else {
				var d:Dictionary = MetaGameProgress.instance.metaGiveawayConfig.encode();
				d["participants"] = MetaGameProgress.instance.participants;
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
		
		override public function refresh() : void {
			super.refresh();
			setNameOfDynamicBtn(tutorialBtn, "Tutorial");
			setNameOfDynamicBtn(musicBtn, "Music From\nFamilyJules7x");
			setNameOfDynamicBtn(lachhhBtn, "Lachhh's\nTwitch");
			setNameOfDynamicBtn(githubBtn, "Open Source\nOn Github");	
			
			//trace(visual.stage.nativeWindow.width);
    		//trace(visual.stage.nativeWindow.height);
			if(!MetaGameProgress.instance.metaToolConfig.isFullscreen()) {
				var scale:Number = MetaGameProgress.instance.metaToolConfig.scaleOfWindow();
				var w:int = 1296;
				var h:int = 758;
				setNameOfDynamicBtn(fullscreenBtn, "Window " + (scale*100) + "%");
				visual.stage.displayState = StageDisplayState.NORMAL;
				visual.stage.nativeWindow.width = Math.floor(w*scale);
    			visual.stage.nativeWindow.height = Math.floor(h*scale);
				
			} else {
				visual.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				setNameOfDynamicBtn(fullscreenBtn, "FullScreen");
			}
			
			versionTxt.text = "Version " + VersionUtils.getApplicationVersion();
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
	
		
		public function get listOfNameMc() : MovieClip { return visual.getChildByName("listOfNameMc") as MovieClip;}
		public function get exportPNGMc() : MovieClip { return visual.getChildByName("exportPNGMc") as MovieClip;}
		public function get countdownMc() : MovieClip { return visual.getChildByName("countdownMc") as MovieClip;}
		public function get shareMc() : MovieClip { return visual.getChildByName("shareMc") as MovieClip;}
		
		public function get creditsBtn() : MovieClip { return visual.getChildByName("creditsBtn") as MovieClip;}
		public function get fullscreenBtn() : MovieClip { return visual.getChildByName("fullscreenBtn") as MovieClip;}
		public function get tutorialBtn() : MovieClip { return visual.getChildByName("tutorialBtn") as MovieClip;}
		public function get musicBtn() : MovieClip { return visual.getChildByName("musicBtn") as MovieClip;}
		public function get lachhhBtn() : MovieClip { return visual.getChildByName("lachhhBtn") as MovieClip;}
		
		public function get backBtn() : MovieClip { return visual.getChildByName("backBtn") as MovieClip;}
		public function get shareBtn() : MovieClip { return visual.getChildByName("shareBtn") as MovieClip;}
		public function get githubBtn() : MovieClip { return visual.getChildByName("githubBtn") as MovieClip;}
		
		
		
		public function get versionTxt() : TextField { return visual.getChildByName("versionTxt") as TextField;}
	}
}
