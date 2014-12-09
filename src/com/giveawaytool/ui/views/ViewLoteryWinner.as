package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewLoteryWinner extends ViewBase {
		public var name:String;
		public function ViewLoteryWinner(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			name = "Super Long Name";
			
		}
		
		override public function refresh() : void {
			super.refresh();
			nameTxt.text = name;
		}
		
		public function get nameMcContainer() : MovieClip { return visual.getChildByName("nameMc") as MovieClip;}
		public function get nameMc() : MovieClip { return nameMcContainer.getChildByName("nameMc") as MovieClip;}
		public function get nameTxt() : TextField { return nameMc.getChildByName("nameTxt") as TextField;}
		
	}
}
