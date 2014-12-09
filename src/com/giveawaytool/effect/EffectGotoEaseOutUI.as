package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class EffectGotoEaseOutUI extends ActorComponent {
		public var goto:Point = new Point();
		public var ease:Point = new Point();
		public var display:DisplayObject ;
		public var threshold:int = 3;
		
		public function EffectGotoEaseOutUI() {
			super();
			ease.x = 0.03;
			ease.y = 0.03;
		}

		override public function update() : void {
			super.update();
			var dx:int = (goto.x-display.x);
			var dy:int = (goto.y-display.y);
			
			display.x += dx*ease.x;
			display.y += dy*ease.y;
			if(dx*dx+dy*dy < threshold) {
				display.x = goto.x;
				display.y = goto.y;
				//destroyAndRemoveFromActor();	
			}
		}
		
		
		static public function addToActor(actor:Actor, x:Number, y:Number, displayObject:DisplayObject):EffectGotoEaseOutUI {
			var result:EffectGotoEaseOutUI = new EffectGotoEaseOutUI();
			result.goto.x = x;
			result.goto.y = y;
			result.display = displayObject;
			
			actor.addComponent(result);
			return result;
		}
	}
}
