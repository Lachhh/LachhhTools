package com.giveawaytool.enemy {
	import com.giveawaytool.MainGameTools;
	import com.giveawaytool.components.ShadowRenderComponent;
	import com.giveawaytool.effect.LogicDestroyOutsideOfBounds;
	import com.giveawaytool.physics.CollisionCircleComponent;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.camera.CameraFlashContainers;
	import com.lachhh.lachhhengine.components.RenderComponent;

	/**
	 * @author LachhhSSD
	 */
	public class Enemy extends Actor {
		static public var allCollision:Vector.<CollisionCircleComponent> = new Vector.<CollisionCircleComponent>();
		public var circleColComponent:CollisionCircleComponent;
		public var destroyWhenOOB:Boolean;
		public function Enemy() {
			super();
			MainGameTools.instance.gameSceneManager.gameScene.enemyManager.add(this);
			renderComponent = ShadowRenderComponent.addToActor(this, CameraFlashContainers.instance.ammoVisual, -1);
			circleColComponent = CollisionCircleComponent.addToActor(this);
			collisionComponent = circleColComponent;
			collisionComponent.callbackOnCollision = new Callback(onCollision, this, null); 
			allCollision.push(circleColComponent);
			destroyWhenOOB = true;
			
			addComponentFromClass(LogicDestroyOutsideOfBounds);
		}

		protected function onCollision() : void {
		}
				
		override public function destroy() : void {
			super.destroy();
			for (var i : int = 0; i < allCollision.length; i++) {
				if(allCollision[i] == collisionComponent) {
					allCollision.splice(i, 1);
					break;
				}
			}
		}
		
	}
}
