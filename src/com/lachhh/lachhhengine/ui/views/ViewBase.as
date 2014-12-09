package com.lachhh.lachhhengine.ui.views {
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewBase extends ActorComponent {
		public var screen:UIBase;
		public var visualRaw:DisplayObject;
		public var visual:DisplayObjectContainer;
		public var visualMc:MovieClip;
		public var visualTxt:TextField;
		public var visualBtn:ButtonSelect;
		
		public function ViewBase(pScreen : UIBase, pVisual:DisplayObject) {
			super();
			if(pVisual == null) throw new Error("Visual must not be null");
			screen = pScreen;
			visualRaw = pVisual;
			visual = visualRaw as DisplayObjectContainer;
			visualMc = visualRaw as MovieClip;
			visualTxt = visualRaw as TextField;
			visualBtn = visualRaw as ButtonSelect;
			
			screen.addComponent(this);
		}
		
	}
}
