package com.giveawaytool.effect {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	/**
	 * @author LachhhSSD
	 */
	public class CallbackWaitEffect extends ActorComponent {
		public var callback:Callback;
		public var wait:Number;
		public var relatedToGameSpeed:Boolean = true;
		
		public function CallbackWaitEffect() {
			super();
		}

		override public function update() : void {
			super.update();
			wait -= (relatedToGameSpeed ? GameSpeed.getSpeed() : 1);
			if(wait <= 0) {
				if(callback) callback.call();
				actor.removeComponent(this);
			}
		}
		
		static public function addWaitCallbackToActor(actor:Actor, callback:Callback, wait:Number):CallbackWaitEffect {
			var result:CallbackWaitEffect = new CallbackWaitEffect();
			result.callback = callback;
			result.wait = wait;
			actor.addComponent(result);
			return result;	
		}
		
		static public function addWaitCallFctToActor(actor:Actor, fct:Function, wait:Number):CallbackWaitEffect {
			return addWaitCallbackToActor(actor, new Callback(fct, null, null), wait);	
		}

	}
}
