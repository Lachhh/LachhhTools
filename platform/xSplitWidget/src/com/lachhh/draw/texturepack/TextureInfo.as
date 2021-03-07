/**
 * Created with IntelliJ IDEA.
 * User: BerzerkJoe
 * Date: 12/04/13
 * Time: 11:44 AM
 * To change this template use File | Settings | File Templates.
 */
package com.lachhh.draw.texturepack {
import flash.display.BitmapData;
import flash.geom.Rectangle;

public class TextureInfo {
	private var _name:String;
	private var _bitmap:BitmapData;
	private var _bounds:Rectangle;
	private var _blend:Boolean;

	public function TextureInfo() {

	}

	public function get bitmap():BitmapData {
		return _bitmap;
	}

	public function set bitmap(value:BitmapData):void {
		_bitmap = value;
	}

	public function get bounds():Rectangle {
		return _bounds;
	}

	public function set bounds(value:Rectangle):void {
		_bounds = value;
	}

	public function get name():String {
		return _name;
	}

	public function set name(value:String):void {
		_name = value;
	}

	public function get blend():Boolean {
		return _blend;
	}

	public function set blend(value:Boolean):void {
		_blend = value;
	}
}
}
