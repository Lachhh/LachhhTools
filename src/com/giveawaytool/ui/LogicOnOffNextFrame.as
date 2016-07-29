package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class LogicOnOffNextFrame extends ActorComponent {
		public var isOn:Boolean = false;
		public var visualToToggle:MovieClip;
		public var invisibleOnFirstFrame:Boolean = true;
		public function LogicOnOffNextFrame(visual:MovieClip) {
			super();
			visualToToggle = visual;
		}

		override public function update() : void {
			super.update();
			if(isOn) {
				visualToToggle.nextFrame();
			} else {
				visualToToggle.prevFrame();
			}
			if(invisibleOnFirstFrame) visualToToggle.visible = (visualToToggle.currentFrame > 1);
		}
		
		public function gotoFirstFrame():void {
			visualToToggle.gotoAndStop(1);
		}
		
		public function gotoLastframe():void {
			visualToToggle.gotoAndStop(visualToToggle.totalFrames);
		}
		
		public function isOnLastFrame():Boolean {
			return (visualToToggle.currentFrame >= visualToToggle.totalFrames);
		}

		static public function addToActor(actor: Actor, theVisual:MovieClip): LogicOnOffNextFrame {
			var result: LogicOnOffNextFrame = new LogicOnOffNextFrame (theVisual);
			actor.addComponent(result);
			return result;
		}
	}
}
