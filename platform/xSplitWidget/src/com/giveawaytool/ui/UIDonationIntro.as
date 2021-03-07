package com.giveawaytool.ui {
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.meta.MetaNewDonation;
	import com.giveawaytool.ui.views.ViewDonationWithTop;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UIDonationIntro extends UIBase {
		private var viewDonation:ViewDonationWithTop;
		public var callbackOnClose:Callback;
		

		public function UIDonationIntro(metaDonation : MetaNewDonation) {
			super(AnimationFactory.ID_UI_DONATIONINTRO);
			viewDonation = new ViewDonationWithTop(this, donationMc);
			viewDonation.metaDonation = metaDonation;
			viewDonation.viewDonationNormal.amountMc.visible = false;
			viewDonation.viewDonationTop.amountMc.visible = false;
			
			renderComponent.animView.addCallbackOnFrame(new Callback(pause, this, null), 130);
			renderComponent.animView.registerSound(20, SfxFactory.ID_SFX_MEDAL_POP);
			renderComponent.animView.registerSound(92, SfxFactory.ID_SFX_TRANSITION_WOOSH_01);
			renderComponent.animView.registerSound(97, SfxFactory.ID_SFX_TRANSITION_WOOSH_03);
			renderComponent.animView.registerSound(140, SfxFactory.ID_SFX_TRANSITION_WOOSH_02);
			renderComponent.animView.registerSound(148, SfxFactory.ID_SFX_UI_BUY);
			renderComponent.animView.registerSound(155, SfxFactory.ID_SFX_CANON);
			renderComponent.animView.registerSound(155, SfxFactory.ID_SFX_BIG_EXPLOSION);
			renderComponent.animView.registerSound(175, SfxFactory.ID_SFX_CHALLENGE_BELL);
			
			//renderComponent.animView.registerSound(156, SfxFactory.ID_SFX_WEAPON14_DINO);
			
			renderComponent.animView.addCallbackOnFrame(new Callback(onPlayMetal, this, null), 150);
			
			//renderComponent.animView.registerSound(renderComponent.animView.getNbFrames()-1, SfxFactory.ID_SFX_UI_REWARD_SMALL);
			//renderComponent.animView.registerSound(renderComponent.animView.getNbFrames()-1, SfxFactory.ID_SFX_UI_BONUS_BEEP);
			
			renderComponent.animView.addEndCallback(new Callback(close, this, null));
			JukeBox.fadeToMusic(SfxFactory.ID_MUSIC_INTRO, 60);
			refresh();
		}

		private function onPlayMetal() : void {
			JukeBox.fadeToMusic(SfxFactory.ID_MUSIC_METAL, 1);
		}

		private function pause() : void {
			renderComponent.animView.stop();
			var wait:int = viewDonation.metaDonation.getDonationMsg().length*50;
			CallbackTimerEffect.addWaitCallFctToActor(this, unpause, wait);
		}
		
		private function unpause() : void {
			renderComponent.animView.gotoAndPlay(renderComponent.animView.getCurrentFrame()+1);
		}
		
		
		public function close():void {
			if(callbackOnClose) callbackOnClose.call();
			destroy();
		}

		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
		
		
	}
}
