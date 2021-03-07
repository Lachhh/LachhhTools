package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewScrollText extends ViewBase {
		public var msg : String = "Not Connected";
		public var speed : Number = 0.5;
		public var viewWidth:int = 260;
		
		public function ViewScrollText(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			icons.gotoAndStop(1);
		}
		
		
		override public function refresh() : void {
			super.refresh();
			if(msg == null) msg = "";
			txt.text = msg;
			txt2.text = msg;
			scrollMc.x = 0;
		}
		
		
		override public function update() : void {
			super.update();
			if(txt.textWidth < viewWidth) {
				scrollMc2.x = scrollMc.x + txt.textWidth+50;
				scrollMc2.visible = false;	
				return ;
			}
			scrollMc2.visible = true;
			scrollMc.x -= speed;
			if(scrollMc2.x < 0) {
				scrollMc.x += txt.textWidth+50;
			}
			scrollMc2.x = scrollMc.x + txt.textWidth+50;	
		}
		
		public function get icons() : MovieClip { return visual.getChildByName("icons") as MovieClip;}
		public function get scrollMc() : MovieClip { return visual.getChildByName("scrollMc") as MovieClip;}
		public function get txt() : TextField { return scrollMc.getChildByName("txt") as TextField;}
		public function get scrollMc2() : MovieClip { return visual.getChildByName("scrollMc2") as MovieClip;}
		public function get txt2() : TextField { return scrollMc2.getChildByName("txt") as TextField;}
	}
}
