package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class EffectKickBack extends ActorComponent {
		public var kickbackForceX:Number = 0;
		public var kickbackForceY:Number = 0;
		public var kickbackAppliedX:Number = 0;
		public var kickbackAppliedY:Number = 0;
		public var ease:Number = 0.9;
		public function EffectKickBack() {
			super();
		}

		override public function start() : void {
			super.start();
			kickbackAppliedX = kickbackForceX;
			kickbackAppliedY = kickbackForceY;
			actor.px += kickbackAppliedX;
			actor.py += kickbackAppliedY;	
		}
		
		override public function update() : void {
			super.update();
			kickbackForceX *= ease;
			kickbackForceY *= ease;
			
			actor.px -= kickbackAppliedX;
			actor.py -= kickbackAppliedY;
			
			kickbackAppliedX = kickbackForceX;
			kickbackAppliedY = kickbackForceY;
			actor.px += kickbackAppliedX;
			actor.py += kickbackAppliedY;	
			
			if(Math.abs(kickbackAppliedX) < 0.1 && Math.abs(kickbackAppliedY) < 0.1) {
				destroyAndRemoveFromActor();
			}
		}

		override public function destroy() : void {
			super.destroy();
			actor.px -= kickbackAppliedX;
			actor.py -= kickbackAppliedY;
		}
		
		static public function addToActor(actor:Actor, kickBackX:int, kickBackY:int):EffectKickBack {
			var result:EffectKickBack = new EffectKickBack();
			result.kickbackForceX = kickBackX ;
			result.kickbackForceY = kickBackY ; 
			actor.addComponent(result);
			return result;
		}
	}
}
