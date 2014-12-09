package com.giveawaytool.components {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.utils.Utils;

	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class LogicFollowMouse extends ActorComponent {
		private var delta:Point = new Point();
		
		public var speed:Number = 2;
		public function LogicFollowMouse() {
			super();
		}
	

		override public function update() : void {
			super.update();
			delta.x = CameraFlash.mainCamera.getMouseInWorld().x - actor.px;
			delta.y = CameraFlash.mainCamera.getMouseInWorld().y - actor.py;
			var tooCloseToMouse:Boolean = Utils.getSquaredDistance(0, 0, delta.x, delta.y) < speed*speed; 
			if(tooCloseToMouse) {
				actor.physicComponent.vx = delta.x*0.9;
				actor.physicComponent.vy = delta.y*0.9;
				//actor.renderComponent.animView.rotation = Utils.GetHomingAngle(actor.renderComponent.animView.rotation, 0, 1, 0, 0, 0.5);
			} else {
				delta.normalize(speed);
				actor.physicComponent.vx = delta.x;
				actor.physicComponent.vy = delta.y;
				actor.renderComponent.animView.rotation = Utils.GetHomingAngle(actor.renderComponent.animView.rotation, delta.x, delta.y, 0, 0, 0.5);
			}
		}
		
		static public function addToActor(actor: Actor):LogicFollowMouse {
			var result:LogicFollowMouse = new LogicFollowMouse();
			actor.addComponent(result);
			return result;
		}
	}
}
