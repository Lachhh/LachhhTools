package com.lachhh.draw {
	import flash.display.BitmapData;
	
	/**
	 * @author Lachhh
	 */
	public class CopypixelableBmpData {
		private var _bmpData:BitmapData ;
		private var _x:int ;
		private var _y:int ;
		
		
		public function get bmpData():BitmapData {
			return _bmpData;
		}
		
		public function set bmpData(bmpData:BitmapData):void {
			_bmpData = bmpData;
		}
		
		public function Destroy():void {
			if(_bmpData != null) {
				_bmpData.dispose();
				_bmpData = null;
			}
			x = 0; 
			y = 0 ;
		}
		 
		public function get x():int {
			return _x;
		}
		
		public function set x(x:int):void {
			_x = x;
		}
		
		public function get y():int {
			return _y;
		}
		
		public function set y(y:int):void {
			_y = y;
		}
	}
}
