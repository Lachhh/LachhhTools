package com.lachhh.lachhhengine.components {
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;

	/**
	 * @author LachhhSSD
	 */
	public class PhysicComponent extends ActorComponent {
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var gravY:Number = 0;
		
		
		public function PhysicComponent() {
			super();
			
		}

		override public function update() : void {
			super.update();
			vy += gravY*GameSpeed.getSpeed();
			actor.px += vx*GameSpeed.getSpeed();
			actor.py += vy*GameSpeed.getSpeed();
		}
		
		static public function addToActor(actor:Actor):PhysicComponent {
			var result:PhysicComponent = new PhysicComponent();
			actor.addComponent(result);
			return result;
		}

	}
}
