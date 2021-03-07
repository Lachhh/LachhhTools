package com.giveawaytool.physics {
	import com.lachhh.lachhhengine.MyMath;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.components.CollisionComponent;
	/**
	 * @author LachhhSSD
	 */
	public class CollisionCircleComponent extends CollisionComponent {
		static public var EMPTY_LIST:Vector.<CollisionInfo> = new Vector.<CollisionInfo>();
		public var circles:Vector.<Circle> = new Vector.<Circle>();
		public var circleCol:Circle ;
		private var targets:Vector.<CollisionCircleComponent> ;
		private var hasTarget:Boolean;
		
		 
		public function CollisionCircleComponent() {
			super();
			circleCol = addCircleCollision(0,0,1);
		}

		
		override public function update() : void {
			super.update();
			if(hasTarget) {
				attack(actor.px, actor.py, 10, actor.physicComponent.vx, actor.physicComponent.vy);
			}
		}
		
		public function setTargets(pTargets:Vector.<CollisionCircleComponent>):void {
			targets = pTargets;
			hasTarget = (targets != null);
		}
		
		public function addCircleCollision(x:Number, y:Number, radius:int):Circle {
			var result:Circle = new Circle(x, y, radius);
			circles.push(result);
			return result;
		}
		
		public function isCollidingWithCircle(x:Number, y:Number, radius:Number, vx:Number, vy:Number):CollisionInfo {
			 var squaredRadius:Number = radius*radius;
			 var result:CollisionInfo = CollisionInfo.NULL_COLLISION ;
			 for (var i : int = 0; i < circles.length; i++) {
			 	var circleToCheck:Circle = circles[i];
				var sumRadius:Number = circleToCheck.radius*circleToCheck.radius + squaredRadius;
				var distBetween:Number = MyMath.distSquared(x, y, actor.px+circleToCheck.x, actor.py+circleToCheck.y);
				
				if(distBetween < sumRadius) {
					if(result.isNull) result = new CollisionInfo(this);
					result.collidedWith.push(circleToCheck);
				} else if(Math.abs(vx) >= 0.1 || Math.abs(vy) >= 0.1) { 
					var tempLine:Line = Line.toLineTemp(x, y, x+vx, y+vy);
					var tempCircle:Circle = Circle.toCircleTemp(actor.px+circleToCheck.x, actor.py+circleToCheck.y, circleToCheck.radius);
					var collisionDetected:Boolean = tempLine.intersectWithCircle(tempCircle);
					if(collisionDetected) {
		                if(result.isNull) result = new CollisionInfo(this);
						result.collidedWith.push(circleToCheck);
					}
				}
			 }
			 return result;
		}
		
		public function attack(x:Number, y:Number, radius:Number, vx:Number, vy:Number):Vector.<CollisionInfo> {
			var result:Vector.<CollisionInfo> = CollisionCircleComponent.attackTargets(targets, x, y, radius, vx, vy);
			
			for (var i : int = 0; i < result.length; i++) {
				var colInfo:CollisionInfo = result[i];
				colInfo.collisionComponent.onHitByTarget(actor);
				onHitByTarget(colInfo.collisionComponent.actor);
			}
			
			return result;
		}
		
		static public function attackTargets(targets:Vector.<CollisionCircleComponent>, x:Number, y:Number, radius:Number, vx:Number, vy:Number):Vector.<CollisionInfo> {
			var result:Vector.<CollisionInfo> = EMPTY_LIST;
			for (var i : int = 0; i < targets.length; i++) {
				var theCollisionComponent:CollisionCircleComponent = targets[i];
				if(theCollisionComponent.actor.destroyed) continue;
				if(!theCollisionComponent.enabled) continue;
				var collision:CollisionInfo = theCollisionComponent.isCollidingWithCircle(x, y, radius, vx, vy);
				if(!collision.isNull) {
					if(result == EMPTY_LIST) result = new Vector.<CollisionInfo>();
					result.push(collision);
				}
			}
			
			if(VersionInfo.isDebug) {
				CameraFlash.mainCamera.debugDraw.drawCircle(Circle.toCircleTemp(x, y, radius));
			}
			
			return result;
		}
		
		static public function addToActor(actor : Actor):CollisionCircleComponent {
			var result:CollisionCircleComponent = new CollisionCircleComponent();
			actor.addComponent(result);
			return result;
		}
		
		
	}
}
