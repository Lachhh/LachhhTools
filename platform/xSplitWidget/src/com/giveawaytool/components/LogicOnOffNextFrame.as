package com.giveawaytool.components {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class LogicOnOffNextFrame extends ActorComponent {
		public var isOn:Boolean = false;
		public var visualToToggle:MovieClip;
		public var callbackOnEnd:Callback;
		public function LogicOnOffNextFrame() {
			super();
		}

		override public function update() : void {
			super.update();
			if(isOn) {
				visualToToggle.nextFrame();
				visualToToggle.nextFrame();
				if(visualToToggle.currentFrame >= visualToToggle.totalFrames) {
					if(callbackOnEnd) {
						var pTemp:Callback = callbackOnEnd;
						callbackOnEnd = null; 
						pTemp.call();
					}
				}
			} else {
				visualToToggle.prevFrame();
			}
		}
		
		public function gotoFirstFrame():void {
			visualToToggle.gotoAndStop(1);
		}
		
		public function gotoLastframe():void {
			visualToToggle.gotoAndStop(visualToToggle.totalFrames);
		}

		static public function addToActor(actor: Actor, theVisual:MovieClip): LogicOnOffNextFrame {
			var result: LogicOnOffNextFrame = new LogicOnOffNextFrame ();
			result.visualToToggle = theVisual;
			actor.addComponent(result);
			return result;
		}
	}
}
