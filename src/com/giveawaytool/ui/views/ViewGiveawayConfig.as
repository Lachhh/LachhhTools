package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_SelectAnimation;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewGiveawayConfig extends ViewBase {
		public var viewCustomBtn:ViewCustomAnimBtn;
		public function ViewGiveawayConfig(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			pScreen.registerEvent(text1Txt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(text2Txt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerClick(selectBtn, onSelect);
			viewCustomBtn = new ViewCustomAnimBtn(pScreen, selectBtn, MetaGameProgress.instance.metaGiveawayConfig.metaAnimation);
		}

		private function onSelect() : void {
			new UI_SelectAnimation(MetaGameProgress.instance.metaGiveawayConfig.metaAnimation);
		}
		
		private function onEdit() : void {
			MetaGameProgress.instance.metaGiveawayConfig.text1 = text1Txt.text;
			MetaGameProgress.instance.metaGiveawayConfig.text2 = text2Txt.text;
			MetaGameProgress.instance.saveToLocal();
		}
		
		
		override public function refresh() : void {
			super.refresh();
			text1Txt.text = MetaGameProgress.instance.metaGiveawayConfig.text1+"";
			text2Txt.text = MetaGameProgress.instance.metaGiveawayConfig.text2+"";
		}
		
		public function get text1Txt() : TextField { return visual.getChildByName("text1Txt") as TextField;}
		public function get text2Txt() : TextField { return visual.getChildByName("text2Txt") as TextField;}
		public function get selectBtn() : MovieClip { return visual.getChildByName("selectBtn") as MovieClip;}
		
	}
}
