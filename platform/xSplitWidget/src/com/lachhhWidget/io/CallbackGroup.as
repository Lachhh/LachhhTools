package com.lachhh.io {

	/**
	 * @author Simon Lachance
	 */
	public class CallbackGroup {
		public var callbacks:Vector.<Callback> = new Vector.<Callback>();
		public function addCallback(c:Callback):void {
			if(c == null) return ;
			callbacks.push(c);
		}
		
		public function removeCallback(c:Callback):void {
			var i:int = callbacks.indexOf(c);
			if(i != -1) callbacks.splice(i, 1);
		}
		
		public function call():void {
			for (var i : int = 0; i < callbacks.length; i++) {
				var c:Callback = callbacks[i];
				c.call();
			}
		}
		
		public function callWithParams(params:Array):void {
			for (var i : int = 0; i < callbacks.length; i++) {
				var c:Callback = callbacks[i];
				c.callWithParams(params);
			}
		}
	}
}
