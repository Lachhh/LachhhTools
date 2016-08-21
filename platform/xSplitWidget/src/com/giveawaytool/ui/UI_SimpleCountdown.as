package com.giveawaytool.ui {
	import com.giveawaytool.effect.EffectKickBack;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * @author LachhhSSD
	 */
	public class UI_SimpleCountdown extends UIBase {
		public var sec : int = 60*10;

		public function UI_SimpleCountdown() {
			super(AnimationFactory.ID_FX_COUNTDOWN_SIMPLE);
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

		private function onTick(event : TimerEvent) : void {
			sec--;
			EffectKickBack.addToActor(this, 0, -5);
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			if(sec > 0) {
				txt.text = Utils.FrameToTime(sec, 1);
			} else {
				txt.text = "Chop chop Lachhh!";
			}
			
		}

		public function get txt() : TextField {return visual.getChildByName("txt") as TextField;}
	}
}
