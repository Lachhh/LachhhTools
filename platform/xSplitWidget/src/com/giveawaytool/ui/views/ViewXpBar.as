package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewXpBar extends ViewBase {
		public var crnt:Number = 0;
		public var target:Number = 100;
		public function ViewXpBar(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			xpBoostMc.gotoAndStop(1);
			startLevelXp.gotoAndStop(1);
			xpBar.gotoAndStop(1);
		}
		
		
		override public function refresh() : void {
			super.refresh();
			
			var prct:Number = (crnt/target);
			var frame:int = Math.floor(prct*100);
			startLevelXp.gotoAndStop(frame);
			xpTxt.text = crnt +"/" + target;
		}
		
		public function showFull(b:Boolean):void {
			visualMc.gotoAndStop(b ? visualMc.totalFrames : 1);
		}
		
		public function get xpBar() : MovieClip { return visual.getChildByName("xpBar") as MovieClip;}
		public function get xpTxt() : TextField { return visual.getChildByName("xpTxt") as TextField;}
			
		public function get startLevelXp() : MovieClip { return xpBar.getChildByName("startLevelXp") as MovieClip;}
		public function get xpBoostMc() : MovieClip { return xpBar.getChildByName("xpBoostMc") as MovieClip;}
		
	}
}
