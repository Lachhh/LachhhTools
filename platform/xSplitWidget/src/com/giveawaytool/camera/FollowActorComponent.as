package com.giveawaytool.camera {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	/**
	 * @author LachhhSSD
	 */
	public class FollowActorComponent extends ActorComponent {
		public var actorToFollow:Actor;
		public var easeX:Number = 0.1;
		public var easeY:Number = 0.1;
		public var offsetX:Number = 0;
		public var offsetY:Number = 0;
		public function FollowActorComponent() {
			super();
		}

		override public function update() : void {
			super.update();
			actor.px += ((actorToFollow.px+offsetX)-actor.px)*easeX;
			actor.py += ((actorToFollow.py+offsetY)-actor.py)*easeY;
		}
		
		static public function addToActor(actor:Actor, actorToFollow:Actor):FollowActorComponent {
			 var result:FollowActorComponent = new FollowActorComponent();
			 result.actorToFollow = actorToFollow;
			 actor.addComponent(result);
			 return result;
		}
		
		
	}
}
