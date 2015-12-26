package com.lachhh.lachhhengine.meta {
	/**
	 * @author LachhhSSD
	 */
	public class ModelBaseStr {
		public var id : String ;

		public function ModelBaseStr(pId:String) {
			id = pId;
		}
		
		public function get isNull():Boolean {
			return id == ""; 
		}
	}
}
