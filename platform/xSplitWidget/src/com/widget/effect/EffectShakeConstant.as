package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.actor.Actor;

	/**
	 * @author LachhhSSD
	 */
	public class EffectShakeConstant extends ActorComponent {
		public var shakeForceX:Number = 0;
		public var shakeForceY:Number = 0;
		public var shakeAppliedX:Number = 0;
		public var shakeAppliedY:Number = 0;
		public function EffectShakeConstant() {
			super();
		}
		
		override public function update() : void {
			super.update();
			actor.px -= shakeAppliedX;
			actor.py -= shakeAppliedY;
			
			shakeAppliedX = Math.random()*shakeForceX-shakeForceX*0.5;
			shakeAppliedY = Math.random()*shakeForceY-shakeForceY*0.5;
			actor.px += shakeAppliedX;
			actor.py += shakeAppliedY;	
			
		}
		
		static public function addToActor(actor:Actor, shakeX:int, shakeY:int):EffectShakeConstant {
			var result:EffectShakeConstant = new EffectShakeConstant();
			result.shakeForceX = shakeX ;
			result.shakeForceY = shakeY ; 
			actor.addComponent(result);
			return result;
		}
	}
}
