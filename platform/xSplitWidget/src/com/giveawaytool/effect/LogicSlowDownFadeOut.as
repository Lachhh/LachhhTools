package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class LogicSlowDownFadeOut extends ActorComponent {
		public var ease:Point = new Point(0.9, 0.9);
		public function LogicSlowDownFadeOut() {
			super();
		}

		override public function update() : void {
			super.update();
			actor.physicComponent.vx *= ease.x;
			actor.physicComponent.vy *= ease.y; 
		}
		
		static public function addToActor(actor: Actor):LogicSlowDownFadeOut {
			var result:LogicSlowDownFadeOut = new LogicSlowDownFadeOut();
			actor.addComponent(result);
			return result;
		}
		
	}
}
