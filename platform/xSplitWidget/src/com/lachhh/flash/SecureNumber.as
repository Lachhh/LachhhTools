package com.lachhh.flash {

	/**
	 * @author Lachhh
	 */
	public class SecureNumber {
		private var _n:Number ;
		private var _random:Number ;
		private var _locked:Boolean = true;
		private var _value:Number;
		
		public function SecureNumber(n:Number = 0) {
			_random = Math.random()*10000;
			_n = n + _random;
			_value = n;
		}

		public function Test(n:Number):void {
			if(locked && _n != n + _random) {
				//ScreenManager.instance.ShowCheatScreen();
				throw new Error("Cheat Detected !");
			}
		}
		
		public function get value():Number {
			Test(_value);
			return _value;	
		}
		
		public function set value(n:Number):void {
			if(isNaN(n)) return ;
			Test(_value);
			_random = Math.random()*10000;
			_n = n + _random;
			_value = n;
		}
		
		public function get locked() : Boolean {
			return _locked;
		}
		
		public function set locked(locked : Boolean) : void {
			_locked = locked;
		}
	}
}
