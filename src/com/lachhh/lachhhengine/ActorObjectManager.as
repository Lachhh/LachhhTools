package com.lachhh.lachhhengine {
	import com.lachhh.utils.Utils;
	import com.lachhh.lachhhengine.actor.Actor;
	/**
	 * @author LachhhSSD
	 */
	public class ActorObjectManager {
		public var debugName:String="";
		public var actorList: Vector.<Actor> = new Vector.<Actor>();
		public function ActorObjectManager() {
			actorList = new Vector.<Actor>();
		}
		
		public function add(actor:Actor):void {
			actorList.push(actor);
		}
		
		public function update():void {
			updateChildren();
			removeDestroyedChildren();
		}
		
		private function updateChildren():void {
			var actor:Actor;
			var i:int = 0;
			for (i = 0; i < actorList.length; i++) {
				actor = actorList[i];
				if(actor.destroyed) continue;
				if(!actor.started) actor.start();
				if(actor.enabled) actor.update();
				
			}
		}
		
		private function removeDestroyedChildren():void {
			var actor:Actor;
			var i:int = 0;
			for (i = 0; i < actorList.length; i++) {
				actor = actorList[i];
				if(actor.destroyed) {
					actorList.splice(i, 1);
					i--;
				}
			}
		}
		
		public function refresh():void {
			var actor:Actor;
			var i:int = 0;
			for (i = 0; i < actorList.length; i++) {
				actor = actorList[i];
				actor.refresh();
			}
		}
		
		
		public function getNbActive():int {
		    return actorList.length;
		}
		
		public function destroy():void {
			var i:int = 0;
			var actor:Actor;
			for (i = 0; i < actorList.length; i++) {
				actor = actorList[i];
				if(!actor.destroyed) {
					actor.destroy();
				}
			}
			actorList = new Vector.<Actor>();
		}
		
		public function destroyAll(theClass:Class):void {
			var i:int = 0 ;
			var actor:Actor; 
			for (i = 0; i < actorList.length; i++) {
				actor = actorList[i];
				if(Utils.myIsInstanceOfClass(actor, theClass)) {
					actor.destroy();
				}
			}
		}
		
		public function appendAllInstanceOf(theClass:Class, outputArray:Array):Array {
			var i:int = 0 ;
			var actor:Actor; 
			for (i = 0; i < actorList.length; i++) {
				actor = actorList[i];
				if(Utils.myIsInstanceOfClass(actor, theClass)) {
					outputArray.push(actor);
				}
			}
			return outputArray;
		}
		
		public function getNearest(x:int, y:int):Actor {
			var result:Actor ;
			var actor:Actor; 
			var minDistance:int = int.MAX_VALUE;
			var distSquared:Number;
			
			for (var i : int = 0; i < actorList.length; i++) {
				actor = actorList[i];	
				distSquared = Utils.getSquaredDistance(actor.px, actor.py, x, y);
				if(minDistance == int.MAX_VALUE || distSquared < minDistance) {
					minDistance = distSquared;
					result = actor;
				}
			}
			return result;
		}
	}
}
