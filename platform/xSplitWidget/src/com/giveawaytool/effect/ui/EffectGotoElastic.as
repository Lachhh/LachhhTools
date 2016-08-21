package com.giveawaytool.effect.ui {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.utils.Easing;

	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class EffectGotoElastic extends ActorComponent {
		public var to:Point = new Point();
		public var from:Point = new Point();
		public var delta:Point = new Point();
		public var prct:Number;
		public var prctMod:Number;
		
		public function EffectGotoElastic() {
			super();
			prct = 0;
			prctMod = 0.05;
		}

		
		override public function start() : void {
			super.start();
			from.x = actor.px;
			from.y = actor.py;
			delta.x = to.x-from.x;
			delta.y = to.y-from.y;
		}

		override public function update() : void {
			super.update();
			
			prct += prctMod;
			actor.px = Easing.easeInOutElastic(prct, from.x, delta.x, 1, 0, 0.75);
			actor.py = Easing.easeInOutElastic(prct, from.y, delta.y, 1, 0, 0);
				
			if(prct >= 1){
				actor.px = to.x;
				actor.py = to.y;
				destroyAndRemoveFromActor();
			}
		}
		
			
		static public function addToActor(actor:Actor, x:Number, y:Number):EffectGotoElastic {
			var result:EffectGotoElastic = new EffectGotoElastic();
			result.to.x = x;
			result.to.y = y;
			actor.addComponent(result);
			return result;
		}
	}
}
