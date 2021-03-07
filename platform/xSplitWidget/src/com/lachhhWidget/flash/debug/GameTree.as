package com.lachhh.flash.debug {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.scenes.GameSceneManager;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ActorObjectManager;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.getTimer;

	/**
	 * @author Lachhh
	 */
	public class GameTree {
		static private var _debugTree:DebugTree ;
		static private var _initTime:Number = -1;
		static private var _timeNow:Number = -1;
		static private var _timeDif:Number = -1;
		static private var _nFrame:Number ;
		static private var _nFPS:Number = 60;
		
		static private var _objPos:Point;
		
		static private var _logicChild:DebugTree;
		static private var _miscChild:DebugTree;
		static private var _statsChild:DebugTree;
		static private var _msChild:DebugTree;
		static private var _fpsChild:DebugTree;
		static private var _memChild:DebugTree;
		static private var _jukeboxTree:DebugManagerActorTree;
		static private var _callbacks:Array ;
		
		
		static public function init():void {
			if(_debugTree != null) return ;
			
			_debugTree = new DebugTree();
			_debugTree.name = "Debug";
			_debugTree.Open();
			
			
			
			AddChildAt("Logical Managers",_debugTree);
			
			AddChildAt("Misc.",_debugTree);
			AddChildAt("Stats.",_debugTree);
			AddChildAt("Time Profiler",_debugTree);
			
			_logicChild = _debugTree.GetChildAt(0);
			_miscChild = _debugTree.GetChildAt(2);
			_statsChild = _debugTree.GetChildAt(3);
			_msChild = _debugTree.GetChildAt(4);
			
			AddAnimationChild();
			
			AddGameSceneManagerChild(MainGame.instance.gameSceneManager); 
	
			
			AddManagerChild(UIBase.manager);
			_jukeboxTree = new DebugManagerActorTree();
			_jukeboxTree.setActor(JukeBox.getInstance());
			_jukeboxTree.name = "JukeBox";
			_logicChild.AddChild(_jukeboxTree);
			
			//AddManagerChild(context.behaviorManager);
			//AddManagerChild(context.gameEffectManager);
			//AddManagerChild(context.enemyManager);
			//AddManagerChild(PhysicManager.instance);
			//AddManagerChild(context.heroManager);
			//AddManagerChild(context.itemManager);
			//AddManagerChild(context.gameEventManager);
			//AddSfxChild();
			//AddManagerChild(MetaManager.instance);
			//AddManagerChild(ScreenManager.instance);
			//AddManagerChild(context.weaponManager);	
			
			_fpsChild = new DebugTree();
			_miscChild.AddChild(_fpsChild);
			
			_memChild = new DebugTree();
			_miscChild.AddChild(_memChild);
			
			
			AddChildWithCallBack(CamPos, GameTree);
			AddChildWithCallBack(MousePos, GameTree);
			AddChildWithCallBack(MousePosInWorld, GameTree);
			
			/*AddChildWithCallBack(NbUpdatable, GameTree, context);
			
			AddChildWithCallBack(NbLevelPart, GameTree,context);
			AddChildWithCallBack(NbHeroLineInView, GameTree,context);
			AddChildWithCallBack(NbHeroCircleInView, GameTree,context);
			AddChildWithCallBack(LoaderInfo, GameTree,context);*/
			
			/*for (var i:int = 0 ; i < StatsGroup.allStatsGroup.length ; i++) {
				AddStats(StatsGroup.allStatsGroup[i]);	
			}*/
			
			_miscChild.Open();
			//var anim
			_objPos = new Point();
			_initTime = getTimer();
			_timeNow = getTimer();
			_timeDif = getTimer();
			_callbacks = new Array();
			
			AddDebugCallback(new DebugCallback("error", ThrowError, GameTree, [null]));
		}
		
		static private function ThrowError(msg:String, params:Object):void {
			throw new Error(msg);
		}
		
		static public function AddChildWithCallBack(fct:Function, scope:Object):void {
			if(_miscChild == null) {
				init();
			}
			
			var child:DebugTree = AddChildAt("", _miscChild);
			child.updateCallBack = new Callback(fct, scope, [child]);
		}
		
		static public function AddDebugCallback(d:DebugCallback):void {
			_callbacks.push(d);
		}
		
		static public function DoCallback(msg:String):void {
			for (var i:int = 0 ; i < _callbacks.length ; i++) {
				var d:DebugCallback = _callbacks[i];
				if(msg.toLowerCase().indexOf(d.msg.toLowerCase()) != -1) {
					d.DoCallbackWithMsg(msg);
					return ;	
				}	
			}
		}

		static private function AddChildAt(name:String, parent:DebugTree):DebugTree {
			var child:DebugTree = new DebugTree();
			child.name = name;
			parent.AddChild(child);
			return child; 
		}
		
		/*static public function AddStats(statsGroup:StatsGroup):void {
			_statsChild.AddChild(new DebugStatsTree(statsGroup));	
		}*/
		
		static public function AddManagerChild(manager:ActorObjectManager):void {
			var child:DebugManagerTree = new DebugManagerTree(manager);
			child.name = manager.debugName;
			_logicChild.AddChild(child);
		}
		
		static public function AddGameSceneManagerChild(gameSceneMgr:GameSceneManager):void {
			var child:DebugGameSceneManagerTree = new DebugGameSceneManagerTree(gameSceneMgr);
			_logicChild.AddChild(child);
		}
		
		static public function AddAnimationChild():void {
			var child:DebugAnimationManagerTree = new DebugAnimationManagerTree();
			_logicChild.AddChild(child);
		}
		
		static public function GetTree():DebugTree {
			init();
			return _debugTree;
		}
		
		static public function update():void {
			init();
			_jukeboxTree.setChildren();
			_debugTree.update();
			
			_timeDif = (getTimer() - _timeNow) ; 
			_timeNow = getTimer();
			var strMem:String = Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + ' Mb';
			
			
			_fpsChild.name = "FPS : " + _nFPS ;
			_memChild.name = "MEM : " + strMem ; 
			
			_nFrame++;
			
			if (_timeNow - _initTime >= 1000) {
				_nFPS = _nFrame ;
				
				_initTime = getTimer();
				_nFrame = 0 ;
			}	
			
		
		}
		
		static private function CamPos(child:DebugTree):void {
			if(MainGame.instance.gameSceneManager.hasAScene) {
				_objPos.x = MainGame.instance.gameSceneManager.gameScene.camera.px ;
				_objPos.y = MainGame.instance.gameSceneManager.gameScene.camera.py;
			}
	
			child.name = "Camera Position : " + "(" + Math.round(_objPos.x) + "," + Math.round(_objPos.y) + ")";
		}
		
		static private function MousePos(child:DebugTree):void {
			_objPos.x = MainGame.instance.mouseX;
			_objPos.y = MainGame.instance.mouseY;
	
			child.name = "Mouse Position : " + "(" + Math.round(_objPos.x) + "," + Math.round(_objPos.y) + ")";
		}
		
		static private function MousePosInWorld(child:DebugTree):void {
			if(MainGame.instance.gameSceneManager.hasAScene) {
				var cam:CameraFlash = MainGame.instance.gameSceneManager.gameScene.camera;
				_objPos.x = MainGame.instance.mouseX + cam.boundsFOV.x;
				_objPos.y = MainGame.instance.mouseY + cam.boundsFOV.y;
			}
	
			child.name = "Mouse Position In World: " + "(" + Math.round(_objPos.x) + "," + Math.round(_objPos.y) + ")";
		}
		
		static public function get msChild():DebugTree {
			return _msChild;
		}
	}
}
