package com.giveawaytool.ui {
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectKickBack;
	import com.giveawaytool.effect.ui.EffectShakeRotateUI;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * @author LachhhSSD
	 */
	public class UI_SimpleCountdown extends UIBase {
		public var sec : int = 45;

		public function UI_SimpleCountdown() {
			super(AnimationFactory.ID_FX_COUNTDOWNFEEDBACK);
			var t : Timer = new Timer(1000);
			t.addEventListener(TimerEvent.TIMER, onTick);
			t.start();
			registerClick(visual, onClick);
			refresh();
		}

		private function onClick() : void {
			sec -= 60;
			EffectKickBack.addToActor(this, 0, -5);
			refresh();
		}

		override public function update() : void {
			super.update();
			if(visual.currentFrame >= 130) {
				renderComponent.animView.stop();
			}
		}

		private function onTick(event : TimerEvent) : void {
			sec--;
			CallbackWaitEffect.addWaitCallFctToActor(this, onTick2, 3);
			refresh();
		}

		private function onTick2() : void {
			EffectShakeRotateUI.addToActor(this, iconMc, 15);
		}

		override public function refresh() : void {
			super.refresh();
			if(sec > 0) {
				nameTxt.text = Utils.FrameToTime(sec, 1);
			} else {
				nameTxt.text = "Chop chop!";
			}
			
		}

		public function get descMc() : MovieClip { return visual.getChildByName("descMc") as MovieClip;}
		public function get nameTxt() : TextField { return descMc.getChildByName("nameTxt") as TextField;}
		public function get iconMc() : DisplayObject { return visual.getChildByName("iconMc") as DisplayObject;}
		//public function get txt() : TextField {return visual.getChildByName("txt") as TextField;}
	}
}
