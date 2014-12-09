package com.giveawaytool.physics {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class ReboundOnCameraSide extends ActorComponent {
		public function ReboundOnCameraSide() {
			super();
			
		}

		override public function update() : void {
			super.update();
			var minBound:int = CameraFlash.mainCamera.boundsFOV.left+50;
			var maxBound:int = CameraFlash.mainCamera.boundsFOV.right-50;
			if(actor.px < minBound) {
				actor.physicComponent.vx *= -1;
				actor.px = minBound;
			}
			
			if(actor.px > maxBound) {
				actor.physicComponent.vx *= -1;
				actor.px = maxBound;
			}
			
		}
		
		static public function addToActor(actor:Actor):ReboundOnCameraSide {
			var result:ReboundOnCameraSide = new ReboundOnCameraSide();
			actor.addComponent(result);
			return result;
		}
	}
}
