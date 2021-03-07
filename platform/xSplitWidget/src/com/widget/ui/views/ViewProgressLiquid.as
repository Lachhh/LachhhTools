package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewProgressLiquid extends ViewBase {
		public var prct : Number = 0;
		public var height:int = 183;
		public var isMoving:Boolean = false;
		

		public function ViewProgressLiquid(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			visualMc.gotoAndStop(1);
		}

		override public function refresh() : void {
			super.refresh();
			visualMc.y = (height*prct)*-1;
			visualMc.gotoAndStop(isMoving ? 2 : 1);
		}
		
		
		
		public function get bar() : MovieClip { return visual.getChildByName("bar") as MovieClip;}
	}
}
