package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.actor.Actor;

	/**
	 * @author LachhhSSD
	 */
	public class EffectShake extends EffectShakeConstant {
		public var speedFadeX:Number = 0.9;
		public var speedFadeY:Number = 0.9;
		public function EffectShake() {
			super();
		}
		
		
		override public function start() : void {
			super.start();
			
		}
		
		override public function update() : void {
			super.update();
			shakeForceX *= speedFadeX;
			shakeForceY *= speedFadeY;
			if(shakeForceX < 1) shakeForceX = 0;
			if(shakeForceY < 1) shakeForceY = 0;
			
			if(shakeForceX <= 0 && shakeForceY <= 0) {
				actor.removeComponent(this);
			} 
		}
		
		static public function addToActor(actor:Actor, shakeX:int, shakeY:int):EffectShake {
			var result:EffectShake = new EffectShake();
			result.shakeForceX = shakeX ;
			result.shakeForceY = shakeY ; 
			actor.addComponent(result);
			return result;
		}
	}
}
