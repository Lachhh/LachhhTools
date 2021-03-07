package com.giveawaytool.io {
	/**
	 * @author LachhhSSD
	 */
	public class WidgetCustomAssetManager {
		static public var cache:Vector.<WidgetCustomAsset> = new Vector.<WidgetCustomAsset>();
		static public function getOrCreateCustomWidget(dataPath:String):WidgetCustomAsset {
			var result:WidgetCustomAsset = getCustomAsset(dataPath);
			if(result == null) {
				result = WidgetCustomAsset.createAsset(dataPath);
				cache.push(result);
			}
			return result;
		}
		
		static public function getCustomAsset(dataPath:String):WidgetCustomAsset {
			for (var i : int = 0; i < cache.length; i++) {
				var li:WidgetCustomAsset = cache[i];
				if(li.isEquals(dataPath)) return li;
			}
			return null;
		}

		public static function clearCache() : void {
			cache = new Vector.<WidgetCustomAsset>();
		}
		
	}
}
