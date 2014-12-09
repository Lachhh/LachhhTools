package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class EffectGotoEaseOut extends ActorComponent {
		public var goto:Point = new Point();
		public var ease:Point = new Point();
		public var duration:Number = -1;
		
		public function EffectGotoEaseOut() {
			super();
			ease.x = 0.03;
			ease.y = 0.03;
		}

		override public function update() : void {
			super.update();
			actor.px += (goto.x-actor.px)*ease.x;
			actor.py += (goto.y-actor.py)*ease.y;
			if(duration > 0){
				duration -= GameSpeed.getSpeed();
				if(duration <= 0) {
					destroyAndRemoveFromActor();
				}
			}
		}
		
		
		static public function addToActor(actor:Actor, x:Number, y:Number):EffectGotoEaseOut {
			var result:EffectGotoEaseOut = new EffectGotoEaseOut();
			result.goto.x = x;
			result.goto.y = y;
			actor.addComponent(result);
			return result;
		}


	}
}
