package com.giveawaytool.ui.views {
	import com.lachhh.io.Callback;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.meta.MetaSelectAnimation;
	import com.giveawaytool.ui.UI_SelectAnimation;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCustomAnimBtn extends ViewBase {
		public var metaSelectAnimation:MetaSelectAnimation;
		public var callbackOnTest:Callback;
		public function ViewCustomAnimBtn(pScreen : UIBase, pVisual : DisplayObject, pMetaAnim:MetaSelectAnimation) {
			super(pScreen, pVisual);
			metaSelectAnimation = pMetaAnim;
			screen.setNameOfDynamicBtn(customBtn, "Custom\nAnimation");
			screen.registerClick(customBtn, onSelect);
			if(testBtn) {
				screen.setNameOfDynamicBtn(testBtn, "Test");
				screen.registerClick(testBtn, onTest);
			}
			
			refresh();
		}

		private function onTest() : void {
			if(callbackOnTest) callbackOnTest.call();
		}
		
		private function onSelect() : void {
			new UI_SelectAnimation(metaSelectAnimation);
		}
		
		
		override public function refresh() : void {
			super.refresh();
			if(metaSelectAnimation == null) return ; 
			animUsedTxt.text = metaSelectAnimation.getShortDesc();
		}
		
		public function get animUsedTxt() : TextField { return visual.getChildByName("animUsedTxt") as TextField;}
		public function get customBtn() : MovieClip { return visual.getChildByName("customBtn") as MovieClip;}
		public function get testBtn() : MovieClip { return visual.getChildByName("testBtn") as MovieClip;}
	}
}
