package com.giveawaytool.effect.ui {
	import com.giveawaytool.effect.EffectGotoEaseOut;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.utils.Easing;

	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class EffectGotoElasticUI extends ActorComponent {
		public var displayObj:DisplayObject;
		public var to:Point = new Point();
		public var from:Point = new Point();
		public var delta:Point = new Point();
		public var prct:Number;
		public var prctMod:Number;
		
		public function EffectGotoElasticUI() {
			super();
			prct = 0;
			prctMod = 0.025;
		}

		
		override public function start() : void {
			super.start();
			from.x = displayObj.x;
			from.y = displayObj.y;
			delta.x = to.x-from.x;
			delta.y = to.y-from.y;
		}

		override public function update() : void {
			super.update();
			
			prct += prctMod;
			displayObj.x = Easing.easeInOutElastic(prct, from.x, delta.x, 1, 250, 0.75);
			displayObj.y = Easing.easeInOutElastic(prct, from.y, delta.y, 1, 0, 0);
				
			if(prct >= 1){
				displayObj.x = to.x;
				displayObj.y = to.y;
				destroyAndRemoveFromActor();
			}
		}
		
			
		static public function addToActor(actor:Actor, x:Number, y:Number, displayObj:DisplayObject):EffectGotoElasticUI {
			var result:EffectGotoElasticUI = new EffectGotoElasticUI();
			result.to.x = x;
			result.to.y = y;
			result.displayObj = displayObj;
			actor.addComponent(result);
			return result;
		}
	}
}
