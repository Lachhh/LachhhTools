package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.ui.EffectShakeRotateUI;
	import com.giveawaytool.meta.MetaDonationGoal;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationGoal extends ViewBase {
		public var metaGoal : MetaDonationGoal;
		
		public var viewProgressBarLiquid:ViewProgressLiquid;
		public var bonusGiven:Number = 0;
		public var heightCrnt:int = 178;
		public var yStart:int = -150;
		public var value:Number = 0;
		public function ViewDonationGoal(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewProgressBarLiquid = new ViewProgressLiquid(pScreen, progressMc);
			fireMc.gotoAndStop(1);
			if(fireMc2) fireMc2.gotoAndStop(1);
			targetAnimMc.gotoAndStop(1);
		}

		
		override public function refresh() : void {
			super.refresh();
			if(metaGoal == null) return ;
			
			var valueCapped:Number = Math.min(value, metaGoal.targetAmount); 
			targetTxt.text = "$" + metaGoal.targetAmount;
			crntTxt.text = "$" + value.toFixed(2);
			rewardTxt.text = metaGoal.reward;
			viewProgressBarLiquid.height = heightCrnt;
			viewProgressBarLiquid.prct = (valueCapped/metaGoal.targetAmount);
			viewProgressBarLiquid.refresh();
			
			crntMc.y = yStart + (heightCrnt*viewProgressBarLiquid.prct)*-1;
		}
		
		public function flash():void {
			EffectBlinking.addToActorWithSpecificMc(screen, crntMc, 20, 0xFFFFFF);
		}
		
		public function isFull():Boolean {
			return value >= metaGoal.targetAmount;
		}
		
		public function setIsMoving(b:Boolean):void {
			viewProgressBarLiquid.isMoving = b;	
		}
		
		public function startCompleteAnim():void {
			targetAnimMc.play();
			fireMc.gotoAndPlay(1);
			if(fireMc2) fireMc2.gotoAndPlay(1);
			EffectBlinking.addToActorWithSpecificMc(screen, rewardTxt, 120, 0xFFFF00);
			//EffectShakeUI.addToActor(actor, visual, shakeX, shakeY)
			//pressAnimOnAllChildren(visualMc);
			
			EffectFadeOut.addToActorWithSpecificMc(screen, machineMc, 5, 0xFFFFFF);
			EffectShakeRotateUI.addToActor(screen, machineMc, 8);		
			
			JukeBox.playSound(SfxFactory.ID_SFX_FLAMER_START);
			JukeBox.playSound(SfxFactory.ID_SFX_FLAMER_START);
			JukeBox.playSound(SfxFactory.ID_SFX_UPGRADE_SIMPLE);
			//JukeBox.playSound(SfxFactory.ID_SFX_FLAMER_START);
			CallbackWaitEffect.addWaitCallbackToActor(screen, new Callback(JukeBox.playSound, JukeBox, [SfxFactory.ID_SFX_CROWD]), 20);
			CallbackWaitEffect.addWaitCallbackToActor(screen, new Callback(JukeBox.playSound, JukeBox, [SfxFactory.ID_SFX_CROWD]), 20);
		}
		
		public function reset():void {
			fireMc.gotoAndStop(1);
			if(fireMc2) fireMc2.gotoAndStop(1);
			targetAnimMc.gotoAndStop(1);
		}
		
		
		public function setBonus(bonus:Number):void {
			bonusGiven = bonus;
		}
		
		public function addBonus(bonus:Number):void {
			bonusGiven += bonus;
		}
		
		public function get machineMc() : MovieClip { return visual.getChildByName("machineMc") as MovieClip;}
		public function get crntMc() : MovieClip { return machineMc.getChildByName("crntMc") as MovieClip;}
		public function get crntTxt() : TextField { return crntMc.getChildByName("crntTxt") as TextField;}
		
		public function get targetAnimMc() : MovieClip { return machineMc.getChildByName("targetAnimMc") as MovieClip;}
		public function get targetMc() : MovieClip { return targetAnimMc.getChildByName("targetMc") as MovieClip;}
		public function get targetTxt() : TextField { return targetMc.getChildByName("targetTxt") as TextField;}
		
		public function get rewardTxt() : TextField { return machineMc.getChildByName("rewardTxt") as TextField;}
		public function get progressMc() : MovieClip { return machineMc.getChildByName("progressMc") as MovieClip;}
		
		public function get machineBubbleMc() : MovieClip { return machineMc.getChildByName("machineMc") as MovieClip;}
		public function get bubbleMc() : MovieClip { return machineBubbleMc.getChildByName("bubbleMc") as MovieClip;}
		
		public function get fireMc() : MovieClip { return machineMc.getChildByName("fireMc") as MovieClip;}
		public function get fireMc2() : MovieClip { return machineMc.getChildByName("fireMc2") as MovieClip;}
		
	}
}
