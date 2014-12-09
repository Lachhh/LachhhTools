package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.EffectKickBack;
	import com.giveawaytool.effect.EffectScaleBackTo1;
	import com.giveawaytool.effect.LogicDestroyOutsideOfBounds;
	import com.giveawaytool.effect.LogicRotate;
	import com.giveawaytool.effect.ui.EffectShakeUI;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaTwitterAcccountList;
	import com.giveawaytool.meta.MetaTwitterAccount;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.UIEffect;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewTwitterAccountList extends ViewBase {
		
		public var metaAccountList:MetaTwitterAcccountList ;
		public var views:Vector.<ViewTwitterAccount> = new Vector.<ViewTwitterAccount>();
		public var viewScrollBar:ViewScrollBar;
		
		
		public function ViewTwitterAccountList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewScrollBar = new ViewScrollBar(pScreen, scrollbarMc);
			viewScrollBar.callbackOnChange = new Callback(refreshScollBar, this, null);
			
		}

		public function clear():void {
			refresh();
		}
        
        public function setAccount(newAccount:MetaTwitterAcccountList):void {			
            metaAccountList = newAccount;
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
		
		public function createViews():void {
			destroyAllChildren();

			for (var i : int = 0; i < metaAccountList.accounts.length; i++) {
				var metaTwitterAccount:MetaTwitterAccount = metaAccountList.accounts[i];
				var newView:ViewTwitterAccount = new ViewTwitterAccount(screen);
				newView.metaTwitterAccount = metaTwitterAccount;
				newView.metaTwitterAccount.callbackRefresh = new Callback(newView.refresh, newView, null);
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*50;
				screen.registerClickWithCallback(newView.removeBtn, new Callback(removeView, this, [newView]));
				screen.registerClickWithCallback(newView.tweetBtn, new Callback(tweet, this, [newView]));
				
			
				contentMc.addChild(newView.visual);
				views.push(newView);
			}	
		}
		
		
		protected function tweet(v:ViewTwitterAccount) : void {
			v.tweet();
		}
		
		
				        
		protected function removeView(v:ViewTwitterAccount) : void {
			var index:int = views.indexOf(v);
			if(index == -1) return ;
			
			metaAccountList.removeAccount(v.metaTwitterAccount);
			views.splice(index, 1);
			v.destroy();
			
			quickRefresh();
			MetaGameProgress.instance.saveToLocal();
		}
		
		public function quickRefresh():void {
			for (var i : int = 0; i < metaAccountList.accounts.length; i++) {
				var metaTwitterAccount:MetaTwitterAccount = metaAccountList.accounts[i];
				var newView:ViewTwitterAccount = views[i];
				newView.metaTwitterAccount = metaTwitterAccount;
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*50;
			}
			refreshScollBar();
		}
		
		override public function refresh() : void {
			super.refresh();
			createViews();
			refreshScollBar();
			emptyMc.visible = (metaAccountList.accounts.length <= 0);
		}
		
		public function get scrollbarMc() : MovieClip { return visual.getChildByName("scrollbarMc") as MovieClip;}
		public function get contentMc() : MovieClip { return visual.getChildByName("contentMc") as MovieClip;}
		public function get emptyMc() : MovieClip { return visual.getChildByName("emptyMc") as MovieClip;}
	
	}
}
