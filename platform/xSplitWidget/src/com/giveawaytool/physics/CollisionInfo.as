package com.giveawaytool.physics {
	import com.lachhh.lachhhengine.components.CollisionComponent;
	/**
	 * @author LachhhSSD
	 */
	public class CollisionInfo {
		static public var NULL_COLLISION:CollisionInfo = new CollisionInfo(null);
		public var collisionComponent:CollisionComponent ;
		public var collidedWith : Vector.<Circle> = new Vector.<Circle>();
		public var isNull:Boolean = false;
		public function CollisionInfo(pActorComponent:CollisionComponent) {
			collisionComponent = pActorComponent;
			isNull = (pActorComponent == null);
		}
		
		

	}
}
