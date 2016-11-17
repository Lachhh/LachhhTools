package com {
	/**
	 * @author LachhhSSD
	 */
	public class GoogleSheetData {
		public var rawDataJSON : Object;
		public var values : Array;
		

		public function GoogleSheetData(pRawDataJSON:Object) {
			rawDataJSON = pRawDataJSON;
			if(rawDataJSON) values = rawDataJSON.values as Array;
		}
		
		public function getValue(x:int, y:int):String {
			if(values == null) return "";
			 if (y >= values.length) return "";
            var list:Array = values[y] as Array;
			if(list == null) return "";
            if (x >= list.length) return "";
            return list[x];
		}
	}
}
