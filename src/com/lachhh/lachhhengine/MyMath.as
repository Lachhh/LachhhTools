package com.lachhh.lachhhengine {
	/**
	 * @author LachhhSSD
	 */
	public class MyMath {
		static public var isInit:Boolean = false;
		static public var tabCos:Vector.<Number> = new Vector.<Number>();
		static public var tabSin:Vector.<Number> = new Vector.<Number>();
		static public function init():void {
			if (MyMath.isInit) return ;
		    MyMath.isInit = true;
		    
		    var p:Number = Math.PI/360;
			for (var i : int = 0; i < 720; i++) {
				MyMath.tabCos.push(Math.cos(i*p));
		        MyMath.tabSin.push(Math.sin(i*p));
			}
		    
		    MyMath.tabSin[360] = 0;  // Sinon c'est égale a xE-16;
		}
		
		static public function myCos(n:Number):Number {
			return tabCos[getIndex(n)];
		}
		
		static public function mySin(n:Number):Number {
			return tabSin[getIndex(n)];
		}
		
		static private function getIndex(n:Number):int {
			while(n < 0) n += 360;
			while(n >= 360) n -= 360;
			return Math.floor(n*2);
		}
		
		static public function distSquared(x1:Number, y1:Number, x2:Number, y2:Number):Number {
			var dx:Number = x1-x2;
			var dy:Number = y1-y2;
			return dx*dx+dy*dy;  
		}
		
		static public function GetRotation(x1:Number,x2:Number,y1:Number,y2:Number):Number {
			var dx:Number = x1-x2;
			var dy:Number = y1-y2;
			
			return GetRotationFromVelocity(dx, dy);
		}
		
		static public function GetRotationFromVelocity(vx:Number,vy:Number):Number {
			var rot:Number = Math.atan2(vy,vx);
			
			return (rot/Math.PI)*180;
		}
		
		/*function MyMath.distSquared(x1,y1,x2,y2)
		    local dx = x1-x2
		    local dy = y1-y2
		    return dy*dy+dx*dx
		end*/
	}
}
