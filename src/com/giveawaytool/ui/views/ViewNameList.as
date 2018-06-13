package com.giveawaytool.ui.views {
	import flash.geom.Point;
	import com.lachhh.utils.Utils;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.EffectKickBack;
	import com.giveawaytool.effect.EffectScaleBackTo1;
	import com.giveawaytool.effect.LogicDestroyOutsideOfBounds;
	import com.giveawaytool.effect.LogicRotate;
	import com.giveawaytool.effect.ui.EffectShakeUI;
	import com.lachhh.flash.ui.ButtonSelect;
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
	public class ViewNameList extends ViewBase {
		static public var EMPTY_ARRAY:Vector.<MetaParticipant> = new Vector.<MetaParticipant>();
		private var names:Vector.<MetaParticipant> = EMPTY_ARRAY;
		public var views:Vector.<ViewName> = new Vector.<ViewName>();
		public var viewScrollBar:ViewScrollBar;
		
		
		public function ViewNameList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewScrollBar = new ViewScrollBar(pScreen, scrollbarMc);
			viewScrollBar.callbackOnChange = new Callback(refreshScollBar, this, null);
			
			loadingMc.visible = false;
			emptyMc.visible = false;
		}

		
		
		public function clear():void {
			names = EMPTY_ARRAY;
			refresh();
		}

		public function setNames(newNames : Vector.<MetaParticipant>) : void {
            names = newNames;
        }
		
		private function destroyAllChildren():void {
			while(views.length > 0) {
				var view:ViewBase = views.shift();
				view.destroy();
				
			}
		}
		
		public function getViewFromName(pName:String):ViewName {
			for (var i : int = 0; i < views.length; i++) {
				var v:ViewName = views[i];
				if(v.metaParticipant.name == pName) return v;
			}
			return null;
		}
		
		private function cleanNames():void {
			for (var i : int = 0; i < names.length; i++) {
				var name:MetaParticipant = names[i];
				if(name.isNull()) {
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
			names.sort(MetaParticipant.sortByNameLowerCase);
			for (var i : int = 0; i < names.length; i++) {
				var name:MetaParticipant = names[i];
				var newView:ViewName = creatViewWithName();
				newView.metaParticipant = name;
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*17;
				

				views.push(newView);
			}	
		}
		
		private function creatViewWithName():ViewName {
			var result:ViewName = new ViewName(screen, contentMc);
			screen.registerClickWithCallback(result.visual, new Callback(removeViewWithFx, this, [result]));
			return result;
			
		}
			
		
		public function flash():void {
			for (var i : int = 0; i < views.length; i++) {
				var newView:ViewName = views[i];
				CallbackWaitEffect.addWaitCallFctToActor(actor, newView.flash, i);
				if(i > 20) return;
			}
		}
		
		public function removeViewFromParticipants(lstToREmove:Vector.<MetaParticipant>):void {
			var a:Array = MetaParticipant.toArray(lstToREmove);
			removeViewFromNames(a);
		}
		
		public function removeViewFromNames(lstToREmove:Array):void {
			var numFx:int = 0;
			for (var i : int = 0; i < lstToREmove.length; i++) {
				var name:String = lstToREmove[i];
				var v:ViewName = getViewFromName(name);
				if(v == null) continue;
				
				if(numFx < 20) {
					var fx:UIEffect = createNameTossed(v.metaParticipant.name);
					var p:Point = new Point();
					p = v.visual.localToGlobal(p);
					fx.px = p.x+100;
					fx.py = p.y+Math.random()*400-200;
					var l:LogicRotate = fx.getComponent(LogicRotate) as LogicRotate;
					if(l) l.rotateSpeed += Math.random()*15;
					removeView(v);
					numFx++;
				}
			}
			
		}
		
		private function removeViewWithFx(v:ViewName):void {
			removeView(v);
			createNameTossed(v.metaParticipant.name);
		}
        
        

		protected function removeView(v:ViewName) : void {
			
			var index:int = views.indexOf(v);
			if(index == -1) return ;
			
			names.splice(index, 1);
			views.splice(index, 1);
			v.destroy();
			
			quickRefresh();
		}
		
		private function createNameTossed(name:String):UIEffect {
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
			var fxImpact:UIEffect = UIEffect.createStaticUiFxOnMouseCursor(animId);
			fxImpact.renderComponent.animView.fps = 30;
			EffectShakeUI.addToActor(screen, contentMc, 5, 5);
			return fx;
		}
		
		public function quickRefresh():void {
			for (var i : int = 0; i < names.length; i++) {
				var name:MetaParticipant = names[i];
				var newView:ViewName;
				if(i >= views.length) {
					newView = creatViewWithName();
					views.push(newView);
				} else {
					newView = views[i];
				}
				
				newView.metaParticipant = name;
				newView.refresh();
				newView.visual.x = 0;
				newView.visual.y = i*17;
			}
			
			refreshScollBar();
			refreshTotal();
			emptyMc.visible = (names.length <= 0) && !isLoading();
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
			contentMc.alpha = (b ? 0.2 : 1);
			if(b) emptyMc.visible = false; 
		}
        
        public function isLoading():Boolean {
			return (loadingMc.visible);
		}
        
        public function getNames():Vector.<MetaParticipant> {
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
