package com.lachhh.flash.debug {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author LachhhSSD
	 */
	public class DebugManagerActorTree extends DebugTree {
		private var _actor:Actor;
		public function DebugManagerActorTree() {
			super();
		}
		
		public function setActor(actor:Actor):void {
			_actor = actor;
			setChildren();
		}
		
		public function setChildren():void {
			
			for (var i:int = 0 ; i < _actor.components.length; i++) {
				var actorComponent:ActorComponent = _actor.components[i];
				var child:DebugManagerTreeChild = GetChildIfNotCreated(i);
				AddChild(child);
				child.name = getQualifiedClassName(actorComponent).split("::")[1] + " " + actorComponent.debugInfo ;
			}
			
			for (i; i < numChild; i++) {
				RemoveChild(GetChildAt(i));
			}
		}
		
		private function GetChildIfNotCreated(i:int):DebugManagerTreeChild {
			var result:DebugManagerTreeChild ;
			if(i >= numChild) {
				result = new DebugManagerTreeChild(null);
			} else {
				result = GetChildAt(i) as DebugManagerTreeChild;
			}
			return result;
		}
	
	}
}
