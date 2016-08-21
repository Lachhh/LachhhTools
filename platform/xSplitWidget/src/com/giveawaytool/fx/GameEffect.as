package com.giveawaytool.fx {
	import com.giveawaytool.effect.EffectFadeInAlpha;
	import com.giveawaytool.effect.LogicRotate;
	import com.giveawaytool.effect.LogicSlowDownFadeOut;
	import com.giveawaytool.scenes.GameScene;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.camera.CameraFlashContainers;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.components.RenderComponent;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author LachhhSSD
	 */
	public class GameEffect extends Actor {
		
		public function GameEffect() {
			super();
			GameScene.instance.fxManager.add(this);
			
		}
		
		static public function createFx(visualContainer:DisplayObjectContainer, animId:int, x:int, y:int):GameEffect {
			var result:GameEffect = new GameEffect();
			result.renderComponent = RenderComponent.addToActor(result, visualContainer, animId);
			result.px = x;
			result.py = y;
			result.refresh();
			return result;
		}
		
	}
}
