package com.giveawaytool.ui {
	import com.giveawaytool.ui.views.ViewGenericListWithPages;
	import com.giveawaytool.ui.views.ViewHostBtn;
	import com.giveawaytool.ui.views.ViewHostDynamic;
	import com.giveawaytool.ui.views.ViewHostToolTip;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class ViewHostList extends ViewGenericListWithPages {
		public var toolTip : ViewHostToolTip;

		public function ViewHostList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}

		override public function createChildView() : ViewBase {
			return new ViewHostDynamic(screen, contentMc);
		}

		override public function refresh() : void {
			super.refresh();
			titleTxt.text = "Hosts";
			
		}

		override public function onClickView(v : ViewBase) : void {
			super.onClickView(v);
			if(!toolTip) return ;
			toolTip.onClickHostView(v as ViewHostBtn);
		}
	}
}
