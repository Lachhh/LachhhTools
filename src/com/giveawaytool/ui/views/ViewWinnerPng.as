package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaSelectAnimation;
	import com.giveawaytool.ui.UI_PopUp;
	import com.lachhh.ResolutionManager;
	import com.lachhh.draw.SwfExporterToFileOnDisk;
	import com.lachhh.draw.SwfTexture;
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.SwfLoaderManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.AnimationManager;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewWinnerPng extends ViewBase {
		public var swfTexture:SwfTexture;
		private var parent:DisplayObjectContainer;
		private var anim : FlashAnimation;
		private var loadedSwf : DisplayObjectContainer;
		private var metaSelectAnimation : MetaSelectAnimation;
		
		private var sprite : Sprite;
		
		public function ViewWinnerPng(pScreen : UIBase, pParent : DisplayObjectContainer) {
			sprite = new Sprite();
			metaSelectAnimation = MetaGameProgress.instance.metaExportPNGConfig.metaAnimation;
			anim = AnimationManager.createAnimation(AnimationFactory.ID_FX_WINNERSNAPSHOT1);
			
			super(pScreen, sprite);
			parent = pParent;
			parent.addChild(sprite);
			sprite.addChild(anim);
			FlashAnimationView.recurStop(anim);
		}
		
		private function onLoadedSwf(o:Object):void {
			destroyLoadedSwf();
			loadedSwf = o as DisplayObjectContainer;
			if(loadedSwf) {
				loadedSwf["values"] = MetaGameProgress.instance.metaExportPNGConfig.encode();
				sprite.addChild(loadedSwf);
				loadedSwf.addEventListener(KeyboardEvent.KEY_DOWN, KeyManager.keyDownHandler);
				loadedSwf.visible = true;
			}
			

		}
		
		private function destroyLoadedSwf():void {
			if(loadedSwf) {
				Utils.LazyRemoveFromParent(loadedSwf);
				loadedSwf = null;
			}
		}
		
		private function onLoadedError():void {
			UI_PopUp.createOkOnly("Couldn't load swf :(", null);
		}

		override public function destroy() : void {
			super.destroy();
			if(anim) {
				AnimationManager.destroy(anim);
				Utils.LazyRemoveFromParent(anim);
				anim = null;
			}
			
			destroyLoadedSwf();
		}
		
		public function extractSnapShot(callback:Callback):void {
			refresh();
			
			CallbackWaitEffect.addWaitCallFctToActor(screen, function():void { 
				swfTexture = new SwfTexture(visual, "SnapShot");
				swfTexture.extractTexture(new Matrix());
				if(callback) callback.callWithParams([swfTexture]);
				screen.destroy();
			}, 2);
			
		}
		
		public function exportSnapShot(onComplete:Callback):void {
			refresh();
			
			SwfExporterToFileOnDisk.saveCompleteCallback = onComplete;
			saveToExternal();
		}
		
		private function saveToExternal():void {
			swfTexture = new SwfTexture(visual, "SnapShot");
			SwfExporterToFileOnDisk.saveTexture(swfTexture);
		}
		
		
		override public function refresh() : void {
			super.refresh();
			anim.visible = metaSelectAnimation.useDefault;
			if(loadedSwf) loadedSwf.visible = !metaSelectAnimation.useDefault;
			if(metaSelectAnimation.useDefault) {
				winnerNameTxt.text = MetaGameProgress.instance.metaExportPNGConfig.winner;
				justWonTxt.text = MetaGameProgress.instance.metaExportPNGConfig.text1;
				urlLabelTxt.text = MetaGameProgress.instance.metaExportPNGConfig.text2;
				yourChannelTxt.text = MetaGameProgress.instance.metaExportPNGConfig.text3;
			} else {
				SwfLoaderManager.loadSwf(metaSelectAnimation.pathToSwf, new Callback(onLoadedSwf, this, null), new Callback(onLoadedError, this, null));
				//loadedSwf.visible = true;
			}
		}
		
		static public function createBitMapData(callback:Callback):void {
			var fakeUI:UIBase = new UIBase(AnimationFactory.EMPTY);
			var v:ViewWinnerPng = new ViewWinnerPng(fakeUI, fakeUI.visual);
			fakeUI.refresh();
			v.extractSnapShot(callback);
			
		}
		
		public function get yourChannelTxt() : TextField { return anim.getChildByName("yourChannelTxt") as TextField;}
		public function get urlLabelTxt() : TextField { return anim.getChildByName("urlLabelTxt") as TextField;}
		public function get justWonMc() : MovieClip { return anim.getChildByName("justWonMc") as MovieClip;}
		public function get winnerNameTxt() : TextField { return anim.getChildByName("winnerNameTxt") as TextField;}
		public function get justWonTxt() : TextField { return justWonMc.getChildByName("txt") as TextField;}
	}
}
