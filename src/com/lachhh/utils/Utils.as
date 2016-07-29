package com.lachhh.utils {
	import com.lachhh.flash.ui.Button;
	import com.lachhh.lachhhengine.actor.Actor;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Simon Lachance
	 */
	public class Utils {
		static private const BLACK_N_WHITE:ColorMatrixFilter = new ColorMatrixFilter([0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0,0,0,1,0]);
		static private var _theFilter:ColorMatrixFilter = ColorMatrixFilter(BLACK_N_WHITE.clone());
		static private var _theFilterArray:Array = [_theFilter];
		
		static public function PutBlackAndWhite(d:DisplayObject, blackNWhite:Boolean = true):void {
			if(blackNWhite) {
				d.filters = _theFilterArray;
			} else {
				d.filters = [];
			}
		}

		static public function GetIndexOfElem(array:Array, elem:Object):int {
			for (var i:int = 0 ; i < array.length ; i++) {
				if(array[i] == elem) {
					return i;
				}
			}	
			return -1;
		}
		
		static public function IsInArray(array:Array, elem:Object):Boolean {
			for (var i:int = 0 ; i < array.length ; i++) {
				if(array[i] == elem) {
					return true;
				}
			}	
			return false;
		}

		static public function AddInArrayIfNotIn(array : Array, elem : Object) : void {
			for (var i : int = 0; i < array.length; i++) {
				if(array[i] == elem) {
					return ;
				}
			}	
			array.push(elem);
		}
		
		static public function CreateBmpFromMc(anim:MovieClip):Bitmap {
			var origin:Point = GetOriginOfMc(anim);
			var bd:BitmapData = new BitmapData(anim.width, anim.height, true,0);
			var m:Matrix = new Matrix();
			var bmp:Bitmap ;
			m.translate(origin.x, origin.y);
			bd.draw(anim, m);
			bmp = new Bitmap(bd);
			bmp.x = -origin.x;
			bmp.y = -origin.y;
			return bmp;
		}

		static public function RemoveFromArray(array:Array, elem:Object):Boolean {
			for (var i:int = 0 ; i < array.length ; i++) {
				if(array[i] == elem) {
					array.splice(i,1);
					return true;
				}
			}	
			return false;
		}
		
		static public function RemoveNull(array:Array):void {
			for (var i:int = 0 ; i < array.length ; i++) {
				if(array[i] == null) {
					array.splice(i,1);
					i--;
				}
			}	
		}
		
		static public function ClearArray(array:Array):void {
			if(array == null) return;
			while(array.length > 0)array.shift();
		}
				
		static public function EnableButton(pEnable:Boolean, mc:Button):void {
			
			if(pEnable){
				SetColorDEPRECATED(0,0,0,1, mc);
				mc.gotoUp();
			} else {
				SetColorDEPRECATED(100,100,100,1, mc);
				mc.gotoUp();
			}
			mc.mouseEnabled = pEnable;
			mc.mouseChildren = pEnable;
		}
		static public function SetColorDEPRECATED(r:int, g:int, b:int, a:int, d:DisplayObject):void {
			var ct:ColorTransform = new ColorTransform();
			ct.redOffset = r;
			ct.blueOffset = b;
			ct.greenOffset = g;
			ct.alphaMultiplier = a;
			d.transform.colorTransform = ct;
		}
		
		static public function SetColor(d:DisplayObject, r:Number = 0, g:Number = 0, b:Number= 0, a:Number= 0, rm:Number= 1, gm:Number= 1, bm:Number= 1, am:Number = 1):void {
			var ct:ColorTransform = d.transform.colorTransform ;
			ct.redOffset = r;
			ct.greenOffset = g;
			ct.blueOffset = b;
			ct.alphaOffset = a;
			ct.redMultiplier = rm;
			ct.greenMultiplier = gm;
			ct.blueMultiplier = bm;
			ct.alphaMultiplier = am;
			d.transform.colorTransform = ct;
		}
		
		static public function SetColor2(d:DisplayObject, color:uint):void {
			var ct:ColorTransform = d.transform.colorTransform ;
			ct.color = color;
			ct.alphaOffset = 0;
			ct.redMultiplier = 0;
			ct.greenMultiplier = 0;
			ct.blueMultiplier = 0;
			ct.alphaMultiplier = 1;
			d.transform.colorTransform = ct;
			//154,136,110,0,0,0,0,1
		}
		
		
		
		
		static public function GetOriginOfMc(mc:DisplayObject):Point {
			
			var rect:Rectangle = mc.getBounds(mc);
			var origin:Point = new Point();
						
			origin.x = (mc.x - rect.x) ;
			origin.y = (mc.y - rect.y) ;
			return origin;
		}
		
		static public function PutZero(n:int, digits:int = 2):String {
			var s:String = String(n);
			var temp:Number ;
			if(n <= 0) {
				temp = 1 / Math.pow(10, digits-1);
			} else {
				temp = n / Math.pow(10, digits-1);
			}
			
			while(temp<1) {
				temp*=10;
				s = "0" + s;
			}
			return s;
		}
		
		static public function FrameToTimeAdvanced(frame:int, fps:int, minuteLabel:String = null, secondLabel:String = null, msLabel:String = null):String {
			var min:int = Math.floor(frame / (fps * 60));
			frame-= (fps * 60)*min;
			var sec:int = Math.floor(frame / fps);
			frame-= fps*sec;
			var ms:int = Math.floor((frame / fps)*100);
			var result:String = "";
			if(minuteLabel != null) result += PutZero(min) + " " + minuteLabel ;
			if(secondLabel != null) result += PutZero(sec) + " " + secondLabel ;
			if(msLabel != null) result += PutZero(ms) + " " + msLabel ; 
			return result;
		}
		
		static public function FrameToTime(frame:int, fps:int):String {
			var min:int = Math.floor(frame / (fps * 60));
			frame-= (fps * 60)*min;
			var sec:int = Math.floor(frame / fps);
			frame-= fps*sec;
			var ms:int = Math.floor((frame / fps)*100);
			
			return (PutZero(min) + ":" + PutZero(sec) + ":" + PutZero(ms));
		}
		
		static public function secondsToTime(seconds:int):String {
			var min:int = Math.floor(seconds / (60));
			seconds-= (60)*min;
			var sec:int = Math.floor(seconds);
			seconds-= sec;
			
			return (PutZero(min) + ":" + PutZero(sec)) ;
		}
			
		static public function LazyRemoveFromParent(d:DisplayObject):void {
			if(d == null) return ;
			if(d.parent != null) {d.parent.removeChild(d);}
		}
		
		static public function RoundOn(n:Number, tolerance:Number):Number {
			var floor:Number = Math.ceil(n / tolerance)*tolerance;
			var ceil:Number = Math.floor(n / tolerance)*tolerance;
			var diff:Number = n-floor;
			var prct:Number = diff/(ceil-floor);
			
			return (prct <= 0.5 ? floor : ceil);
		}
		
		static public function IsInstanceOfClass(obj:Object, classes:Array):Boolean {
			for (var i:int = 0 ; i < classes.length ; i++) {
				if (obj is classes[i]) return true;
			}
			return false;
		}
		 
		static public function GetHomingAngle(angle:Number, x1:Number, y1:Number, x2:Number, y2:Number, precision:Number):Number {
			var realAngle:Number = GetRotation(x2, x1, y2, y1);
			var nDiff:Number = (realAngle - angle);
			while (nDiff >180) nDiff -= 360;
			while (nDiff <-180) nDiff += 360;
			while (angle >180) angle -= 360;
			while (angle <-180) angle += 360;
			angle += nDiff*precision ;

			return angle; 	
		}
		
		static public function GetRotation(x1:Number,x2:Number,y1:Number,y2:Number):Number {
			var dx:Number = x1-x2;
			var dy:Number = y1-y2;
			var rot:Number = Math.atan2(dy,dx);
			
			return (rot/Math.PI)*180;
		}
		
		static public function IsActorInRange(actor1:Actor, actor2:Actor, rayon:Number):Boolean {
			var dx:Number = actor2.px - actor1.px;
			var dy:Number = actor2.py - actor1.py;
			return (dx*dx+dy*dy)<rayon*rayon;
		}
				
		static public function PutVirgules(n:int):String {
			var result:String = n+"";
			var tempA:Array = new Array();
			for (var i:int = result.length-1 ; i >= 0 ; i-=3) {
				var index:int = Math.max(0,i-2);
				var len:int = (i - index)+1;
				if(len > 0) {
					tempA.unshift(result.substr(index,len));
				}
			}
			return tempA.join(",");
		}
				
		static public function CropIn(value:int, rangeStart:int, rangeEnd:int):int {
			var result:int = value;
			var diff : int = (rangeEnd - rangeStart)+1;
			if(diff <= 0) return -1;
			while(result < rangeStart) result += diff;
			while(result > rangeEnd) result -= diff;
			return result;
		}
		
		static public function RecurStop(mc:MovieClip):void {
			for (var i:int = 0 ; i < mc.numChildren ; i++)	 {
				var d:DisplayObject = mc.getChildAt(i);
				if(d is MovieClip) {
					var m:MovieClip = MovieClip(d);
					RecurStop(m);
					m.gotoAndStop(1);
				}	
			}
		}
		
		static public function SetMaxSizeOfTxtField(tf:TextField, maxSize:int):void {
			if(tf == null) return ;
			var textFormat : TextFormat = tf.getTextFormat();
			var size:int = Math.max(maxSize, 8) ;			
			textFormat.size = size;			
			tf.setTextFormat(textFormat);
	
			while((tf.maxScrollV > 1 || tf.maxScrollH > 1) && size > 8) {
				size--;
				textFormat.size = size;	
				tf.setTextFormat(textFormat);
			}
		}
		
		static public function navigateToURLAndRecord(url:String, window:String = null):void {
			navigateToURL(new URLRequest(url), window);
		}
		
		static public function lerp(start:Number, end:Number, prct:Number):Number {
			var diff:Number = end - start;
			return Math.min(end, Math.max(start, start + prct*diff));
		}	
		
		static public function pickRandomInInt(array:Array):int {
			return array[Math.floor(Math.random()*array.length)];
		}
		
		static public function pickRandomInString(array:Array):String {
			return array[Math.floor(Math.random()*array.length)];
		}
		
		static public function getSquaredDistance(x1:Number,y1:Number,x2:Number,y2:Number):Number {
			var dx:Number = x1-x2;
			var dy:Number = y1-y2;
			return (dx*dx)+(dy*dy);
		}
		
		static public function myIsInstanceOfClass(obj:Object, theClass:Class):Boolean {
			return (obj as theClass);
		}
		
		static public function myIsInstanceOfClassDisplayObject(d:DisplayObject, theClass:Class):Boolean {
			return (d as theClass);
		}
		
		static public function myIsInstanceOfClassDisplayObjectList(d:DisplayObject, classList:Array):Boolean {
			for (var i : int = 0; i < classList.length; i++) {
				var theClass:Class = classList[i];
				if(myIsInstanceOfClassDisplayObject(d, theClass)) return true;
			}
			return false;
		}
		
		static public function minMax(n:Number, min:Number, max:Number):Number {
			return (Math.max(Math.min(max, n), min));
		}
		
		
		static public function parseDateYYYYMMDDHHMMSS(dateString:String):Date {
		    if ( dateString == null ) {
		        return null;
		    }
		
		    var year:int = int(dateString.substr(0,4));
		    var month:int = int(dateString.substr(5,2))-1;
		    var day:int = int(dateString.substr(8,2));
		
		    if ( year == 0 && month == 0 && day == 0 ) {
		        return null;
		    }
		
		    if ( dateString.length == 10 ) {
		        return new Date(year, month, day);
		    }
		
		    var hour:int = int(dateString.substr(11,2));
		    var minute:int = int(dateString.substr(14,2));
		    var second:int = int(dateString.substr(17,2));
		
		    return new Date(year, month, day, hour, minute, second);
		}

		public static function removeTextNewLine(pCmd : String) : String {
			pCmd = pCmd.split("\r").join("");
			pCmd = pCmd.split("\n").join("");
			return pCmd;
		}
		
		
	}
}
