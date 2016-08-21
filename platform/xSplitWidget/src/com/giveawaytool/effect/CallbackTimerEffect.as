package com.giveawaytool.effect {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class CallbackTimerEffect extends ActorComponent {
		public var callback:Callback;
		public var wait:Number;
		public var timeAtStart:Number;
		public var isLoop:Boolean;
		public function CallbackTimerEffect() {
			super();
			isLoop = false;
			timeAtStart = GameSpeed.getTime();
		}
		
		
		override public function update() : void {
			super.update();
			var delta:Number = (GameSpeed.getTime() - timeAtStart);

			if(delta >= wait) {
				callback.call();
				if(!isLoop) {
					destroyAndRemoveFromActor();
				} else {
					timeAtStart = GameSpeed.getTime();	
				}
			}
		}
				
		static public function addWaitCallbackToActor(actor:Actor, callback:Callback, wait:Number):CallbackTimerEffect {
			var result:CallbackTimerEffect = new CallbackTimerEffect();
			result.callback = callback;
			result.wait = wait;
			
			actor.addComponent(result);
			return result;	
		}
		
		static public function addWaitCallFctToActor(actor:Actor, fct:Function, wait:Number):CallbackTimerEffect {
			return addWaitCallbackToActor(actor, new Callback(fct, null, null), wait);	
		}
	}
}
