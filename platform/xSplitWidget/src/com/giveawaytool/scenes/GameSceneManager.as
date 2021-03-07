package com.giveawaytool.scenes {
	import com.lachhh.lachhhengine.animation.AnimationManager;
	/**
	 * @author LachhhSSD
	 */
	public class GameSceneManager {
		public var gameScene : GameScene;
		public var hasAScene:Boolean ;
		public function GameSceneManager() {
			hasAScene = false;
		}
		
		public function loadScene(pGameScene:GameScene):void {
			destroyScene();
			gameScene = pGameScene;
			gameScene.start();
			gameScene.update();
			hasAScene = true;
		}
		
		public function destroyScene():void {
			if(hasAScene) {
				gameScene.destroy();
				hasAScene = false;
			}
			AnimationManager.factoryCache.ClearCache();
		}
		
		public function update():void {
			if(hasAScene) {
				if(gameScene.enabled) gameScene.update();
			}
		}
	}
}
