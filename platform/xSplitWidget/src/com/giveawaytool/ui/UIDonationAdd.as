package com.giveawaytool.ui {
	import flash.text.TextField;
	import com.giveawaytool.meta.ModelDonationAward;
	import com.giveawaytool.meta.ModelDonationAwardEnum;
	import com.giveawaytool.meta.MetaNewDonation;
	import com.giveawaytool.effect.EffectBlinking;
	import com.lachhh.lachhhengine.components.JukeboxSfxComponent;
	import com.giveawaytool.components.TweenNumberComponent;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.meta.MetaDonation;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.ui.views.ViewDonationGoal;
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
	public class UIDonationAdd extends UIBase {
		public var metaConfig:MetaDonationsConfig;
		public var metaDonation:MetaNewDonation;
		private var viewDonation:ViewDonationWithTop;
		private var viewBigGoal:ViewDonationGoal;
		private var viewRecurGoal : ViewDonationGoal;
		private var viewCharity : ViewCharity;
		public var callbackOnClose : Callback;
		private var tweenNumber : TweenNumberComponent;
		private var goalReachedStep : Number;	
		public var isBigGoalCompleted:Boolean;
		
		private var gazSound:JukeboxSfxComponent;

		public function UIDonationAdd(pMetaDonation : MetaNewDonation, mConfig:MetaDonationsConfig) {
			var animId:int = AnimationFactory.ID_UI_DONATIONTWOGOALS;
			if(mConfig.metaBigGoal.isEnabled() && mConfig.metaRecurrentGoal.isEnabled()) {	
				animId = AnimationFactory.ID_UI_DONATIONTWOGOALS;
			} else if(mConfig.metaBigGoal.isEnabled()) {
				animId = AnimationFactory.ID_UI_DONATIONBIGGOALONLY;
			} else {
				animId = AnimationFactory.ID_UI_DONATIONRECURGOALONLY;
			}
			super(animId);
			
			metaConfig = mConfig;
			metaDonation = pMetaDonation;
			renderComponent.animView.isLooping = false;
			
			viewDonation = new ViewDonationWithTop(this, donationPanel);
			viewDonation.metaDonation = metaDonation;
			
			if(recurGoalMc) {
				viewRecurGoal = new ViewDonationGoal(this, recurGoalMc);
				viewRecurGoal.metaGoal = mConfig.metaRecurrentGoal;
				viewRecurGoal.value = metaConfig.metaRecurrentGoal.crntAmount;
			}
			
			if(bigGoalMc) {
				viewBigGoal = new ViewDonationGoal(this, bigGoalMc);
				viewBigGoal.metaGoal = mConfig.metaBigGoal;
				viewBigGoal.value = metaConfig.metaBigGoal.crntAmount;
				viewBigGoal.yStart = -219.9;
				viewBigGoal.heightCrnt = 276;
			}
			
			viewCharity = new ViewCharity(this, charityTankMc);
			viewCharity.metaCharity = mConfig.metaCharity;
			viewCharity.value = mConfig.metaCharity.crntAmount;
			
			
			tweenNumber = TweenNumberComponent.addToActor(this);
			tweenNumber.ease = metaDonation.amount/120;
			tweenNumber.value = 0;
			tweenNumber.goto = metaDonation.amount;
			tweenNumber.enabled = false;
			
			goalReachedStep = 0;
			isBigGoalCompleted = metaConfig.metaBigGoal.isCompleted();
			refresh();
			
			renderComponent.animView.addCallbackOnFrame(new Callback(stopMusic, this, null), renderComponent.animView.getNbFrames()-120);
			renderComponent.animView.addCallbackOnFrame(new Callback(startCounting, this, null), 86);
			renderComponent.animView.addEndCallback(new Callback(destroy, this, null));
			
			/*renderComponent.animView.registerSound(2, SfxFactory.ID_SFX_UI_DOOR_OPEN);
			renderComponent.animView.registerSound(2, SfxFactory.ID_SFX_UPGRADE_SIMPLE);
			renderComponent.animView.registerSound(2, SfxFactory.ID_SFX_INGAME_DOOR);*/
			renderComponent.animView.registerSound(renderComponent.animView.getNbFrames()-1, SfxFactory.ID_SFX_UI_REWARD_SMALL);
			renderComponent.animView.registerSound(renderComponent.animView.getNbFrames()-1, SfxFactory.ID_SFX_UI_BONUS_BEEP);
			JukeBox.fadeToMusic(SfxFactory.ID_MUSIC_METAL, 1);
		}

		private function stopMusic() : void {
			JukeBox.fadeAllMusicToDestroy(120);
		}
		
		
		private function startCounting():void {
			tweenNumber.enabled = true;
			startGazSound();
		}
		
		private function startGazSound():void {
			gazSound = JukeBox.playSound(SfxFactory.ID_SFX_GAZ);
		}
		
		private function stopGazSound():void {
			if(gazSound == null) return ;
			gazSound.stop();
			gazSound = null;
		}
		
		
		override public function update() : void {
			super.update();
			
			if(!tweenNumber.enabled) return ;
			
			updateRecurGoal();
			updateBigGoal();
			updateTopDonator();
			updateCharity();
			renderComponent.animView.stop();
			
			var hasFinishedCounting:Boolean = tweenNumber.hasReachedGoto();
			if(hasFinishedCounting) {
				tweenNumber.enabled = false;
				JukeBox.playSound(SfxFactory.ID_SFX_TING);
				viewDonation.flashAmount();
				if(viewBigGoal) viewBigGoal.flash();
				if(viewRecurGoal) viewRecurGoal.flash();
				CallbackWaitEffect.addWaitCallFctToActor(this, afterTing, 35);
				stopGazSound();
			}
			
			refresh();
		}
		
		private function afterTing():void {
			renderComponent.animView.stop();
			viewDonation.playNewAwards(new Callback(afterAwards, this, null));
		}
		
		private function afterAwards():void {
			renderComponent.animView.gotoAndPlay(167);
		}
		
		
		private function updateRecurGoal():void {
			if(viewRecurGoal == null) return ;
			if(!tweenNumber.enabled) return ;
			viewRecurGoal.value = (metaConfig.metaRecurrentGoal.crntAmount+tweenNumber.value)-goalReachedStep;
			if(viewRecurGoal.isFull()) {
				viewRecurGoal.startCompleteAnim();
				tweenNumber.enabled = false;
				stopGazSound();
				CallbackWaitEffect.addWaitCallFctToActor(this, resetRecurGoal, 120);
				refresh();
			}
		}
		
		private function updateBigGoal():void {
			if(viewBigGoal == null) return ;
			if(!tweenNumber.enabled) return ;
			viewBigGoal.value = (metaConfig.metaBigGoal.crntAmount+tweenNumber.value);
			if(!isBigGoalCompleted && viewBigGoal.isFull()) {
				viewBigGoal.startCompleteAnim();
				var ui:UIDonationBigGoalReached = new UIDonationBigGoalReached(viewBigGoal.metaGoal.targetAmount);
				ui.callbackOnClose = new Callback(afterBigGoalReached, this, null);
				tweenNumber.enabled = false;
				isBigGoalCompleted = true;
				stopGazSound();
				//CallbackWaitEffect.addWaitCallFctToActor(this, afterBigGoalReached, 120);
				refresh();
			}
		}
		
		private function updateCharity():void {
			if(!tweenNumber.enabled) return ;
			viewCharity.value = (metaConfig.metaCharity.crntAmount+metaConfig.metaCharity.getCharityCut(tweenNumber.value));
			
		}
		
		private function updateTopDonator():void {
			if(!tweenNumber.enabled) return ;
			//var isTopDonatorOfAllTime:Boolean = metaConfig.isHigherThanTopDonatorAllTime(metaDonation.amount);
			/*var amountTotalToCheck:Number = (metaDonation.amountThisDay-metaDonation.amount) + tweenNumber.value;
			var newTopDonator:Boolean = metaConfig.isHigherThanTopDonatorThisDay(amountTotalToCheck) ;
			if(newTopDonator && !viewDonation.isOnTopDonationAnim()) {
				tweenNumber.enabled = false;
				if(metaDonation.isFirstOfTheDay(metaConfig)) {
					viewDonation.showTopDonationAnim(ModelDonationAwardEnum.FIRST_DAY);
				} else {
					viewDonation.showTopDonationAnim(ModelDonationAwardEnum.TOP_DAY);
				}
				stopGazSound();
				CallbackWaitEffect.addWaitCallFctToActor(this, afterTopDonationAnim, 120);
				refresh();
			}*/
		}
		
		private function afterTopDonationAnim() : void { 
			tweenNumber.enabled = true;
			startGazSound();
		}

		private function resetRecurGoal() : void {
			goalReachedStep += metaConfig.metaRecurrentGoal.targetAmount; 
			viewRecurGoal.reset();
			tweenNumber.enabled = true;
			startGazSound();
		}
		
		private function afterBigGoalReached() : void {
			tweenNumber.enabled = true;
			startGazSound();
		}

		override public function refresh() : void {
			super.refresh();
			if(tweenNumber.enabled) {
				renderComponent.animView.gotoAndStop(87+tweenNumber.prctProgress()*80);
			}
			
			if(viewRecurGoal) {
				viewRecurGoal.setIsMoving(tweenNumber.enabled);
				viewRecurGoal.refresh();
			}
			
			if(viewBigGoal) {
				viewBigGoal.setIsMoving(tweenNumber.enabled);
				viewBigGoal.refresh();
			}
			
			viewDonation.amount = tweenNumber.value;
			viewDonation.refresh();
			
			viewCharity.refresh();
		}
		
		override public function destroy() : void {
			super.destroy();
			if(callbackOnClose) callbackOnClose.call();
		}

		public function get recurGoalMc() : MovieClip { return visual.getChildByName("recurGoalMc") as MovieClip;}
		public function get bigGoalMc() : MovieClip { return visual.getChildByName("bigGoalMc") as MovieClip;}
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
		public function get donationPanel() : MovieClip { return donationMc.getChildByName("panel") as MovieClip;}
		
		public function get fuelTankMc() : MovieClip { return visual.getChildByName("fuelTankMc") as MovieClip;}
		public function get charityTankMc() : MovieClip { return fuelTankMc.getChildByName("charityTankMc") as MovieClip;}
		public function get charityTitleTxt() : TextField { return charityTankMc.getChildByName("charityTitleTxt") as TextField;}
		public function get charityAmountTxt() : TextField { return charityTankMc.getChildByName("charityAmountTxt") as TextField;}
		
		
	}
}
