package com.lachhh.lachhhengine.meta {
	/**
	 * @author LachhhSSD
	 */
	public class ModelBase {
		public var id : int ;

		public function ModelBase(pId:int) {
			id = pId;
		}
		
		public function get isNull():Boolean {
			return id == -1; 
		}
	}
}
