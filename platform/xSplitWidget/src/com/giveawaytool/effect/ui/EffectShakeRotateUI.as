package com.giveawaytool.effect.ui {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class EffectShakeRotateUI extends ActorComponent {
		public var rotateForce:Number = 0;
		public var rotateApplied:int = 0;
		public var speedFadeRot:Number = 0.9;
		public var visual:DisplayObject;
		
		public function EffectShakeRotateUI() {
			super();
		}
		
		override public function update() : void {
			super.update();
			visual.rotation -= rotateApplied;
			rotateApplied = Math.floor(Math.random()*rotateForce-rotateForce*0.5);
			visual.rotation += rotateApplied;
			
			rotateForce *= speedFadeRot;
						
			if(rotateForce < 1) {
				destroyAndRemoveFromActor();
			} 
		}
		
		override public function destroy() : void {
			super.destroy();
			visual.rotation -= rotateApplied;
			rotateApplied = 0;
		}
		
		static public function addToActor(actor:Actor, visual:DisplayObject, rotationForce:int):EffectShakeRotateUI {
			var result:EffectShakeRotateUI = new EffectShakeRotateUI();
			result.rotateForce = rotationForce ;
			result.visual = visual;
			actor.addComponent(result);
			return result;
		}
	}
}
