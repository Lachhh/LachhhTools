package com.lachhh.flash {
	import com.lachhh.io.Callback;

	import flash.display.MovieClip;

	/**
	 * @author Administrator
	 */
	public interface IPreloader {
		function get callback():Callback;
		function set callback(c:Callback):void;
		function get visual():MovieClip;
		function init():void;
	}
}
