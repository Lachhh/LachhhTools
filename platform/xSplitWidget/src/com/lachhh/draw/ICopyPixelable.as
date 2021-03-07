package com.lachhh.draw {
	import flash.display.DisplayObject;	
	import flash.display.IBitmapDrawable;		

	/**
	 * @author Lachhh
	 */
	public interface ICopyPixelable extends IBitmapDrawable {
		function GetTransformId():String ;
		function CreateCopypixelableBmpData():CopypixelableBmpData ;
		function get displayObject():DisplayObject
	}
}
