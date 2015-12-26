package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaSubsConfig;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubTemp extends ViewBase {
		public function ViewSubTemp(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			pScreen.registerEvent(crntTxt, FocusEvent.FOCUS_OUT, onEdit);			
		}

		private function onEdit() : void {
			var crntAmount:int = FlashUtils.myParseFloat(crntTxt.text);
			var m:MetaSubsConfig = MetaGameProgress.instance.metaSubsConfig;
			if(!isNaN(crntAmount)) m.crntSub.value = crntAmount;
			
			MetaGameProgress.instance.saveToLocal();
			MetaGameProgress.instance.metaDonationsConfig.isDirty = true;
			screen.refresh(); 
		}
		
		
		override public function refresh() : void {
			super.refresh();
			var m:MetaSubsConfig = MetaGameProgress.instance.metaSubsConfig;
			crntTxt.text = m.crntSub.value+"";
			totalTxt.text = "/"+m.crntSub.xpToNext;
		}
		
		public function get crntTxt() : TextField { return visual.getChildByName("crntTxt") as TextField;}
		public function get totalTxt() : TextField { return visual.getChildByName("totalTxt") as TextField;}
	}
}
