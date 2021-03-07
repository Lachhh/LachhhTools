package com.lachhh.flash.draw {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	/**
	 * @author Lachhh
	 */
	public class CopyPixelableBitmap extends Bitmap implements IDynamicCopyPixelable {
		private var _cache:CopypixelableBmpDataCache ;
		private var _identityBmpData: CopypixelableBmpData;
		public function CopyPixelableBitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false) {
			super(bitmapData, pixelSnapping, smoothing);
			_cache = new CopypixelableBmpDataCache();
			CopypixelableBmpDataFactory.instance.RegisterDynamicCopypixelable(this);
			_identityBmpData = new CopypixelableBmpData();
			_identityBmpData.bmpData = bitmapData;
			_identityBmpData.x = 0 ;
			_identityBmpData.y = 0 ;  
		}

		public function GetTransformId():String {
			var str:String = transform.concatenatedMatrix.a + "~" + 
				transform.concatenatedMatrix.b + "~" +
				transform.concatenatedMatrix.c + "~" +
				transform.concatenatedMatrix.d ;
			return str;
		}
				
		
		public function GetBmpData():CopypixelableBmpData {
			if(bitmapData == null) return null;
			if(isIdentity) {
				_identityBmpData.bmpData = bitmapData;
				return _identityBmpData;
			} else {
				return _cache.GetBmpData(this);
			}	
		}
		
		public function CreateCopypixelableBmpData():CopypixelableBmpData {
			return DrawUtils.CreateCopypixelableBmpData(this);
		}
				
		public function get displayObject():DisplayObject {
			return this;
		}
		
		public function DestroyDynamicCache():void {
			_cache.Destroy();
			_identityBmpData.bmpData = null;
			_identityBmpData = null;
		}
		
		public function get cache():CopypixelableBmpDataCache {
			return _cache;
		}
		
		private function get isIdentity():Boolean {
			return (transform.concatenatedMatrix.a == 1 && 
				transform.concatenatedMatrix.b == 0 &&
				transform.concatenatedMatrix.c == 0 &&
				transform.concatenatedMatrix.d == 1);
		}
	}
}
