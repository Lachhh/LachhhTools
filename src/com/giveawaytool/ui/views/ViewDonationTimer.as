package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaTwitterAccount;
	import com.giveawaytool.meta.donations.MetaDonationFetchTimer;
	import com.giveawaytool.ui.LogicOnOffNextFrame;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationTimer extends ViewBase {
		public var metaTimer : MetaDonationFetchTimer;
		public var logicOnOff:LogicOnOffNextFrame;
		public var editing:Boolean = false;
		
		public function ViewDonationTimer(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			pScreen.registerEvent(secondsTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerClick(autoCollectBtn, onClickAutoCollect);
			
			pScreen.registerClick(activateBtn, onClickEnable);
			pScreen.registerClick(enableBtn, onClickEnable);
			pScreen.registerClick(secondsTxt, onClickSeconds);
			pScreen.setNameOfDynamicBtn(activateBtn, "Activate");
			
			logicOnOff = LogicOnOffNextFrame.addToActor(screen, visualMc);
			logicOnOff.isOn = true;
			logicOnOff.invisibleOnFirstFrame = false;
			visualMc.gotoAndStop(1);
			
		}
		
		private function onClickSeconds() : void {
			editing = true;
		}

		private function onClickAutoCollect() : void {
			metaTimer.autoCollect = !metaTimer.autoCollect;
			refresh(); 
		}

		private function onClickEnable() : void {
			metaTimer.enabled = !metaTimer.enabled;
			if(metaTimer.enabled == false) visualMc.gotoAndStop(27);
			refresh();
		}

		private function onEdit() : void {
			if(metaTimer == null) return ;
			var secondsAmount:int = FlashUtils.myParseFloat(secondsTxt.text);
			
			if(!isNaN(secondsAmount)) {
				metaTimer.seconds = Math.max(secondsAmount, 10);
				metaTimer.resetTimer();
			}
			
			MetaGameProgress.instance.saveToLocal();
			editing = false;
			refresh(); 
		}
		
		
		override public function refresh() : void {
			super.refresh();
			if(metaTimer == null) return ;
			if(editing) return ;
			secondsTxt.text = metaTimer.seconds+"";
			timerNextTxt.text = Utils.secondsToTime(metaTimer.secondsLeft);
			checkedMc.visible = metaTimer.autoCollect;
			logicOnOff.isOn = metaTimer.enabled;
		}
		
		public function get panel() : MovieClip { return visual.getChildByName("panel") as MovieClip;}
		public function get secondsTxt() : TextField { return panel.getChildByName("secondsTxt") as TextField;}
		public function get timerNextTxt() : TextField { return panel.getChildByName("timerNextTxt") as TextField;}
		public function get autoCollectBtn() : ButtonSelect { return panel.getChildByName("autoCollectBtn") as ButtonSelect;}
		public function get checkedMc() : MovieClip { return autoCollectBtn.getChildByName("checkedMc") as MovieClip;}
		
		public function get activateBtn() : MovieClip { return visual.getChildByName("activateBtn") as MovieClip;}
		public function get enableBtn() : MovieClip { return panel.getChildByName("enableBtn") as MovieClip;}

		public function get enableCheckedMc() : MovieClip {
			return enableBtn.getChildByName("checkedMc") as MovieClip;
		}
	}
}
