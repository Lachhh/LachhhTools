package com.giveawaytool.ui {
	import com.giveawaytool.meta.ModelDonationAwardEnum;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaNewDonation;
	import com.giveawaytool.ui.views.ViewDonation;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.meta.MetaDonation;
	import com.giveawaytool.ui.views.ViewDonationWithTop;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UIDonationIntroSmall extends UIBase {
		private var viewDonation:ViewDonationWithTop;
		public var callbackOnClose:Callback;
		public var metaDonation:MetaNewDonation;
		public var metaDonationConfig:MetaDonationsConfig;
		
		

		public function UIDonationIntroSmall(pMetaDonation : MetaNewDonation, pMetaDonationcConfig:MetaDonationsConfig) {
			super(AnimationFactory.ID_UI_DONATIONINTROSMALL);
			metaDonation = pMetaDonation;
			metaDonationConfig = pMetaDonationcConfig;
			
			viewDonation = new ViewDonationWithTop(this, donationMc);
			viewDonation.metaDonation = metaDonation;
			viewDonation.amount = metaDonation.amount;
			
			
			renderComponent.animView.addCallbackOnFrame(new Callback(pause, this, null), 130);
			
			renderComponent.animView.addEndCallback(new Callback(close, this, null));
			renderComponent.animView.registerSound(20, SfxFactory.ID_SFX_MEDAL_POP);
			renderComponent.animView.registerSound(92, SfxFactory.ID_SFX_TRANSITION_WOOSH_01);
			renderComponent.animView.registerSound(97, SfxFactory.ID_SFX_TRANSITION_WOOSH_03);
			renderComponent.animView.registerSound(170, SfxFactory.ID_SFX_TRANSITION_WOOSH_02);
			renderComponent.animView.registerSound(182, SfxFactory.ID_SFX_UI_BUY);
			
			renderComponent.animView.registerSound(renderComponent.animView.getNbFrames()-1, SfxFactory.ID_SFX_UI_REWARD_SMALL);
			renderComponent.animView.registerSound(renderComponent.animView.getNbFrames()-1, SfxFactory.ID_SFX_UI_BONUS_BEEP);
			
			//renderComponent.animView.registerSound(renderComponent.animView.getNbFrames()-1, SfxFactory.ID_SFX_UI_DOOR_OPEN);
			//renderComponent.animView.registerSound(renderComponent.animView.getNbFrames()-1, SfxFactory.ID_SFX_UPGRADE_SIMPLE);
			
			refresh();
		}

		private function pause() : void {
			renderComponent.animView.stop();
			var wait:int = viewDonation.metaDonation.getDonationMsg().length*50;
			CallbackTimerEffect.addWaitCallFctToActor(this, unpause, wait);
		}
		
		public function close():void {
			if(callbackOnClose) callbackOnClose.call();
			destroy();
		}
		
		private function unpause() : void {
			
		/*	if(metaDonationConfig.isHigherThanTopDonatorThisDay(metaDonation.amountThisDay)) {
				if(metaDonation.isFirstOfTheDay(metaDonationConfig)) {
					viewDonation.showTopDonationAnim(ModelDonationAwardEnum.FIRST_DAY);
				} else {
					viewDonation.showTopDonationAnim(ModelDonationAwardEnum.TOP_DAY);
				}
				*/
				//CallbackWaitEffect.addWaitCallFctToActor(this, unpause, 120);
				
			/*} else {
				
			}*/
			viewDonation.playNewAwards(new Callback(afterAwards, this, null));
		}
		
		private function afterAwards():void {
			renderComponent.animView.gotoAndPlay(renderComponent.animView.getCurrentFrame()+1);
		}

		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
		
		
	}
}
