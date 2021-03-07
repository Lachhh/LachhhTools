package com.lachhh.flash.draw {
	
	/**
	 * @author Lachhh
	 */
	public interface IDynamicCopyPixelable extends ICopyPixelable {
		function GetBmpData():CopypixelableBmpData ;
		function DestroyDynamicCache():void ;
		function get cache():CopypixelableBmpDataCache ;
	}
}
