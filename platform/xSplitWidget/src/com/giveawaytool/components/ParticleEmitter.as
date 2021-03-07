package com.giveawaytool.components {
	import com.giveawaytool.effect.LogicDestroyOutsideOfBounds;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.camera.CameraFlashContainers;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class ParticleEmitter extends ActorComponent {
		public var physicComponentToClone:PhysicComponent;
		public var offSetVRandom:Point = new Point(0,0);
		public var offSetPRandom:Point = new Point();
		public var offSet:Point = new Point();
		public var numParticleToEmit:int = 0;
		public var waitBetweenParticle:Number = 3;
		public var tweenWait:TweenNumberComponent ;
		public var parentVisual:DisplayObjectContainer;
		public var animId:Array = new Array();
		public var endCallback:Callback;
		public var onEmitCallback:Callback;
		public var particleAnimLooping:Boolean = false;
		public var destroyOutsideOfBounds:Boolean = true;
		public var lastEmitted:Actor = null;
		
		public function ParticleEmitter() {
			super();
			if(CameraFlashContainers.instance) parentVisual = CameraFlashContainers.instance.foreFxVisual;
		}

		override public function start() : void {
			super.start();
			tweenWait = TweenNumberComponent.addToActor(actor);
			tweenWait.goto = waitBetweenParticle;
			tweenWait.value = 0;
			
		}
		
		
		override public function update() : void {
			super.update();
			tweenWait.goto = waitBetweenParticle;
			if(tweenWait.hasReachedGoto()) {
				tweenWait.value = 0;
				emit();
				numParticleToEmit--;
				if(numParticleToEmit <= 0) {
					if(endCallback) endCallback.call();
					destroyAndRemoveFromActor();	
				}
			}
		}
		
		public function emit():void {
			var x:int = actor.px+offSet.x+getRandomInRange(offSetPRandom.x);
			var y:int = actor.py+offSet.y+getRandomInRange(offSetPRandom.y);
			
			if(animId.length > 0) {
				var fx:Actor = new Actor();
				UIBase.manager.add(fx);
				fx.renderComponent = RenderComponent.addToActor(fx, parentVisual, pickRandomId());
				fx.px = x;
				fx.py = y;
				
				if(physicComponentToClone) {
					fx.physicComponent = PhysicComponent.addToActor(fx);
					fx.physicComponent.vx = physicComponentToClone.vx+(getRandomInRange(offSetVRandom.x));
					fx.physicComponent.vy = physicComponentToClone.vy+(getRandomInRange(offSetVRandom.y));
					//fx.physicComponent.gravX = physicComponentToClone.gravX;
					fx.physicComponent.gravY = physicComponentToClone.gravY;
				}
				
				if(!particleAnimLooping) {
					fx.renderComponent.animView.addEndCallback(new Callback(fx.destroy, fx, null));
				}
				
				if(destroyOutsideOfBounds) LogicDestroyOutsideOfBounds.addToActorBasedOnUI(fx);
				lastEmitted = fx;
			}
			if(onEmitCallback) onEmitCallback.call();
		}
		
		private function pickRandomId():int {
			return Utils.pickRandomInInt(animId);
		}
		
		private function getRandomInRange(n:Number):Number {
			return (Math.random()*n);
		}

		override public function destroy() : void {
			super.destroy();
			if(tweenWait) tweenWait.destroyAndRemoveFromActor();
		}
		
		static public function addToActor(actor: Actor): ParticleEmitter {
			var result: ParticleEmitter = new ParticleEmitter ();
			actor.addComponent(result);
			return result;
		}


	}
}
