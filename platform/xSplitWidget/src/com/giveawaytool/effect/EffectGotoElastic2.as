package com.giveawaytool.effect {
	import flash.geom.Point;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class EffectGotoElastic2 extends ActorComponent {
		public var goto:Point = new Point();
		public var speed : Point = new Point();
		public var speedModAfterRevolution : Point = new Point();
		private var direction : Point = new Point();
		private var numRevolution:Point = new Point();
		private var numRevolutionMax:Point = new Point();
		private var skipFirstRevolutionX:Boolean = false;
		private var skipFirstRevolutionY:Boolean = false;
		

		public function EffectGotoElastic2() {
			speed.x = 5;
			speed.y = 0;
			speedModAfterRevolution.x = 1.25;
			speedModAfterRevolution.y = 0;
			direction.x = 0;
			direction.y = 0;
			numRevolutionMax.x = 3;
			numRevolutionMax.y = -1;
		}

		override public function start() : void {
			super.start();
			var isLeftOfTarget:Boolean = (actor.px < goto.x);
			var isGoingLeft:Boolean = (actor.physicComponent.vx < 0);
			
			skipFirstRevolutionX = (isLeftOfTarget && !isGoingLeft) || (!isLeftOfTarget && isGoingLeft);
			
			
			
		}
		
		override public function update() : void {
			super.update();
			if(actor.px > goto.x) {
				actor.physicComponent.vx -= speed.x;
			}
			
			if(actor.px < goto.x) {
				actor.physicComponent.vx += speed.x;
			}
			
			if(actor.py > goto.y) {
				actor.physicComponent.vy -= speed.y;
			}
			
			if(actor.py < goto.y) {
				actor.physicComponent.vy += speed.y;	
			}
			
			//actor.physicComponent.vx *= 0.9;
			//speed.x *= 0.9;
			
			checkDirectionX();
		}
		
		private function checkDirectionX():void {
			var newDirectionX:int = (actor.px > goto.x ? -1 : 1);
			var newDirectionY:int = (actor.py > goto.y ? -1 : 1);
			
			if(direction.x == 0) {
				direction.x = (actor.physicComponent.vx > 0 ? 1 : -1);
			} else {
				if(direction.x != newDirectionX) {
					
					direction.x = newDirectionX;
					numRevolution.x += 1;
					if(!skipFirstRevolutionX || numRevolution.x > 1) {
						speed.x *= speedModAfterRevolution.x;
						actor.physicComponent.vx *= 0.5;
					}
					
					if(numRevolutionMax.x != -1 && numRevolution.x >= numRevolutionMax.x) {
						speed.x = 0;
						actor.physicComponent.vx = 0;
					}
				}
			}
			
			if(direction.y == 0) {
				direction.y = (actor.physicComponent.vy > 0 ? 1 : -1);
			} else {
				if(direction.y != newDirectionY) {
					//speed.y += speedModAfterRevolution.y;
					direction.y = newDirectionY;
					actor.physicComponent.vy *= 0.5;
					numRevolution.y += 1;
					if(numRevolutionMax.y != -1 && numRevolution.y >= numRevolutionMax.y) {
						speed.y = 0;
						actor.physicComponent.vy = 0;
					}
				}
			}
		}
		
		static public function addToActor(actor:Actor, gotoX:int, gotoY:int):EffectGotoElastic2 {
			var result:EffectGotoElastic2 = new EffectGotoElastic2();
			if(actor.physicComponent == null) throw new Error("Actor must have a physicComponent");
			result.goto.x = gotoX;
			result.goto.y = gotoY;
			actor.addComponent(result);
			return result;
		}
	}
}
