package com.giveawaytool.fx {
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.components.RenderComponent;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author LachhhSSD
	 */
	public class GameEffectRotate extends GameEffect {
		public var rotateSpeed:Number= 3;
		public function GameEffectRotate() {
			super();
			physicComponent = PhysicComponent.addToActor(this);
			
		}

		override public function update() : void {
			super.update();
			renderComponent.animView.rotation += rotateSpeed;
			if(py >  CameraFlash.mainCamera.boundsFOV.bottom +100) {
				destroy();
			}
		}
		
		static public function createStaticFx(visualContainer:DisplayObjectContainer, animId:int, x:int, y:int):GameEffectRotate {
			var result:GameEffectRotate = new GameEffectRotate();
			result.renderComponent = RenderComponent.addToActor(result, visualContainer, animId);
			result.px = x;
			result.py = y;
			result.refresh();
			return result;
		}

	}
}
