package com.lachhh.lachhhengine.components {
	import com.lachhh.lachhhengine.actor.Actor;
	/**
	 * @author LachhhSSD
	 */
	public class ActorComponent {
		public var actor:Actor;
		public var enabled:Boolean = true;
		public var started:Boolean = false;
		public var destroyed:Boolean = false;
		public var debugInfo:String = "";
		public function ActorComponent() {
			enabled = true;
			started = false;
		}
		
		public function start():void {
			started = true;
		}

		
		public function update():void {
			if(!started) start();
		}
		
		public function refresh():void {
			
		}
		
		public function destroy():void {
			destroyed = true;
		}
		
		public function destroyAndRemoveFromActor():void {
			actor.removeComponent(this);
		}
	}
}
