package com.giveawaytool.effect.ui {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class EffectShakeConstantUI extends ActorComponent {
		public var shakeForceX:Number = 0;
		public var shakeForceY:Number = 0;
		public var shakeAppliedX:int = 0;
		public var shakeAppliedY:int = 0;
		public var visual:DisplayObject;
		
		public function EffectShakeConstantUI() {
			super();
		}
		
		override public function update() : void {
			super.update();
			visual.x -= shakeAppliedX;
			visual.y -= shakeAppliedY;
			
			shakeAppliedX = Math.floor(Math.random()*shakeForceX-shakeForceX*0.5);
			shakeAppliedY = Math.floor(Math.random()*shakeForceY-shakeForceY*0.5);
			visual.x += shakeAppliedX;
			visual.y += shakeAppliedY;	
		}
		
		override public function destroy() : void {
			super.destroy();
			visual.x -= shakeAppliedX;
			visual.y -= shakeAppliedY;
			shakeAppliedX = 0;
			shakeAppliedY = 0;
		}
		
		static public function addToActor(actor:Actor, visual:DisplayObject, shakeX:int, shakeY:int):EffectShakeConstantUI {
			var result:EffectShakeConstantUI = new EffectShakeConstantUI();
			result.shakeForceX = shakeX ;
			result.shakeForceY = shakeY ; 
			result.visual = visual;
			actor.addComponent(result);
			return result;
		}
	}
}
