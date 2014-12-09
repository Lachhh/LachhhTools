package com.giveawaytool.physics {
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.actor.Actor;

	/**
	 * @author LachhhSSD
	 */
	public class PhysicReboundOnY extends PhysicComponent {
		static public var GROUND_Y:int  = 380;
		public var isStuckOnGround:Boolean = false;
		public var hasJustRebound:Boolean = false;
		public var reboundForceY:Number = 0.75;
		public var reboundForceX:Number = 1;
		public var vyThresholdToStop:Number = 3;
		public var myGroundY:int; 
		public function PhysicReboundOnY() {
			super();
			isStuckOnGround = false;
			myGroundY = GROUND_Y;
		}

		override public function update() : void {
			super.update();
			isStuckOnGround = false;
			hasJustRebound = false;
			if(actor.py >= myGroundY) {
				var diffFromGround:int = (actor.py - myGroundY);  
				actor.py = myGroundY-diffFromGround;
				vx *= reboundForceX;
				vy *= -reboundForceY;
				hasJustRebound = true;
				if(vy > -vyThresholdToStop) {
					isStuckOnGround = true;
					vy = 0;
					actor.py = myGroundY;
				}
			}
		}
		
		static public function addToActor(actor:Actor):PhysicReboundOnY {
			var result:PhysicReboundOnY = new PhysicReboundOnY();
			actor.addComponent(result);
			return result;
		}

	}
}
