package com.giveawaytool.components {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	/**
	 * @author LachhhSSD
	 */
	public class TweenNumberComponent extends ActorComponent {
		public var value:Number;
		public var goto:Number;
		public var ease:Number = 2;
		public var callbackOnReach:Callback;
		public function TweenNumberComponent() {
			super();
			value = 0;
		}

		override public function update() : void {
			super.update();
			if(value > (goto-ease)) {
				value-=ease;
			} else if(value < (goto+ease)) {
				value+=ease;
			}
			if(hasReachedGoto()) {
				value = goto;
				ease = 0;
				if(callbackOnReach) {
					callbackOnReach.call();
					callbackOnReach = null;
				}
			}
		}
		
		public function hasReachedGoto():Boolean {
			return Math.abs(goto - value) <= ease;
		}
		
		public function prctProgress():Number {
			return (value/goto) ;
		}
		
		static public function addToActor(actor: Actor):TweenNumberComponent {
			var result:TweenNumberComponent = new TweenNumberComponent();
			actor.addComponent(result);
			return result;
		}
	}
}
