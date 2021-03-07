package com.lachhh.draw {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author Lachhh
	 */
	public class DrawUtils {
		static private var _pTemp:Point = new Point();
		static private var _p1:Point = new Point();
		static private var _p2:Point = new Point();
		static private var _p3:Point = new Point();
		static private var _p4:Point = new Point();
		static private var _rect:Rectangle = new Rectangle();
		static private var _matrix:Matrix = new Matrix();
		
		static public function CreateCopypixelableBmpDataUsingMatrix(d:DisplayObject, matrix:Matrix):CopypixelableBmpData {
			var animPartBmpData:CopypixelableBmpData = new CopypixelableBmpData();
			var rect:Rectangle = GetRectangleOfAnimPart(d, matrix);
			try {
				var bd:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			} catch(e:Error) {
				return null;	
			} 
			
			animPartBmpData.x = rect.x;
			animPartBmpData.y = rect.y;
			
			//_matrix.invert();
			
			
			_matrix.tx = -rect.x;
			_matrix.ty = -rect.y;
			
			bd.draw(d, _matrix, d.transform.concatenatedColorTransform);
			
			animPartBmpData.bmpData = bd;
			return animPartBmpData;
		}
		
		static public function CreateCopypixelableBmpData(d:DisplayObject, useConcatenedMatrix:Boolean = true):CopypixelableBmpData {
			var animPartBmpData:CopypixelableBmpData = new CopypixelableBmpData();
			var rect:Rectangle ;
			if(useConcatenedMatrix) {
				rect = GetRectangleOfAnimPart(d, d.transform.concatenatedMatrix);
			} else {
				rect = GetRectangleOfAnimPart(d, d.transform.matrix);
			}
			try {
				var bd:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			} catch(e:Error) {
				return null;	
			} 
			
			animPartBmpData.x = rect.x;
			animPartBmpData.y = rect.y;
			
			//_matrix.invert();
			/*_matrix.a = d.transform.concatenatedMatrix.a;
			_matrix.b = d.transform.concatenatedMatrix.b;
			_matrix.c = d.transform.concatenatedMatrix.c;
			_matrix.d = d.transform.concatenatedMatrix.d;*/
			_matrix.tx = -rect.x;
			_matrix.ty = -rect.y;
			
			bd.draw(d, _matrix, d.transform.concatenatedColorTransform);
			
			animPartBmpData.bmpData = bd;
			return animPartBmpData;
		}

		static public function GetRectangleOfAnimPart(d:DisplayObject, matrix:Matrix):Rectangle {
			var maxX:Number ;
			var maxY:Number ;
			var bounds:Rectangle = d.getBounds(d.parent);
			bounds.x -= d.x;
			bounds.y -= d.y;
			_p1.x = bounds.left;
			_p1.y = bounds.top;
			_p2.x = bounds.right;
			_p2.y = bounds.top;
			_p3.x = bounds.left;
			_p3.y = bounds.bottom;
			_p4.x = bounds.right;
			_p4.y = bounds.bottom;
			
			/*_p1.x = d.width;
			_p1.y = 0;
			_p2.x = d.width;
			_p2.y = d.height;
			_p3.x = 0;
			_p3.y = d.height;*/
			_matrix.a = matrix.a;
			_matrix.b = matrix.b;
			_matrix.c = matrix.c;
			_matrix.d = matrix.d;

			_matrix.tx = 0 ;
			_matrix.ty = 0 ;
			//_matrix.concat(layerInvert);
			//_matrix.invert();
			TransformPoint(_p1, _matrix);
			TransformPoint(_p2, _matrix);
			TransformPoint(_p3, _matrix);
			TransformPoint(_p4, _matrix);
			
			_rect.x = Math.min(Math.min(Math.min(Math.min(_p1.x, _p2.x), _p3.x), _p4.x), 0);
			_rect.y = Math.min(Math.min(Math.min(Math.min(_p1.y, _p2.y), _p3.y), _p4.y), 0);
			maxX = Math.max(Math.max(Math.max(Math.max(_p1.x, _p2.x), _p3.x), _p4.x), 1);
			maxY = Math.max(Math.max(Math.max(Math.max(_p1.y, _p2.y), _p3.y), _p4.y), 1);
			
			_rect.width = (maxX - _rect.x);
			_rect.height = (maxY - _rect.y); 
			return _rect;
		}

		static private function TransformPoint(p:Point, m:Matrix):void {
			_pTemp.x = p.x;
			_pTemp.y = p.y;
			p.x = (m.a*_pTemp.x)+(m.c*_pTemp.y);
			p.y = (m.b*_pTemp.x)+(m.d*_pTemp.y);
		}
	}
}
