package com.giveawaytool.ui {
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import com.lachhh.utils.Utils;
	import flash.display.Bitmap;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewAvatarLogo extends ViewBase {
		public var bmp:Bitmap;
		public var bmpData:BitmapData;
		public var rect:Rectangle = new Rectangle(0,0,45,45);
		public function ViewAvatarLogo(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			bmp = new Bitmap();
			contentMc.addChild(bmp);
		}

		override public function destroy() : void {
			super.destroy();
			Utils.LazyRemoveFromParent(bmp);
		}

		override public function refresh() : void {
			super.refresh();
			bmp.bitmapData = bmpData;
			bmp.x = rect.x;
			bmp.y = rect.y;
			bmp.width = rect.width;
			bmp.height = rect.height;
		}

		public function get avatarMc() : MovieClip {return visual.getChildByName("avatarMc") as MovieClip;}
		public function get contentMc() : MovieClip { return avatarMc.getChildByName("contentMc") as MovieClip;}
	}
}
