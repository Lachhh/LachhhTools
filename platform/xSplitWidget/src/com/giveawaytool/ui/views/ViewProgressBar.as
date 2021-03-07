package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.EffectBlinking;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewProgressBar extends ViewBase {
		public var prct:Number = 0;
		public function ViewProgressBar(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			completeMc.gotoAndStop(1);
			visualMc.gotoAndStop(1);
		}

		override public function refresh() : void {
			super.refresh();
			//var frame:int = (prct*99)+1;
			//visualMc.gotoAndStop(frame);
			bar.scaleY = Utils.minMax(prct, 0.01, 1);
		}
		
		public function flash():void {
			EffectBlinking.addToActorWithSpecificMc(screen, bar, 60, 0xFFFFFF);
			completeMc.gotoAndPlay(2);
		}
		
		public function setOff():void {
			completeMc.gotoAndStop(1);
		}
		
		public function get bar() : MovieClip { return visual.getChildByName("bar") as MovieClip;}
		public function get completeMc() : MovieClip { return visual.getChildByName("completeMc") as MovieClip;}

	}
}
