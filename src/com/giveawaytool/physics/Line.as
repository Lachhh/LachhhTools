package com.giveawaytool.physics {
	/**
	 * @author LachhhSSD
	 */
	public class Line {
		static public var lineTemp:Line = new Line(0, 0, 0, 0);
		public var x1:Number;
		public var y1:Number;
		public var x2:Number;
		public var y2:Number;
		public function Line(pX1:Number, pY1:Number, pX2:Number, pY2:Number) {
			x1 = pX1;
			y1 = pY1;
			x2 = pX2;
			y2 = pY2;
		}
		
		public function intersectWithCircle(c:Circle):Boolean {
			return intersect(x1, y1, x2, y2, c.x, c.y, c.radius);
		}
		
		static public function toLineTemp(x1:Number, y1:Number, x2:Number, y2:Number):Line {
			lineTemp.x1 = x1;
			lineTemp.y1 = y1;
			lineTemp.x2 = x2;
			lineTemp.y2 = y2;
			return lineTemp;
		}
		
		static public function intersect(x1:Number, y1:Number, x2:Number, y2:Number, x:Number,y:Number,radius:Number):Boolean {
			var fx:Number = x1 - x;
			var fy:Number = y1 - y;
			
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			
			var a:Number = (dx * dx) + (dy * dy); // d.dot(d)
		    var b:Number = 2 * ((dx * fx) + (dy * fy)); // 2*f.dot(d)
		    var c:Number = (fx * fx) + (fy * fy) - (radius * radius); // f.dot(f)-r*r
		    var delta:Number = b*b - (4*a*c);     
			
			if(delta < 0) return false;
			
			var e : Number = Math.sqrt (delta);
			var u1 : Number = ( - b + e ) / (2 * a );
			var u2 : Number = ( - b - e ) / (2 * a );
			if ((u1 < 0 || u1 > 1) && (u2 < 0 || u2 > 1)) {
				if ((u1 < 0 && u2 < 0) || (u1 > 1 && u2 > 1)) {
					return false;
				} else {
					return true;
				}
			} else {
				return true;
			}
		}
		

		/*function Line:init(x1,y1,x2,y2)
		    self.x1 = x1 or 0
		    self.y1 = y1 or 0
		    self.x2 = x2 or 0
		    self.y2 = y2 or 0
		end
		
		function Line.intersect(x1, y1, x2, y2, x,y,radius)
		    local fx = x1 - x
		    local fy = y1 - y
		        
		    local dx = x2 - x1
		    local dy = y2 - y1
		    
		    local a = (dx * dx) + (dy * dy) -- d.dot(d)
		    local b = 2 * ((dx * fx) + (dy * fy)) -- 2*f.dot(d)
		    local c = (fx * fx) + (fy * fy) - (radius * radius) -- f.dot(f)-r*r
		    local delta = b*b - (4*a*c)   
		    
		    return delta >= 0
		end*/
	}
}
