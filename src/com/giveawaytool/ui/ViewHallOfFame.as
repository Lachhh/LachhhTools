package com.giveawaytool.ui {
	import com.giveawaytool.io.playerio.MetaGameWispSubGroup;
	import com.giveawaytool.io.playerio.MetaGameWispSub;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewScrollBar;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author Jack
	 */
	public class ViewHallOfFame extends ViewBase 
	{
		static private const DIST_BETWEEN_VIEW:int = 28;
		public var numPerPage:int = 100;
		private var totalPages:int = 1;
		private var crntPage:int = 1;
		
		public var viewScrollBar : ViewScrollBar;
		public var views : Vector.<ViewGameWispSub> = new Vector.<ViewGameWispSub>();
		public var metaTotal:Vector.<MetaGameWispSub> = new Vector.<MetaGameWispSub>();
		public var metaCurrentPage:Vector.<MetaGameWispSub> = new Vector.<MetaGameWispSub>();
		public var metaManual:Vector.<MetaGameWispSub> = new Vector.<MetaGameWispSub>();
		
		public function ViewHallOfFame(pScreen : UIBase, pVisual : DisplayObject) 
		{
			super(pScreen, pVisual);
			viewScrollBar = new ViewScrollBar(pScreen, scrollbarMc);
			viewScrollBar.callbackOnChange = new Callback(refreshScollBar, this, null);
			viewScrollBar.viewWidth -= 20;
			
			pScreen.registerClick(cancelBtn, onCancel);
			crntPageTxt.addEventListener(FocusEvent.FOCUS_OUT, onEditPage);
			pScreen.registerClick(prevBtn, onPrev);
			pScreen.registerClick(nextBtn, onNext);
			crntPage = 1;
			totalPages = 1;
			
			loadingMc.visible = false;
			emptyMc.visible = false;
			
			refresh();
			refreshScollBar();
		}
		
		public function isOnLastPage():Boolean {
			return (crntPage >= totalPages);
		}
		
		public function isOnFirstPage():Boolean {
			return (crntPage <= 1);
		}
		
		override public function refresh() : void {
			super.refresh();
			refreshScollBar();
			refreshPagesIndexes();
			
			metaManual = new Vector.<MetaGameWispSub>();
			//metaManual = MetaGameProgress.instance.metaManualRewardList.addManualPatrons(metaManual);
			metaManual = MetaGameProgress.instance.metaLachhhToolGameWispSub.listOfSub;
			metaTotal = MetaGameProgress.instance.metaLachhhToolGameWispSub.listOfSub;
			addIfNotInList(metaTotal, metaManual);
			//metaTotal = metaTotal.concat(metaManual);
			MetaGameWispSubGroup.sortNext(metaTotal);
			
			crntPageTxt.text = crntPage + "";
			totalPagesTxt.text = "/ " + totalPages;
			totalTxt.text = "Total: " + metaTotal.length ; 
			prevBtn.selectIfBoolean(isOnFirstPage());
			nextBtn.selectIfBoolean(isOnLastPage());
			
			//MetaGameProgress.instance.metaPatreonContributorGroup.sortNext();
			
			var startSlice:int = (crntPage-1)*numPerPage;
			var endSlice:int = (crntPage)*numPerPage;
			
			
			
			
			metaCurrentPage = metaTotal.slice(startSlice, endSlice);
			
		
			//pageMc.visible = (totalPages > 1);
			
			createViews();
		}
		
		private function addIfNotInList(result:Vector.<MetaGameWispSub>, src:Vector.<MetaGameWispSub>):void {
			for (var i : int = 0; i < src.length; i++) {
				var m:MetaGameWispSub = src[i];
				addIfNotIn(result, m);
			}
		}
		
		private function addIfNotIn(result:Vector.<MetaGameWispSub>, metaUser:MetaGameWispSub):void {
			for (var i : int = 0; i < result.length; i++) {
				var m:MetaGameWispSub = result[i];
				if(metaUser.name.toLowerCase() == m.name.toLowerCase()) return;
				
			}
			result.push(metaUser);
		}
		
		public function createViews():void {
			destroyAllChildren();
			for (var i : int = 0; i < metaCurrentPage.length; i++) {
				var newView:ViewGameWispSub = createViewPatreonContributor(metaCurrentPage[i]);
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*DIST_BETWEEN_VIEW;
				newView.backMc.visible = ((i%2)==1);
				views.push(newView);
			}	
		}
		
		private function createViewPatreonContributor(meta:MetaGameWispSub):ViewGameWispSub {
			var result:ViewGameWispSub = new ViewGameWispSub(screen, contentMc);
			result.metaGamewispSub = meta;
			result.refresh();
			return result; 
		}
		
		private function refreshPagesIndexes():void {
			totalPages = Math.ceil(metaTotal.length / numPerPage);
			if(crntPage > totalPages) crntPage = totalPages;
			if(crntPage < 1) crntPage = 1;
			if(totalPages < 1) totalPages = 1;
		}
		
		private function destroyAllChildren():void {
			while(views.length > 0) {
				var view:ViewBase = views.shift();
				view.destroy();
			}
		}
		
		private function refreshScollBar():void {
			viewScrollBar.contentWidth = contentMc.height;
			contentMc.y = -(contentMc.height-viewScrollBar.viewWidth)*viewScrollBar.getPrctPostion();
			viewScrollBar.refresh();
		}
		
		private function onCancel() : void {
			//Might wanna add feedback saying list could not load
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
		
		private function onPrev() : void {
			if(isOnFirstPage()) return ;
			crntPage--;
			viewScrollBar.setPrct(0);
			refresh();
		}
		
		private function onNext() : void {
			if(isOnLastPage()) return ;
			crntPage++;
			viewScrollBar.setPrct(0);
			refresh();
		}
		
		
		
		public function get hallOfFameListMc() : MovieClip { return visual.getChildByName("hallOfFameListMc") as MovieClip;}
		public function get totalTxt() : TextField { return visual.getChildByName("totalTxt") as TextField;}
		public function get contentMc() : MovieClip { return hallOfFameListMc.getChildByName("contentMc") as MovieClip;}
		public function get scrollbarMc() : MovieClip { return hallOfFameListMc.getChildByName("scrollbarMc") as MovieClip;}
		public function get loadingMc() : MovieClip { return hallOfFameListMc.getChildByName("loadingMc") as MovieClip;}
		public function get cancelBtn() : ButtonSelect { return loadingMc.getChildByName("cancelBtn") as ButtonSelect;}
		public function get emptyMc() : MovieClip { return hallOfFameListMc.getChildByName("emptyMc") as MovieClip;}
		
		public function get pageMc() : MovieClip { return visual.getChildByName("pageMc") as MovieClip;}
		public function get crntPageTxt() : TextField { return pageMc.getChildByName("crntTxt") as TextField;}
		public function get totalPagesTxt() : TextField { return pageMc.getChildByName("totalTxt") as TextField;}
		public function get prevBtn() : ButtonSelect { return pageMc.getChildByName("prevBtn") as ButtonSelect;}
		public function get nextBtn() : ButtonSelect { return pageMc.getChildByName("nextBtn") as ButtonSelect;}
	}
}