package com.lachhh.draw {
	
	/**
	 * @author Lachhh
	 */
	public interface IDynamicCopyPixelable extends ICopyPixelable {
		function GetBmpData():CopypixelableBmpData ;
		function DestroyDynamicCache():void ;
		function get cache():CopypixelableBmpDataCache ;
	}
}
