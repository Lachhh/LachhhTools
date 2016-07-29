package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaSubsConfig;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubscriberAlert extends ViewBase {
		public function ViewSubscriberAlert(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			screen.registerClick(newSubBtn, onNewSub);
			screen.registerClick(resubBtn, onReSub);
			pScreen.registerEvent(subTrainTxt, FocusEvent.FOCUS_OUT, onEdit);			
		}

		private function onEdit() : void {
			var crntAmount:int = FlashUtils.myParseFloat(subTrainTxt.text);
			var m:MetaSubsConfig = MetaGameProgress.instance.metaSubsConfig;
			if(!isNaN(crntAmount)) m.subTrainNum = crntAmount;
			
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refresh(); 
		}

	

		private function onReSub() : void {
			MetaGameProgress.instance.metaSubsConfig.alertOnReSub = !MetaGameProgress.instance.metaSubsConfig.alertOnReSub;
			refresh();
		}

		private function onNewSub() : void {
			MetaGameProgress.instance.metaSubsConfig.alertOnNewSub = !MetaGameProgress.instance.metaSubsConfig.alertOnNewSub;
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			
			setCheckBox(MetaGameProgress.instance.metaSubsConfig.alertOnNewSub, newSubBtn);
			setCheckBox(MetaGameProgress.instance.metaSubsConfig.alertOnReSub, resubBtn);
			subTrainTxt.text = MetaGameProgress.instance.metaSubsConfig.subTrainNum+"";
		}

		public function setCheckBox(value : Boolean, btn : MovieClip) : void {
			var checkedMc : MovieClip = btn.getChildByName("checkedMc") as MovieClip;
			if(checkedMc) checkedMc.visible = value;
		}
		
		
		public function get newSubBtn() : MovieClip { return visual.getChildByName("newSubBtn") as MovieClip;}
		public function get resubBtn() : MovieClip { return visual.getChildByName("resubBtn") as MovieClip;}
		public function get subTrainTxt() : TextField { return visual.getChildByName("subTrainTxt") as TextField;}
		
	}
}
