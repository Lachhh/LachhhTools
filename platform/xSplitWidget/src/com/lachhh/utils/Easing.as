package com.lachhh.utils {
	/**
	 * @author LachhhSSD
	 */
		public class Easing
	{
		private static const PI_M2:Number = Math.PI*2;
		private static const PI_D2:Number = Math.PI/2;

		/*
		Linear
		---------------------------------------------------------------------------------
		*/
		public static var linear:Function = easeLinear;
		public static var none:Function = easeLinear;
		public static function easeLinear (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*t/d + b;
		}

		/*
		Sine
		---------------------------------------------------------------------------------
		*/
		public static function easeInSine (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * Math.cos(t/d * PI_D2) + c + b;
		}
		public static function easeOutSine (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c * Math.sin(t/d * PI_D2) + b;
		}
		public static function easeInOutSine (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
		}

		/*
		Quintic
		---------------------------------------------------------------------------------
		*/
		public static function easeInQuint (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*(t/=d)*t*t*t*t + b;
		}
		public static function easeOutQuint (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*((t=t/d-1)*t*t*t*t + 1) + b;
		}
		public static function easeInOutQuint (t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
			return c/2*((t-=2)*t*t*t*t + 2) + b;
		}

		/*
		Quartic
		---------------------------------------------------------------------------------
		*/
		public static function easeInQuart (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*(t/=d)*t*t*t + b;
		}
		public static function easeOutQuart (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * ((t=t/d-1)*t*t*t - 1) + b;
		}
		public static function easeInOutQuart (t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
			return -c/2 * ((t-=2)*t*t*t - 2) + b;
		}

		/*
		Quadratic
		---------------------------------------------------------------------------------
		*/
		public static function easeInQuad (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*(t/=d)*t + b;
		}
		public static function easeOutQuad (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c *(t/=d)*(t-2) + b;
		}
		public static function easeInOutQuad (t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t/=d/2) < 1) return c/2*t*t + b;
			return -c/2 * ((--t)*(t-2) - 1) + b;
		}

		/*
		Exponential
		---------------------------------------------------------------------------------
		*/
		public static function easeInExpo (t:Number, b:Number, c:Number, d:Number):Number
		{
			return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
		}
		public static function easeOutExpo (t:Number, b:Number, c:Number, d:Number):Number
		{
			return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
		}
		public static function easeInOutExpo (t:Number, b:Number, c:Number, d:Number):Number
		{
			if (t==0) return b;
			if (t==d) return b+c;
			if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
			return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
		}

		/*
		Elastic
		---------------------------------------------------------------------------------
		*/
		public static function easeInElastic (t:Number, b:Number, c:Number, d:Number, a:Number=undefined, p:Number=undefined):Number
		{
			var s:Number;
			if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
			if (!a || a < Math.abs(c)) { a=c; s=p/4; }
			else s = p/PI_M2 * Math.asin (c/a);
			return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*PI_M2/p )) + b;
		}
		public static function easeOutElastic (t:Number, b:Number, c:Number, d:Number, a:Number=undefined, p:Number=undefined):Number
		{
			var s:Number;
			if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
			if (!a || a < Math.abs(c)) { a=c; s=p/4; }
			else s = p/PI_M2 * Math.asin (c/a);
			return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*PI_M2/p ) + c + b);
		}
		public static function easeInOutElastic (t:Number, b:Number, c:Number, d:Number, a:Number=undefined, p:Number=undefined):Number
		{
			var s:Number;
			if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
			if (!a || a < Math.abs(c)) { a=c; s=p/4; }
			else s = p/PI_M2 * Math.asin (c/a);
			if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*PI_M2/p )) + b;
			return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*PI_M2/p )*.5 + c + b;
		}

		/*
		Circular
		---------------------------------------------------------------------------------
		*/
		public static function easeInCircular (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
		}
		public static function easeOutCircular (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
		}
		public static function easeInOutCircular (t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
			return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
		}

		/*
		Back
		---------------------------------------------------------------------------------
		*/
		public static function easeInBack (t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number
		{
			return c*(t/=d)*t*((s+1)*t - s) + b;
		}
		public static function easeOutBack (t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number
		{
			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		}
		public static function easeInOutBack (t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number
		{
			if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
		}

		/*
		Bounce
		---------------------------------------------------------------------------------
		*/
		public static function easeInBounce (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c - easeOutBounce (d-t, 0, c, d) + b;
		}
		public static function easeOutBounce (t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t/=d) < (1/2.75)) {
				return c*(7.5625*t*t) + b;
			} else if (t < (2/2.75)) {
				return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
			} else if (t < (2.5/2.75)) {
				return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
			} else {
				return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
			}
		}
		public static function easeInOutBounce (t:Number, b:Number, c:Number, d:Number):Number
		{
			if (t < d/2) return easeInBounce (t*2, 0, c, d) * .5 + b;
			else return easeOutBounce (t*2-d, 0, c, d) * .5 + c*.5 + b;
		}

		/*
		Cubic
		---------------------------------------------------------------------------------
		*/
		public static function easeInCubic (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*(t/=d)*t*t + b;
		}
		public static function easeOutCubic (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*((t=t/d-1)*t*t + 1) + b;
		}
		public static function easeInOutCubic (t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t/=d/2) < 1) return c/2*t*t*t + b;
			return c/2*((t-=2)*t*t + 2) + b;
		}
	}
}
