package com.giveawaytool.scenes {
	import com.giveawaytool.MainGameTools;
	import com.lachhh.lachhhengine.ActorObjectManager;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	/**
	 * @author LachhhSSD
	 */
	public class GameScene {
		static public var instance:GameScene;
		
		public var enemyManager:ActorObjectManager ;
		public var heroManager:ActorObjectManager ;
		public var itemManager : ActorObjectManager ;
		public var ammoManager : ActorObjectManager ;
		public var fxManager : ActorObjectManager ;
		public var allManagers:Vector.<ActorObjectManager>;
		public var camera:CameraFlash ;
		
		
		public var enabled:Boolean = true;
		public var destroyed:Boolean = false;
		public function GameScene() {
			instance = this;
			allManagers = new Vector.<ActorObjectManager>();
			enabled = true;
			destroyed = false;
		}
		
		public function start():void {
			camera = new CameraFlash(MainGameTools.instance);
			
			enemyManager = createManagers("Enemies");
			heroManager = createManagers("Heroes");
			itemManager = createManagers("items");
			ammoManager = createManagers("ammos");
			fxManager = createManagers("FXs");
			
			
			camera.start();
		}
		
		public function update():void {
			if(destroyed) return ;
			camera.update();
			enemyManager.update();
			heroManager.update();
			itemManager.update();
			ammoManager.update();
			fxManager.update();
		}
		
		public function destroy():void {
			camera.destroy();
			enemyManager.destroy();
			heroManager.destroy();
			itemManager.destroy();
			ammoManager.destroy();
			fxManager.destroy();
			destroyed = true;
		}
		
		public function pause(b:Boolean):void {
			enabled = !b;
		}
		
		private function createManagers(debugName:String):ActorObjectManager {
			var result:ActorObjectManager = new ActorObjectManager();
			result.debugName = debugName;
			allManagers.push(result);
			return result;
		}
		
		public function refreshAll():void {
			for (var i : int = 0; i < allManagers.length; i++) {
				var mgr:ActorObjectManager = allManagers[i];
				mgr.refresh();
			}
		}
	}
}
