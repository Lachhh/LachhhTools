package com.giveawaytool.physics {
	/**
	 * @author LachhhSSD
	 */
	public class Circle {
		static public var circleTemp:Circle = new Circle(0, 0, 0);
		public var x:Number = 0;
		public var y:Number = 0;
		public var radius : Number = 0;

		public function Circle(pX:Number, pY:Number, pRadius:Number) {
			x = pX;
			y = pY;
			radius = pRadius;
		}
		
		static public function toCircleTemp(x:Number, y:Number, radius:Number):Circle {
			circleTemp.x = x;
			circleTemp.y = y;
			circleTemp.radius = radius;
			return circleTemp;
		}
	}
}
