package com.giveawaytool.ui.views {
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author mikeducarmesucks
	 */
	public class ViewOptionSlider extends ViewBase {
		public var prct : Number = 1;
		private var isDragging : Boolean;
		public var callbackOnUpdate:Callback;
		public var callbackOnUpdateFinished:Callback;
		public function ViewOptionSlider(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			refresh();
			screen.registerEvent(visualMc, MouseEvent.MOUSE_DOWN, onClick);
			screen.registerEvent(volumeBtn, MouseEvent.MOUSE_DOWN, onClick);
			
			isDragging = false;
			visualMc.gotoAndStop(1);
		}

		private function onClick() : void {
			isDragging = true;
		}
		
		public function setPrctFromMousePos() : void {
			prct = visual.mouseX/150;
			prct = Utils.minMax(prct, 0, 1);
		}

		override public function refresh() : void {
			super.refresh();
			
			if (isNaN(prct)) return ;
			visualMc.gotoAndStop(Math.floor(prct*visualMc.totalFrames));
			var prctInInt:int = prct*100;
			prctTxt.text = prctInInt + "%";
		}

		override public function update() : void {
			super.update();
			if(isDragging) {
				setPrctFromMousePos();
				if(callbackOnUpdate) callbackOnUpdate.call();
				if(!KeyManager.IsMouseDown()) {
					isDragging = false;
					if(callbackOnUpdateFinished) callbackOnUpdateFinished.call();
				}
			}
		}
		
		public function get volumeBtn() : MovieClip { return visual.getChildByName("volumeBtn") as MovieClip;}
		public function get prctTxt() : TextField { return visual.getChildByName("prctTxt") as TextField;}
	}
}
