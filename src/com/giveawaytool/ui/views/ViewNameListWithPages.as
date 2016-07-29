package com.giveawaytool.ui.views {
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewNameListWithPages extends ViewNameList {
		public var numPerPage:int = 250;
		private var totalPages:int = 1;
		private var crntPage:int = 1;
		private var namesTotal : Array = EMPTY_ARRAY;
		
		
		public function ViewNameListWithPages(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			
			crntPageTxt.addEventListener(FocusEvent.FOCUS_OUT, onEditPage);
			pScreen.registerClick(prevBtn, onPrev);
			pScreen.registerClick(nextBtn, onNext);
			crntPage = 1;
			totalPages = 1;
		}
		
		private function onNext() : void {
			if(isOnLastPage()) return ;
			crntPage++;
			refresh();
		}

		private function onPrev() : void {
			if(isOnFirstPage()) return ;
			crntPage--;
			refresh();
		}

		override public function setNames(newNames : Array) : void {
			namesTotal = newNames;
			cleanNames();
		}
		
		private function cleanNames():void {
			for (var i : int = 0; i < namesTotal.length; i++) {
				var name:String = namesTotal[i];
				if(name == "" || name == null) {
					namesTotal.splice(i, 1);
					 i--;
				}
			}
		}
		
		private function onEditPage(event : FocusEvent) : void {
			var index:int = FlashUtils.myParseFloat(crntPageTxt.text);
			if(isNaN(index)) {
				refresh();
				return ;
			}
			crntPage = index;
			refresh();
		}
		
		
		
		override public function refresh() : void {
			
			namesTotal.sort();
			refreshPagesIndexes();
			crntPageTxt.text = crntPage + "";
			totalPagesTxt.text = "/ " + totalPages;
			prevBtn.selectIfBoolean(isOnFirstPage());
			nextBtn.selectIfBoolean(isOnLastPage());
			
			var startSlice:int = (crntPage-1)*numPerPage;
			var endSlice:int = (crntPage)*numPerPage;
			var copy:Array = namesTotal.slice(startSlice, endSlice);
			super.setNames(copy);
			viewScrollBar.setPrct(0);
			pageMc.visible = (totalPages > 1);
			super.refresh();
		}

		override protected function removeView(v : ViewName) : void {
			super.removeView(v);
			var i:int = namesTotal.indexOf(v.name);
			if(i != -1) namesTotal.splice(i, 1);
			refreshTotal();
		}
		
		override public function refreshTotal() : void {
			totalTxt.text = "Total : " + namesTotal.length;
		}
		
		private function refreshPagesIndexes():void {
			totalPages = Math.ceil(namesTotal.length / numPerPage);
			if(crntPage > totalPages) crntPage = totalPages;
			if(crntPage < 1) crntPage = 1;
			if(totalPages < 1) totalPages = 1;
		}
		
		public function isOnLastPage():Boolean {
			return (crntPage >= totalPages);
		}
		
		public function isOnFirstPage():Boolean {
			return (crntPage <= 1);
		}

		override public function clear() : void {
			namesTotal = EMPTY_ARRAY;
			super.clear();
			
		}
		
		override public function getNames() : Array {
			return namesTotal;
		}
		
		
		public function get pageMc() : MovieClip { return visual.getChildByName("pageMc") as MovieClip;}
		public function get crntPageTxt() : TextField { return pageMc.getChildByName("crntTxt") as TextField;}
		public function get totalPagesTxt() : TextField { return pageMc.getChildByName("totalTxt") as TextField;}
		public function get prevBtn() : ButtonSelect { return pageMc.getChildByName("prevBtn") as ButtonSelect;}
		public function get nextBtn() : ButtonSelect { return pageMc.getChildByName("nextBtn") as ButtonSelect;}
		
		public function get text1Txt() : TextField { return visual.getChildByName("text1Txt") as TextField;}
		public function get text2Txt() : TextField { return visual.getChildByName("text2Txt") as TextField;}
	}
}
