package com.lachhh.lachhhengine.animation {
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.utils.Utils;

	/**
	 * @author Lachhh
	 */
	public class FlashAnimationCache {
		private var _cache:Array;
		private var _activeCacheId:Array;
		public function FlashAnimationCache() {
			_cache = new Array();
			_activeCacheId = new Array();
		}
		
		public function GetFactoryObject(instanceType:int):FlashAnimation {
			var gameElement:FlashAnimation  ;
			var elementsInPool:Array = _cache[instanceType];
			if(elementsInPool != null && elementsInPool.length > 0) {
				gameElement = (elementsInPool.shift() as FlashAnimation);
			} else {
				gameElement = AnimationFactory.createAnimationInstance(instanceType);
				gameElement.idInCache = instanceType;
			}
			
			return gameElement;
		} 
		
		public function AddToCache(gameElement:FlashAnimation):void {
			var instanceType:int = gameElement.idInCache;
			var elementsInPool:Array = _cache[instanceType];
			if(elementsInPool == null) {
				_cache[instanceType] = new Array();
				elementsInPool = _cache[instanceType];
			}
			
			elementsInPool.push(gameElement);
			Utils.AddInArrayIfNotIn(_activeCacheId, instanceType) ;
		}
		
		public function GetNbInCacheById(id:int):int {
			var elementsInPool:Array = _cache[id];
			if(elementsInPool == null) {
				return 0;
			}
			return elementsInPool.length;
		}
		
		public function ClearCache():void {
			for (var i:int = 0 ; i < _activeCacheId.length ; i++) {
				Utils.ClearArray(_cache[i]);
			}
			Utils.ClearArray(_cache);
			Utils.ClearArray(_activeCacheId);
		}
		
		public function GetNbInCache():int {
			var cpt:int = 0 ;
			for (var i:int = 0 ; i < _activeCacheId.length ; i++) {
				cpt += GetNbInCacheById(_activeCacheId[i]);
			}
			return cpt;
		}
	}
}
