package com.giveawaytool.effect {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class LogicAlphaOnOff extends ActorComponent {
		public var visual:MovieClip;
		public var isOn:Boolean = true;
		public var easeSpeed:Number = 0.2;
		public var callbackOnReach:Callback;
		public var autoSetVisible:Boolean = true;
		public function LogicAlphaOnOff(pVisual:MovieClip) {
			super();
			visual = pVisual;
		}

		override public function start() : void {
			super.start();
			if(!isOn) visual.alpha = 0;
		}

		override public function update() : void {
			super.update();
			if(isOn) {
				visual.alpha += easeSpeed;
				if(visual.alpha > 1) {
					if(callbackOnReach) callbackOnReach.call();
					callbackOnReach = null;
					visual.alpha = 1;
				}
			} else {
				visual.alpha -= easeSpeed;
				if(visual.alpha < 0) {
					if(callbackOnReach) callbackOnReach.call();
					callbackOnReach = null;
					visual.alpha = 0;
				}
			}
			if(autoSetVisible) visual.visible = (visual.alpha > 0);
		}

	}
}
