package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectShake;
	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.meta.MetaDonation;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Charity extends UIBase {
		public var wait:int = 0;
		public function UI_Charity() {
			super(AnimationFactory.ID_UI_MOUSTACHECHARITY);
			animMc.gotoAndStop(1);	
			pickRandomTime();
		}
		
		override public function update() : void {
			super.update();
			wait--;
			if(wait < -5000) {
				tryToSpook();
			}
		}
		
		private function tryToSpook():void {
			if(UIBase.manager.hasInstanceOf(UIDonationAdd)) return ;
			if(UIBase.manager.hasInstanceOf(UIDonationBigGoalReached)) return ;
			if(UIBase.manager.hasInstanceOf(UIDonationIntro)) return ;
			if(UIBase.manager.hasInstanceOf(UIDonationIntroSmall)) return ;
			if(UIBase.manager.hasInstanceOf(UI_NewHostAnim)) return ;
			if(UIBase.manager.hasInstanceOf(UI_NewFollowerAnim)) return ;
			if(UIBase.manager.hasInstanceOf(UI_NewSubAnim)) return ;
			if(animMc.currentFrame > 10 &&animMc.currentFrame < 70) return;
			playSpook();
			pickRandomTime();
		}
		
		public function removeWaitFromDonation(meta:MetaDonation):void {
			wait -= meta.amount*3600;
			
			if(wait <= 0) {
				//animMc.gotoAndPlay(1);
				//pickRandomTime();
			} else {
				//animMc.gotoAndPlay(1);
				//CallbackWaitEffect.addWaitCallbackToActor(this, new Callback(backTo1, this, null), 70);
			}
			
			EffectBlinking.addToActor(this, 20, 0xFFFFFF);
			EffectShake.addToActor(this, 60, 0);
		}
		
		public function playSpook():void {
			animMc.gotoAndPlay(1);
			var e:CallbackWaitEffect = getComponent(CallbackWaitEffect) as CallbackWaitEffect;
			if(e) removeComponent(e);
		}

		private function backTo1() : void {
			animMc.gotoAndStop(1);
		}

		function pickRandomTime() : void {
			wait = (60*60)*(10+Math.random()*15);
		}
		
		public function get animMc() : MovieClip { return visual.getChildByName("animMc") as MovieClip;}
	}
}
