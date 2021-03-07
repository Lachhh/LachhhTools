package com.lachhh.lachhhengine.components {
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	/**
	 * @author LachhhSSD
	 */
	public class PhysicComponent extends ActorComponent {
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var gravY : Number = 0;
		private var timeLastFrame : Number = 0;
		
		
		public function PhysicComponent() {
			super();
			
		}

		override public function update() : void {
			super.update();
			var mod:Number = 1;
			if(timeLastFrame != 0) {
				var dx:Number = GameSpeed.getTime()-timeLastFrame ;
				mod = dx/(16.6666);
			}
			
			vy += gravY*mod;
			actor.px += vx*mod;
			actor.py += vy*mod;
			timeLastFrame = GameSpeed.getTime();
		}
		
		static public function addToActor(actor:Actor):PhysicComponent {
			var result:PhysicComponent = new PhysicComponent();
			actor.addComponent(result);
			return result;
		}

	}
}
