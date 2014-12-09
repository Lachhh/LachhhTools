package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaSelectAnimation;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCustomAnimBtn extends ViewBase {
		public var metaSelectAnimation:MetaSelectAnimation;
		public function ViewCustomAnimBtn(pScreen : UIBase, pVisual : DisplayObject, pMetaAnim:MetaSelectAnimation) {
			super(pScreen, pVisual);
			metaSelectAnimation = pMetaAnim;
			refresh();
		}
		
		
		override public function refresh() : void {
			super.refresh();
			if(metaSelectAnimation == null) return ; 
			animUsedTxt.text = metaSelectAnimation.getShortDesc();
		}
		
		public function get animUsedTxt() : TextField { return visual.getChildByName("animUsedTxt") as TextField;}
	}
}
