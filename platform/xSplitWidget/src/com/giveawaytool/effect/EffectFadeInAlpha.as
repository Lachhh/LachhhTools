package com.giveawaytool.effect {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class EffectFadeInAlpha extends ActorComponent {
		public var wait:Number = 0;
		public var alpha:Number = 1;
		public var alphaFadeSpeed:Number = 0.05;
		public var callbackOnEnd:Callback;
		public var displayObject:DisplayObject;
		public function EffectFadeInAlpha() {
			super();
		}

		override public function update() : void {
			super.update();
			if(wait > 0) {
				wait -= GameSpeed.getSpeed();
			} else {
				alpha -= alphaFadeSpeed;
				if(alpha <= 0) {
					if(callbackOnEnd) callbackOnEnd.call();
					destroyAndRemoveFromActor();
				} else {
					displayObject.alpha = alpha;
				}
			}
		}
		
		static public function addToActor(actor: Actor):EffectFadeInAlpha {
			var result:EffectFadeInAlpha = new EffectFadeInAlpha();
			if(actor.renderComponent) result.displayObject = actor.renderComponent.animView.anim;
			actor.addComponent(result);
			return result;
		}
		
		static public function addToActorWithDisplayObject(actor: Actor, displayObject:DisplayObject):EffectFadeInAlpha {
			var result:EffectFadeInAlpha = new EffectFadeInAlpha();
			result.displayObject = displayObject;
			actor.addComponent(result);
			return result;
		}

	}
}
