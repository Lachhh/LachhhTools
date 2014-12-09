package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.ui.UIBase;
	import flash.display.DisplayObject;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaSelectAnimation;
	import com.lachhh.ResolutionManager;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.SwfLoaderManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIOpenClose;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_SelectAnimation extends UIOpenClose {
		public var metaSelectAnimation : MetaSelectAnimation;
		public function UI_SelectAnimation(pMetaSelectAnimation:MetaSelectAnimation) {
			super(AnimationFactory.ID_UI_SELECTANIMATION, 15, 35);
			metaSelectAnimation = pMetaSelectAnimation;
			setNameOfDynamicBtn(browseBtn, "Browse");
			registerClick(browseBtn, onBrowse);
			registerClick(xBtn, close);
			
			registerClickWithCallback(useCustomBtn, new Callback(useDefault, this, [false]));
			registerClickWithCallback(useDefaultBtn, new Callback(useDefault, this, [true]));
			
			px = ResolutionManager.getGameWidth()*0.5;
			py = ResolutionManager.getGameHeight()*0.5;
			refresh();
			renderComponent.animView.addCallbackOnFrame(new Callback(refresh, this, null), 2);
		}

		private function onLoaded(o:Object) : void {
			var d:DisplayObject = o as DisplayObject;
			if(d) {
				visual.addChild(d);
			}
		}

		override protected function onIdle() : void {
			super.onIdle();
			refresh();
		}
		override public function destroy() : void {
			super.destroy();
			metaSelectAnimation.clean();
			useCustomBtn.deselect();
			useDefaultBtn.deselect();
			UIBase.manager.refresh();
		}
 	
		private function onBrowse() : void {
			SwfLoaderManager.browseForFile(new Callback(onEdit, this, null));
		}
		
		private function onEdit():void {
			metaSelectAnimation.pathToSwf = SwfLoaderManager.pathOnDisk;
			metaSelectAnimation.useDefault = false;
			MetaGameProgress.instance.saveToLocal();
			refresh();
		}
		
		public function useDefault(b:Boolean):void {
			metaSelectAnimation.useDefault = b;
			MetaGameProgress.instance.saveToLocal();
			refresh();
		}
		
		override public function refresh() : void {
			super.refresh();
			useDefaultBtn.selectIfBoolean(metaSelectAnimation.useDefault);
			useCustomBtn.selectIfBoolean(!metaSelectAnimation.useDefault);
			pathTxt.text = metaSelectAnimation.pathToSwf+"";
			if(metaSelectAnimation.useDefault) {
				pathTxt.textColor = 0x333333;
			} else {
				pathTxt.textColor = 0x9FC7BD; 
			}
		}
		
		
		public function get panel() : MovieClip { return visual.getChildByName("panel") as MovieClip;}
		public function get pathTxt() : TextField { return panel.getChildByName("pathTxt") as TextField;}
		public function get useCustomBtn() : ButtonSelect { return panel.getChildByName("useCustomBtn") as ButtonSelect;}
		public function get useDefaultBtn() : ButtonSelect { return panel.getChildByName("useDefaultBtn") as ButtonSelect;}
		public function get browseBtn() : ButtonSelect { return panel.getChildByName("browseBtn") as ButtonSelect;}
		public function get xBtn() : MovieClip { return panel.getChildByName("xBtn") as MovieClip;}
		
	}
}
