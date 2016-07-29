package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.meta.donations.MetaData;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewGenericList extends ViewBase {
		static public var EMPTY_ARRAY:Array = [];
		private var metaDataList:Array = EMPTY_ARRAY;
		public var views:Array = new Array();
		public var viewScrollBar:ViewScrollBar;
		
		
		public function ViewGenericList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			viewScrollBar = new ViewScrollBar(pScreen, scrollbarMc);
			viewScrollBar.callbackOnChange = new Callback(refreshScollBar, this, null);
			pScreen.registerClick(cancelBtn, onCancel);
			cancelBtn.visible = false;
			loadingMc.visible = false;
		}

		protected function onCancel() : void {
			
		}
		
		public function clear():void {
			metaDataList = EMPTY_ARRAY;
			refresh();
		}
        
		private function destroyAllChildren():void {
			while(views.length > 0) {
				var view:ViewBase = views.shift();
				view.destroy();	
			}
		}
		
		public function createViews():void {
			destroyAllChildren();
			
			//metaDataList.sort();
			for (var i : int = 0; i < metaDataList.length; i++) {
				var metaDonation:MetaData = metaDataList[i];
				var newView:ViewBase = createChildView();
				newView.metaData = metaDonation;
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*17;
				screen.registerClickWithCallback(newView.visual, new Callback(onClickView, this, [newView]));
				views.push(newView);
			}	
		}
		
		public function createChildView():ViewBase {
			throw new Error("TO OVERRIDE");
		}
		
		public function onClickView(v:ViewBase):void {
			
		}
		
		protected function removeView(v:ViewBase) : void {
			var index:int = views.indexOf(v);
			if(index == -1) return ;
			
			metaDataList.splice(index, 1);
			views.splice(index, 1);
			v.destroy();
			
			quickRefresh();
		}
		
		public function quickRefresh():void {
			for (var i : int = 0; i < metaDataList.length; i++) {
				var metaDonation:MetaData = metaDataList[i];
				var newView:ViewBase = views[i] as ViewBase;
				newView.metaData = metaDonation;
				
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*17;
			}
			refreshScollBar();
			refreshTotal();
		}
		
		public function refreshTotal():void {
			totalTxt.text = "Total : " + metaDataList.length;
		}
		
		override public function refresh() : void {
			super.refresh();
			createViews();
			refreshScollBar();
			refreshTotal();
			emptyTxt.visible = (metaDataList.length <= 0) && !isLoading();
			flash();
		}
		
		public function flash():void {
			for (var i : int = 0; i < views.length; i++) {
				var newView:ViewBase = views[i];
				CallbackWaitEffect.addWaitCallbackToActor(actor, new Callback(flashOne, this, [newView]), i*2);
				if(i > 20) return;
			}
		}
		
		private function flashOne(v:ViewBase):void {
			EffectFadeOut.addToActorWithSpecificMc(actor, v.visual, 15, 0xFFFFFF).prct = 0.25;
			//EffectKickBackUI.addToActor(actor, v.visual, -5, 0);
		}
		
		public function setData(pData:Array):void {
			metaDataList = pData;
		}
		
		public function showLoading(b:Boolean):void {
			loadingMc.visible = b;
			contentMc.visible = !b;
		}
        
        public function isLoading():Boolean {
			return (loadingMc.visible);
		}
		
		private function refreshScollBar():void {
			viewScrollBar.contentWidth = contentMc.height;
			contentMc.y = -(contentMc.height-viewScrollBar.viewWidth+10)*viewScrollBar.getPrctPostion();
			viewScrollBar.refresh();
		}
		
		public function getData():Array {
			return metaDataList;
		}

		
		public function get scrollbarMc() : MovieClip { return visual.getChildByName("scrollbarMc") as MovieClip;};
		public function get loadingMc() : MovieClip { return visual.getChildByName("loadingMc") as MovieClip;}
		public function get contentMc() : MovieClip { return visual.getChildByName("contentMc") as MovieClip;}
		public function get titleTxt() : TextField { return visual.getChildByName("titleTxt") as TextField;}
		public function get emptyTxt() : TextField { return visual.getChildByName("emptyTxt") as TextField;}
		public function get totalTxt() : TextField { return visual.getChildByName("totalTxt") as TextField;}
		
		public function get cancelBtn() : MovieClip { return loadingMc.getChildByName("cancelBtn") as MovieClip;}
		
	}
}
