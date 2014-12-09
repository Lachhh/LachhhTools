package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicFadeInAlphaToDestroy extends ActorComponent {
		public var wait:Number = 60;
		public var alpha:Number = 1;
		public var alphaFadeSpeed:Number = 0.05;
		public function LogicFadeInAlphaToDestroy() {
			super();
		}

		override public function update() : void {
			super.update();
			if(wait > 0) {
				wait -= GameSpeed.getSpeed();
			} else {
				alpha -= alphaFadeSpeed;
				if(alpha <= 0) {
					actor.destroy();
				} else {
					actor.renderComponent.animView.anim.alpha = alpha;
				}
			}
		}
		
		static public function addToActor(actor: Actor):LogicFadeInAlphaToDestroy {
			var result:LogicFadeInAlphaToDestroy = new LogicFadeInAlphaToDestroy();
			actor.addComponent(result);
			return result;
		}

	}
}
