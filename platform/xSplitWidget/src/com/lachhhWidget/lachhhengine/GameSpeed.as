package com.lachhh.lachhhengine {
	import com.lachhh.flash.FlashUtils;
	import flash.utils.getTimer;
	/**
	 * @author LachhhSSD
	 */
	public class GameSpeed {
		
		static public var speed:Number = 1;
		static public function getSpeed():Number {
			return speed;
		}
		
		static public function getTime():Number {
			return FlashUtils.myGetTime();
		}
	}
}
