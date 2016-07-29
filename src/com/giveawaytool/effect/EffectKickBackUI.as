package com.giveawaytool.effect {
	import flash.display.DisplayObject;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class EffectKickBackUI extends ActorComponent {
		public var visual:DisplayObject;
		public var kickbackForceX:int = 0;
		public var kickbackForceY:int = 0;
		public var kickbackAppliedX:int = 0;
		public var kickbackAppliedY:int = 0;
		public var kickbackEase:Point = new Point(0.9, 0.9);

		public function EffectKickBackUI() {
			super();
		}

		override public function start() : void {
			super.start();
			kickbackAppliedX = kickbackForceX;
			kickbackAppliedY = kickbackForceY;
			visual.x += kickbackAppliedX;
			visual.y += kickbackAppliedY;	
		}
		
		override public function update() : void {
			super.update();
			kickbackForceX *= kickbackEase.x;
			kickbackForceY *= kickbackEase.y;
			
			visual.x -= kickbackAppliedX;
			visual.y -= kickbackAppliedY;
			
			kickbackAppliedX = kickbackForceX;
			kickbackAppliedY = kickbackForceY;
			visual.x += kickbackAppliedX;
			visual.y += kickbackAppliedY;	
			
			if(Math.abs(kickbackAppliedX) < 0.1 && Math.abs(kickbackAppliedY) < 0.1) {
				destroyAndRemoveFromActor();
			}
		}

		override public function destroy() : void {
			super.destroy();
			visual.x -= kickbackAppliedX;
			visual.y -= kickbackAppliedY;
		}
		
		static public function addToActor(actor:Actor, visual:DisplayObject, kickBackX:int, kickBackY:int):EffectKickBackUI {
			var result:EffectKickBackUI = new EffectKickBackUI();
			result.visual = visual;
			result.kickbackForceX = kickBackX ;
			result.kickbackForceY = kickBackY ; 
			actor.addComponent(result);
			return result;
		}
	}
}
