package com.lachhh.flash.debug {
	import com.lachhh.io.Callback;

	/**
	 * @author Lachhh
	 */
	public class DebugCallback extends Callback {
		private var _msg:String ;
		public function DebugCallback(msg:String, fct:Function, scope:Object, params:Array) {
			super(fct, scope, params);
			_msg = msg;
		}
		
		public function DoCallbackWithMsg(msg:String):void {
			_fct.apply(_scope, [msg].concat(_params));
		}
		
		public function get msg():String {
			return _msg;
		}
	}
}
