package com.lachhh.flash.debug  {

	/**
	 * @author Administrator
	 */
	public class DebugManagerTreeChild extends DebugTree {
		private var _class:Class ;
		public function DebugManagerTreeChild(pClass:Class) {
			super();	
			_class = pClass;
			
		}
		
		public function get myClass() : Class{
			return _class;
		} 
	}
}
