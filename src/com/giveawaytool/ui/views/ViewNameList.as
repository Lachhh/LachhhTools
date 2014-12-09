package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.EffectKickBack;
	import com.giveawaytool.effect.EffectScaleBackTo1;
	import com.giveawaytool.effect.LogicDestroyOutsideOfBounds;
	import com.giveawaytool.effect.LogicRotate;
	import com.giveawaytool.effect.ui.EffectShakeUI;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.UIEffect;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.net.registerClassAlias;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewNameList extends ViewBase {
		static public var EMPTY_ARRAY:Array = [];
		private var names:Array = EMPTY_ARRAY;
		public var views:Vector.<ViewName> = new Vector.<ViewName>();
		public var viewScrollBar:ViewScrollBar;
		public var viewNameListEdit:ViewNameListEdit;
		
		public function ViewNameList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewScrollBar = new ViewScrollBar(pScreen, scrollbarMc);
			viewScrollBar.callbackOnChange = new Callback(refreshScollBar, this, null);
			
			viewNameListEdit = new ViewNameListEdit(pScreen, pVisual);
			pScreen.registerClick(cancelBtn, onCancel);
			loadingMc.visible = false;
		}

		private function onCancel() : void {
			viewNameListEdit.cancelLoading();
		}
		
		public function clear():void {
			names = EMPTY_ARRAY;
			refresh();
		}
        
        public function setNames(newNames:Array):void {
			
            names = newNames;
			
        }
		
		private function destroyAllChildren():void {
			while(views.length > 0) {
				var view:ViewBase = views.shift();
				view.destroy();
				
			}
		}
		
		private function cleanNames():void {
			for (var i : int = 0; i < names.length; i++) {
				var name:String = names[i];
				if(name == "" || name == null) {
					names.splice(i, 1);
					 i--;
				}
			}
		}
		
		private function refreshScollBar():void {
			viewScrollBar.contentWidth = contentMc.height;
			contentMc.y = -(contentMc.height-viewScrollBar.viewWidth)*viewScrollBar.getPrctPostion();
			viewScrollBar.refresh();
		}
		
		public function createViews():void {
			destroyAllChildren();
			cleanNames();
			names.sort();
			for (var i : int = 0; i < names.length; i++) {
				var name:String = names[i];
				var newView:ViewName = new ViewName(screen);
				newView.name = name;
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*17;
				screen.registerClickWithCallback(newView.visual, new Callback(removeViewWithFx, this, [newView]));
				contentMc.addChild(newView.visual);
				views.push(newView);
			}	
		}
		
		public function flash():void {
			
			for (var i : int = 0; i < views.length; i++) {
				var newView:ViewName = views[i];
				CallbackWaitEffect.addWaitCallFctToActor(actor, newView.flash, i);
				if(i > 20) return;
			}
		}
		
		private function removeViewWithFx(v:ViewName):void {
			removeView(v);
			createNameTossed(v.name);
		}
        
        

		protected function removeView(v:ViewName) : void {
			
			var index:int = views.indexOf(v);
			if(index == -1) return ;
			
			names.splice(index, 1);
			views.splice(index, 1);
			v.destroy();
			
			quickRefresh();
		}
		
		private function createNameTossed(name:String):void {
			var fx:UIEffect = UIEffect.createStaticUiFxOnMouseCursor(AnimationFactory.ID_FX_NAME_CENTERED);
			fx.physicComponent = PhysicComponent.addToActor(fx);
			fx.physicComponent.gravY = 0.5;
			fx.physicComponent.vx = 5+Math.random()*5;
			fx.physicComponent.vy = -4+Math.random()*2;
			if(Math.random() < 0.5) fx.physicComponent.vx *= -1;
			LogicRotate.addToActor(fx);
			EffectScaleBackTo1.addToActor(fx, 2, 2);
			EffectKickBack.addToActor(fx, -30, 0);
			
			EffectFadeOut.addToActor(fx, 5, 0xFFFFFF);
			var tf:TextField = fx.renderComponent.animView.anim.getChildByName("nameTxt") as TextField;
			tf.text = name;
		
			LogicDestroyOutsideOfBounds.addToActorBasedOnUI(fx);
			var animId:int = (Math.random() < 0.5 ? AnimationFactory.ID_FX_IMPACT1 : AnimationFactory.ID_FX_IMPACT2);
			fx = UIEffect.createStaticUiFxOnMouseCursor(animId);
			fx.renderComponent.animView.fps = 30;
			EffectShakeUI.addToActor(screen, contentMc, 5, 5);
		}
		
		public function quickRefresh():void {
			for (var i : int = 0; i < names.length; i++) {
				var name:String = names[i];
				var newView:ViewName = views[i];
				newView.name = name;
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*17;
			}
			refreshScollBar();
			refreshTotal();
		}
		
		public function refreshTotal():void {
			totalTxt.text = "Total : " + names.length;
		}
		
		override public function refresh() : void {
			super.refresh();
			createViews();
			refreshScollBar();
			refreshTotal();
			emptyMc.visible = (names.length <= 0) && !isLoading();
			flash();
		}
		
		public function showLoading(b:Boolean):void {
			loadingMc.visible = b;
		}
        
        public function isLoading():Boolean {
			return (loadingMc.visible);
		}
        
        public function getNames():Array {
            return names;
        }
		
		public function get scrollbarMc() : MovieClip { return nameListMc.getChildByName("scrollbarMc") as MovieClip;}
		public function get contentMc() : MovieClip { return nameListMc.getChildByName("contentMc") as MovieClip;}
		public function get totalTxt() : TextField { return visual.getChildByName("totalTxt") as TextField;}
		public function get nameListMc() : MovieClip { return visual.getChildByName("nameListMc") as MovieClip;}
		public function get loadingMc() : MovieClip { return nameListMc.getChildByName("loadingMc") as MovieClip;}
		public function get emptyMc() : MovieClip { return nameListMc.getChildByName("emptyMc") as MovieClip;}
		public function get cancelBtn() : ButtonSelect { return loadingMc.getChildByName("cancelBtn") as ButtonSelect;}
		
	}
}
