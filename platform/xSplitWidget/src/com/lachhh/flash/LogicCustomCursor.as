package com.lachhh.flash {
	import com.lachhh.draw.CopypixelableBmpData;
	import com.lachhh.draw.DrawUtils;
	import com.lachhh.lachhhengine.animation.AnimationManager;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;

	/**
	 * @author LachhhSSD
	 */
	public class LogicCustomCursor {
		static public function setCursorDefault():void {
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		static public function setCursor(anim:DisplayObject):void {
			var copy:CopypixelableBmpData = DrawUtils.CreateCopypixelableBmpDataUsingMatrix(anim, new Matrix());
			var bmpData:BitmapData = copy.bmpData;
			var v:Vector.<BitmapData> = new Vector.<BitmapData>();
			v[0] = bmpData;
			if(bmpData.width > 32 || bmpData.height > 32)  {
				throw new Error("need to be 32x32 max");
			}
			var mouseCursorData:MouseCursorData = new MouseCursorData();
			mouseCursorData.data = v;
			mouseCursorData.frameRate = 1;
			mouseCursorData.hotSpot = new Point(-copy.x, -copy.y);
			Mouse.registerCursor("spinningArrow", mouseCursorData );
       		Mouse.cursor = "spinningArrow";
		}

		static public function setCursorFromId(animId:int):void {
			var anim:FlashAnimation = AnimationManager.createAnimation(animId);
			LogicCustomCursor.setCursor(anim);
			AnimationManager.destroy(anim);
		}
		
		static public function setCursorForMinigame():void {
			//setCursor(new FX_CURSOR());
		}
	}
}
