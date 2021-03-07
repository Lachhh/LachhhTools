package com.lachhh.flash.draw {

	/**
	 * @author Lachhh
	 */
	public class CopypixelableBmpDataCache {
		private var _cache:Array ;
		private var _cacheById:Array ;

		public function CopypixelableBmpDataCache() {
			_cache = new Array();
			_cacheById = new Array();
		}
		
		public function Destroy():void {
			while(_cache.length > 0) {
				var animPartBmpData:CopypixelableBmpData = _cache.shift();
				animPartBmpData.Destroy();
			}	
			_cache = null;
			_cacheById = null;
		}
		
		public function GetBmpData(copyPixelable:ICopyPixelable):CopypixelableBmpData {
			var animPartBmpData:CopypixelableBmpData = GetInCache(copyPixelable);
			if(animPartBmpData == null) {
				animPartBmpData = copyPixelable.CreateCopypixelableBmpData();
				if(animPartBmpData != null) {
					_cacheById[copyPixelable.GetTransformId()] = animPartBmpData;
					_cache.push(animPartBmpData);
				}
			}
			return animPartBmpData;
		}

		private function GetInCache(copyPixelable:ICopyPixelable):CopypixelableBmpData {
			return _cacheById[copyPixelable.GetTransformId()];
		}

		public function get numBmpData():int {
			return _cache.length;
		}
	}
}
