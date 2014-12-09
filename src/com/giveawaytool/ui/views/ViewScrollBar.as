package com.giveawaytool.ui.views {
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	/**
	 * @author LachhhSSD
	 */
	public class ViewScrollBar extends ViewBase {
		public var scrollbarWidth:Number = 1280;
		public var contentWidth:Number = 8000;
		public var viewWidth:Number = 1280;
		public var minTrackWidth:Number = 100;
		private var positionPrct:Number = 0;
		public var callbackOnChange:Callback;
		
		
		private var isEditing:Boolean ;
		
		
		public function ViewScrollBar(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			pScreen.registerClick(scrollTrack, onClickScroll);
			pScreen.registerClick(scrollBack, onClickBack);
			
			positionPrct = 0;
			scrollbarWidth = scrollBack.width;
			viewWidth = scrollBack.width;
		}

		private function onClickBack() : void {
			if(visual.mouseX < scrollTrack.x) setPrct(positionPrct-0.1);
			if(visual.mouseX > scrollTrack.x+scrollTrack.width) setPrct(positionPrct+0.1); 
			refresh();
		}

		private function onClickScroll() : void {
			scrollTrack.startDrag(false, new Rectangle(0, 0, scrollWidthMinusTrackWidth(), 0));
			isEditing = true;
		}
		
		override public function refresh() : void {
			super.refresh();
			if(isViewLargerThanScroll()) {
				visual.visible = false;
				positionPrct = 0;
			} else {
				visual.visible = true;
				refreshWidth();
				refreshPosition();
			}
		}
		
		private function refreshWidth():void {
			scrollTrack.width = scrollTrackWidth();
		}
		
		private function refreshPosition():void {
			var x:int = scrollWidthMinusTrackWidth()*positionPrct;
			scrollTrack.x = x;
		}
		
		
		override public function update() : void {
			super.update();
			if(isEditing) {
				if(!KeyManager.IsMouseDown()) {
					isEditing = false;
					scrollTrack.stopDrag();
				}
				setPrctFromX(scrollTrack.x);
				refresh();
			}
		}
		
		public function getPrctPostion():Number {
			return positionPrct;
		}
		
		protected function setPrctFromX(x:int):void {
			setPrct(x/scrollWidthMinusTrackWidth());
		}
		
		public function setPrct(prct:Number):void {
			if(prct == positionPrct) return ;
			positionPrct = Utils.minMax(prct, 0, 1);
			if(callbackOnChange) callbackOnChange.call();
		}
		
		
		public function scrollTrackWidth():Number {
			var widthOfScrollBar:Number = getPrctView()*scrollbarWidth;
			if(widthOfScrollBar < minTrackWidth) widthOfScrollBar = minTrackWidth;
			return widthOfScrollBar;
		}
		
		public function scrollWidthMinusTrackWidth():Number {
			return scrollbarWidth-scrollTrackWidth();
		}
		
		public function isViewLargerThanScroll():Boolean {
			return (viewWidth > contentWidth);
		}
		
		public function getPrctView():Number {
			return (viewWidth / contentWidth);
		}
				
		public function get scrollTrack() : MovieClip { return visual.getChildByName("scrollTrack") as MovieClip;}
		public function get scrollBack() : MovieClip { return visual.getChildByName("scrollBack") as MovieClip;}
	}
}
