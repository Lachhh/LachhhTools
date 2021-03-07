package com.lachhh.draw {

	/**
	 * @author Lachhh
	 */
	public class CopypixelableBmpDataFactory {
		static private var _instance:CopypixelableBmpDataFactory ;
		
		private var _dynamicCopyPixelableCache:Array ;
		private var _cache:Array ;
		private var _cacheById:Array ;
		
		public function CopypixelableBmpDataFactory() {
			_dynamicCopyPixelableCache = new Array();
			_cache = new Array();
			_cacheById = new Array();
		}
		
		public function Destroy():void {
			var copypixelCache:CopypixelableBmpDataCache;
			var dynamicCopypixelable:IDynamicCopyPixelable;
			while(_cache.length > 0) {
				copypixelCache = _cache.shift();
				copypixelCache.Destroy();
			}	
			
			while(_dynamicCopyPixelableCache.length > 0) {
				dynamicCopypixelable = _dynamicCopyPixelableCache.shift();
				dynamicCopypixelable.DestroyDynamicCache();
			}	
			
			_cacheById = new Array();
		}
		
		public function GetBmpData(copyPixelable:IStaticCopyPixelable):CopypixelableBmpData {
			var index:int = copyPixelable.GetClassId();
			var copyPixelableBmpData:CopypixelableBmpDataCache ;
			if(_cacheById[index] == null) {
				var animData:CopypixelableBmpDataCache = new CopypixelableBmpDataCache();
				_cacheById[index] = animData;
				_cache.push(animData);
			}
			copyPixelableBmpData = _cacheById[index] ;
			return copyPixelableBmpData.GetBmpData(copyPixelable);
		}
		
		public function RegisterDynamicCopypixelable(dynamicCopypixalable:IDynamicCopyPixelable):void {
			_dynamicCopyPixelableCache.push(dynamicCopypixalable);
		}
		
		public function get nbBmpDataTotal():int {
			return nbBmpDataStatic + nbBmpDataDynamic;
		}
		
		public function get nbBmpDataStatic():int {
			var cpt:int = 0;
			var i:int ;
			var a:CopypixelableBmpDataCache; 
			for (i = 0 ; i < _cache.length ; i++) {
				a = _cache[i];
				cpt += a.numBmpData;
			}
			
			return cpt;
		}
		
		public function get nbBmpDataDynamic():int {
			var cpt:int = 0;
			var i:int ;
			var d:IDynamicCopyPixelable; 
			for (i = 0 ; i < _dynamicCopyPixelableCache.length ; i++) {
				d = _dynamicCopyPixelableCache[i];
				cpt += d.cache.numBmpData;
			}
			
			return cpt;
		}
		
		static public function get instance():CopypixelableBmpDataFactory {
			if(_instance == null) {
				_instance = new CopypixelableBmpDataFactory();	
			}
			return _instance;
		}
	}
}
