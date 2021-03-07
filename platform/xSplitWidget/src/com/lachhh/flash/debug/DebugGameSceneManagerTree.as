package com.lachhh.flash.debug {
	import com.giveawaytool.scenes.GameSceneManager;
	import com.lachhh.lachhhengine.ActorObjectManager;
	/**
	 * @author LachhhSSD
	 */
	public class DebugGameSceneManagerTree extends DebugTree {
		private var _gameSceneManager : GameSceneManager;
		private var _mgrChild:Array ; 
		
		public function DebugGameSceneManagerTree(gameSceneManager : GameSceneManager) {
			super();
			_gameSceneManager = gameSceneManager;
			_mgrChild = new Array();
		}
		
		override public function update():void {
			super.update();
			
			var i:int = 0 ;
			var numChild:int = 0;
			if(_gameSceneManager.hasAScene) {
				for (i = 0; i < _gameSceneManager.gameScene.allManagers.length; i++) {
					var actorMgr:ActorObjectManager = _gameSceneManager.gameScene.allManagers[i];
					var child:DebugManagerTree = GetChildIfNotCreated(i, actorMgr);
					AddChild(child);
					numChild += child.numChild;
					//child.name = getQualifiedClassName(actor).split("::")[1] + " (" + Math.ceil(actor.px) + "," + Math.ceil(actor.py) + ")";
				}
			}
			for (i; i < numChild; i++) {
				RemoveChild(GetChildAt(i));
			}
			name = "Game Scene (" + numChild + ")" ;
		}
		
		private function GetChildIfNotCreated(i:int, mgr:ActorObjectManager):DebugManagerTree {
			var result:DebugManagerTree ;
			if(i >= numChild) {
				result = new DebugManagerTree(mgr);
			} else {
				result = GetChildAt(i) as DebugManagerTree;
			}
			return result;
		}
	
	}
}
