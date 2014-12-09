package com.giveawaytool.ui.views {
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.events.TwitterErrorEvent;
	import isle.susisu.twitter.events.TwitterRequestEvent;

	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.effect.ui.EffectShakeRotateUI;
	import com.giveawaytool.effect.ui.EffectShakeUI;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaTwitterAccount;
	import com.giveawaytool.ui.UIPopUp;
	import com.lachhh.draw.SwfTexture;
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.AnimationManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewTwitterAccount extends ViewBase {
		public var metaTwitterAccount:MetaTwitterAccount;
		
	
		public function ViewTwitterAccount(pScreen : UIBase) {
			var anim:MovieClip = AnimationManager.createAnimation(AnimationFactory.ID_FX_TWITTERACOUNT);
			super(pScreen, anim);
			pScreen.setNameOfDynamicBtn(removeBtn, "Remove");
			pScreen.setNameOfDynamicBtn(tweetBtn, "Send\nTweet");
			pScreen.setNameOfDynamicBtn(gotoURLBtn, "See on\nTwitter");
			pScreen.registerClick(gotoURLBtn, gotoURL);
		}

		protected function gotoURL() : void {
			Utils.navigateToURLAndRecord(metaTwitterAccount.getURL());
		}
		
		override public function destroy() : void {
			super.destroy();
			if(visual) {
				while(contentMc.numChildren > 0) {
					contentMc.removeChildAt(0);
				}
				screen.removeClickFromVisual(removeBtn);
				screen.removeClickFromVisual(tweetBtn);
				screen.removeClickFromVisual(gotoURLBtn);
				
				Utils.LazyRemoveFromParent(visual);
				AnimationManager.destroy(visual as FlashAnimation);
				visual = null;
			}
		}
		
		public function tweet():void {
			if(tweetBtn.isSelected) return ;
			if(metaTwitterAccount.error) {
				showError();
				return ;
			}
			if(MetaGameProgress.instance.metaShareOnTwitter.hasTooMuchChars()) {
				UIPopUp.createOkOnly("Your tweets has too many characters!", null);
				return ;
			}
			
			screen.getTextFieldOfDynamicBtn(tweetBtn).textColor = 0xFFFFFF;
			screen.setNameOfDynamicBtn(tweetBtn, "Loading...");
			tweetBtn.select();
			CallbackWaitEffect.addWaitCallFctToActor(screen, after1Sec, 3);		
		}
		
		
		private function showError():void {
			var u:UIPopUp = UIPopUp.createYesNo(metaTwitterAccount.error.toString(), new Callback(retry, this, null), null);
			u.setNameOfDynamicBtn(u.btn1, "Retry");
			u.setNameOfDynamicBtn(u.btn3, "Cancel");
		}
		
		private function retry():void {
			metaTwitterAccount.error = null;
			tweet();
		}
		
		private function after1Sec():void {
			ViewWinnerPng.createBitMapData(new Callback(after2Sec, this, null));
		}
		
		private function after2Sec(swfTexture:SwfTexture):void {
			var request : TwitterRequest = metaTwitterAccount.twitter.statuses_updateWithMedia(MetaGameProgress.instance.metaShareOnTwitter.getCompleteTweetMsg(), swfTexture.dataInPngFormat);
			request.addEventListener(TwitterRequestEvent.COMPLETE, onComplete_request);
			request.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onClientError);
		}

		private function onClientError(event : TwitterErrorEvent) : void {
			event.preventDefault();
			metaTwitterAccount.error = event;
			screen.setNameOfDynamicBtn(tweetBtn, "Show Error");
			tweetBtn.deselect();
			screen.getTextFieldOfDynamicBtn(tweetBtn).textColor = 0xFF0000;
			EffectShakeUI.addToActor(screen, tweetBtn, 15, 15);
			EffectBlinking.addToActorWithSpecificMc(screen, tweetBtn, 15, 0xFF0000);
			EffectShakeRotateUI.addToActor(screen, tweetBtn, 15);
		}

		private function onComplete_request(event : TwitterRequestEvent) : void {
			screen.setNameOfDynamicBtn(tweetBtn, "Done!");
		}
		
		override public function refresh() : void {
			super.refresh();
			if(visual == null) return ;
			if(metaTwitterAccount.isLoading) {
				winnersTxt.text = "Loading...";
				gotoURLBtn.visible = false;
				tweetBtn.visible = false;
			} else {
				winnersTxt.text = metaTwitterAccount.accountName;
				gotoURLBtn.visible = true;
				tweetBtn.visible = true;
				tweetBtn.deselect();
				if(metaTwitterAccount.bmp) {
					contentMc.addChild(metaTwitterAccount.bmp);
					metaTwitterAccount.bmp.width = 45;
					metaTwitterAccount.bmp.height = 45;
				}
			}
		}
		
		
		public function get winnersTxt() : TextField { return visual.getChildByName("winnersTxt") as TextField;}
		public function get removeBtn() : ButtonSelect { return visual.getChildByName("removeBtn") as ButtonSelect;}
		public function get tweetBtn() : ButtonSelect { return visual.getChildByName("tweetBtn") as ButtonSelect;}
		public function get gotoURLBtn() : MovieClip { return visual.getChildByName("gotoURLBtn") as MovieClip;}
		
		public function get avatarMc() : MovieClip { return visual.getChildByName("avatarMc") as MovieClip;}
		public function get avatarMcPreview() : MovieClip { return avatarMc.getChildByName("avatarMc") as MovieClip;}
		public function get contentMc() : MovieClip { return avatarMcPreview.getChildByName("contentMc") as MovieClip;}
	}
}
