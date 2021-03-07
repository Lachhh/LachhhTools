package com.lachhh.io {

	import flash.events.Event;
	/**
	 * @author Simon Lachance
	 */
	public class Callback {
		protected var _fct:Function ; 
		protected var _scope:Object;
		protected var _params:Array;
		
		public function Callback(fct:Function, scope:Object, params:Array) {
			_fct = fct ;
			_scope = scope ;
			_params = params ;
		} 
		
		public function call():void {
			_fct.apply(_scope, _params);
		}
		
		public function callWithParams(params:Array):void {
			_fct.apply(_scope, params);
		}
		
		public function onEvent(e:Event):void {
			call();
		}
		
		public function Destroy():void {
			_fct = null;
			_scope = null;
			_params = null;
		}
		
		public function get params():Array {
			return _params;
		}
		
		public function set params(params:Array):void {
			_params = params;
		}
		
		public function get fct():Function {
			return _fct;
		}
		
		public function set fct(fct:Function):void {
			_fct = fct;
		}
		
		public function get scope():Object {
			return _scope;
		}
		
		public function set scope(scope:Object):void {
			_scope = scope;
		} 
	}
}
