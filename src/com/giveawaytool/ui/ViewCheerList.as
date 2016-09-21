package com.giveawaytool.ui {
	import com.giveawaytool.ui.views.MetaCheer;
	import com.giveawaytool.ui.views.ViewCheerBtn;
	import com.giveawaytool.ui.views.ViewCheerDynamic;
	import com.giveawaytool.ui.views.ViewCheerToolTip;
	import com.giveawaytool.ui.views.ViewGenericListWithPages;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCheerList extends ViewGenericListWithPages {
		public var toolTip : ViewCheerToolTip;

		public function ViewCheerList(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}

		override public function createChildView() : ViewBase {
			return new ViewCheerDynamic(screen, contentMc);
		}

		override public function refresh() : void {
			super.refresh();
			titleTxt.text = "Cheers";
		}

		override protected function sortData(d : Array) : void {
			d.sort(sortOnDate);
		}
		
		private function sortOnDate(a:MetaCheer, b:MetaCheer):int {
			if(a.date.time < b.date.time) return -1;
			if(a.date.time > b.date.time) return -1;
			return 0;
		}

		override public function onClickView(v : ViewBase) : void {
			super.onClickView(v);
			if(!toolTip) return ;
			toolTip.onClickCheerView(v as ViewCheerBtn);
		}
	}
}
