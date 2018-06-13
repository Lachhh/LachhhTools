package com.giveawaytool.ui.views {
	import com.giveawaytool.components.TweenNumberComponent;
	import com.giveawaytool.ui.LogicOnOffNextFrame;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.donations.MetaDonationGoal;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationGoal extends ViewBase {
		public var metaGoal : MetaDonationGoal;
		public var viewXP:ViewXpBar;
		public var logicOnOff:LogicOnOffNextFrame;
		private var tweenNumber:TweenNumberComponent;
		
		public function ViewDonationGoal(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			pScreen.registerEvent(targetTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(crntTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(rewardTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerClick(showWidgetBtn, onClickShowWidget);
			
			pScreen.registerClick(activateBtn, onClickEnable);
			pScreen.registerClick(desactivateBtn, onClickEnable);
			pScreen.setNameOfDynamicBtn(activateBtn, "Activate");
			pScreen.setNameOfDynamicBtn(desactivateBtn, "Deactivate");
			
			viewXP = new ViewXpBar(pScreen, progressMc);
			logicOnOff = LogicOnOffNextFrame.addToActor(screen, visualMc);
			logicOnOff.isOn = true;
			logicOnOff.invisibleOnFirstFrame = false;
			visualMc.gotoAndStop(1);
			
			tweenNumber = TweenNumberComponent.addToActor(screen);
			tweenNumber.value = 0;
			tweenNumber.gotoValue = 0;
			tweenNumber.ease = 1;
		}

		private function onClickEnable() : void {
			metaGoal.enabled = !metaGoal.enabled;
			if(metaGoal.enabled == false) visualMc.gotoAndStop(27);
			MetaGameProgress.instance.metaDonationsConfig.isDirty = true;
			screen.refresh();
		}

		private function onClickShowWidget() : void {
			metaGoal.showWidget = !metaGoal.showWidget;
			MetaGameProgress.instance.metaDonationsConfig.isDirty = true;
			screen.refresh();
		}

		private function onEdit() : void {
			if(metaGoal == null) return ;
			var targetAmount:int = FlashUtils.myParseFloat(targetTxt.text);
			var crntAmount:Number = FlashUtils.myParseFloat(crntTxt.text);
			
			if(!isNaN(crntAmount)) metaGoal.crntAmount = crntAmount;
			if(!isNaN(targetAmount)) metaGoal.targetAmount = targetAmount;
			metaGoal.reward = rewardTxt.text;
			
			MetaGameProgress.instance.saveToLocal();
			MetaGameProgress.instance.metaDonationsConfig.isDirty = true;
			screen.refresh(); 
		}
		
		
		override public function update() : void {
			super.update();
			viewXP.crnt = tweenNumber.value;
			viewXP.target = metaGoal.targetAmount;
			viewXP.refresh();
		}
		
		override public function refresh() : void {
			super.refresh();
			if(metaGoal == null) return ;
			targetTxt.text = metaGoal.targetAmount+"";
			crntTxt.text = metaGoal.crntAmount+"";
			rewardTxt.text = metaGoal.reward;
			checkedMc.visible = metaGoal.showWidget;
			//enableCheckedMc.visible = metaGoal.enabled;
			logicOnOff.isOn = metaGoal.enabled;
			tweenNumber.gotoValue = metaGoal.crntAmount;
			tweenNumber.ease = Math.abs((tweenNumber.gotoValue-tweenNumber.value)/40);
			desactivateBtn.visible = metaGoal.enabled;
		}
		
		public function get targetTxt() : TextField { return panel.getChildByName("targetTxt") as TextField;}
		public function get crntTxt() : TextField { return panel.getChildByName("crntTxt") as TextField;}
		public function get rewardTxt() : TextField { return panel.getChildByName("rewardTxt") as TextField;}
		public function get progressMc() : MovieClip { return panel.getChildByName("progressMc") as MovieClip;}	
		public function get showWidgetBtn() : ButtonSelect { return panel.getChildByName("showWidgetBtn") as ButtonSelect;}
		public function get checkedMc() : MovieClip { return showWidgetBtn.getChildByName("checkedMc") as MovieClip;}
		
		public function get panel() : MovieClip { return visual.getChildByName("panel") as MovieClip;}
		public function get activateBtn() : MovieClip { return visual.getChildByName("activateBtn") as MovieClip;}
		public function get desactivateBtn() : MovieClip { return panel.getChildByName("desactivateBtn") as MovieClip;}
		
		//public function get enableBtn() : MovieClip { return panel.getChildByName("enableBtn") as MovieClip;}
		//public function get enableCheckedMc() : MovieClip { return enableBtn.getChildByName("checkedMc") as MovieClip;}		
	}
}
