package com.lachhh.lachhhengine.components {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;

	/**
	 * @author LachhhSSD
	 */
	public class CollisionComponent extends ActorComponent {
		public var callbackOnCollision:Callback;
		public var hasCollidedWith:Actor;
		public function CollisionComponent() {
			super();
		}
		
		public function onHitByTarget(attacker:Actor):void {
			hasCollidedWith = attacker;
			if(callbackOnCollision) callbackOnCollision.call();
		}
		
	}
}
