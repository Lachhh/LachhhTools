package com.giveawaytool.ui {
	import com.giveawaytool.ui.views.ViewCheerToolTip;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCheerSettings extends ViewBase {
		public var viewCheerList : ViewCheerList;
		private var viewCheerTooltip : ViewCheerToolTip;

		public function ViewCheerSettings(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewCheerList = new ViewCheerList(screen, lastCheersMc);
			viewCheerTooltip = new ViewCheerToolTip(pScreen, toolTipCheerMc);
			viewCheerList.toolTip = viewCheerTooltip;
			
			screen.registerClick(newCheerBtn, onNewCheer);
			screen.registerClick(allowBurpBtn, onAllowBurp);
		}
		
		private function onNewCheer() : void {
			MetaGameProgress.instance.metaCheerAlertConfig.alertOnNewCheer  = !MetaGameProgress.instance.metaCheerAlertConfig.alertOnNewCheer;
			refresh();
		}

		private function onAllowBurp() : void {
			MetaGameProgress.instance.metaCheerAlertConfig.allowBurp = !MetaGameProgress.instance.metaCheerAlertConfig.allowBurp;
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			viewCheerList.setData(MetaGameProgress.instance.metaCheerAlertConfig.metaCheers.cheers);
			viewCheerList.refresh();
			
			setCheckBox(MetaGameProgress.instance.metaCheerAlertConfig.alertOnNewCheer, newCheerBtn);
			setCheckBox(MetaGameProgress.instance.metaCheerAlertConfig.allowBurp, allowBurpBtn);
		}
		
		public function setCheckBox(value : Boolean, btn : MovieClip) : void {
			var checkedMc : MovieClip = btn.getChildByName("checkedMc") as MovieClip;
			if(checkedMc) checkedMc.visible = value;
		}
		
		
		public function get cheerAlertsMc() : MovieClip { return visual.getChildByName("cheerAlertsMc") as MovieClip;}
		public function get newCheerBtn() : MovieClip { return cheerAlertsMc.getChildByName("newCheerBtn") as MovieClip;}
		public function get allowBurpBtn() : MovieClip { return cheerAlertsMc.getChildByName("allowBurpBtn") as MovieClip;}
		public function get lastCheersMc() : MovieClip { return visual.getChildByName("lastCheersMc") as MovieClip;}
		public function get toolTipCheerMc() : MovieClip { return visual.getChildByName("toolTipCheerMc") as MovieClip;}
		
	}
}
