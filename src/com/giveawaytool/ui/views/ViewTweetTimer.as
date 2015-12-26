package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaTweetAlertConfig;
	import com.giveawaytool.meta.MetaTwitterAccount;
	import com.giveawaytool.ui.LogicOnOffNextFrame;
	import com.giveawaytool.ui.UI_NewTwitterAccount;
	import com.lachhh.flash.FlashUtils;
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
	public class ViewTweetTimer extends ViewBase {
		public var metaTweetAlertConfig : MetaTweetAlertConfig;
		public var logicOnOff:LogicOnOffNextFrame;
		public var editing:Boolean = false;
		public var viewTwitterAccount:ViewTwitterAccountSmall;
		public var callbackOnRefresh:Callback;
		public function ViewTweetTimer(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			pScreen.registerEvent(secondsTxt, FocusEvent.FOCUS_OUT, onEdit);
			
			pScreen.registerClick(activateBtn, onClickEnable);
			pScreen.registerClick(enableBtn, onClickEnable);
			pScreen.registerClick(secondsTxt, onClickSeconds);
			pScreen.registerClick(connectBtn, onAddTwitter);
			pScreen.registerClick(removeBtn, onRemoveTwitter);
			
			pScreen.setNameOfDynamicBtn(activateBtn, "Activate");
			pScreen.setNameOfDynamicBtn(removeBtn, "Remove");
			pScreen.setNameOfDynamicBtn(connectBtn, "Connect");
			
			logicOnOff = LogicOnOffNextFrame.addToActor(screen, visualMc);
			logicOnOff.isOn = true;
			logicOnOff.invisibleOnFirstFrame = false;
			visualMc.gotoAndStop(1);
			viewTwitterAccount = new ViewTwitterAccountSmall(pScreen, twitterSmallMc);
			callbackOnRefresh = new Callback(refresh, this, null);
		}

		private function onRemoveTwitter() : void {
			MetaGameProgress.instance.metaShareOnTwitter.twitterAccounts.removeFirst();
			refresh();
		}

		private function onClickSeconds() : void {
			editing = true;
		}


		private function onClickEnable() : void {
			metaTweetAlertConfig.metaAutoFetch.enabled = !metaTweetAlertConfig.metaAutoFetch.enabled;
			if(metaTweetAlertConfig.metaAutoFetch.enabled == false) visualMc.gotoAndStop(27);
			refresh();
		}

		private function onEdit() : void {
			if(metaTweetAlertConfig == null) return ;
			var secondsAmount:int = FlashUtils.myParseFloat(secondsTxt.text);
			
			if(!isNaN(secondsAmount)) {
				metaTweetAlertConfig.metaAutoFetch.seconds = Math.max(secondsAmount, 10);
				metaTweetAlertConfig.metaAutoFetch.resetTimer();
			}
			
			MetaGameProgress.instance.saveToLocal();
			editing = false;
			refresh(); 
		}
		
		
		override public function refresh() : void {
			super.refresh();
			if(metaTweetAlertConfig == null)
			if(editing) return ;
			secondsTxt.text = metaTweetAlertConfig.metaAutoFetch.seconds+"";
			timerNextTxt.text = Utils.secondsToTime(metaTweetAlertConfig.metaAutoFetch.secondsLeft);
			
			logicOnOff.isOn = metaTweetAlertConfig.metaAutoFetch.enabled;
			refreshTwitAccount();
			
		}
		
		private function refreshTwitAccount():void {
			var metaTwitterAccount:MetaTwitterAccount = metaTweetAlertConfig.getTwitterAccount();
			viewTwitterAccount.metaTwitterAccount = metaTwitterAccount;
			if(metaTwitterAccount == null) {
				connectBtn.visible = true;
				removeBtn.visible = false;
				viewTwitterAccount.visual.visible = false;
			} else {
				connectBtn.visible = false;
				removeBtn.visible = true;
				viewTwitterAccount.visual.visible = true;
				metaTwitterAccount.callbackRefresh.addIfNotIn(callbackOnRefresh);
			}
			viewTwitterAccount.refresh();
		}
		
		private function onAddTwitter() : void {
			var newAccount:UI_NewTwitterAccount = new UI_NewTwitterAccount();
			newAccount.onCompleteCallback = new Callback(onNewAccount, this, null);
		}

		private function onNewAccount() : void {
			refresh();
			MetaGameProgress.instance.saveToLocal();
		}
		
		public function get panel() : MovieClip { return visual.getChildByName("panel") as MovieClip;}
		public function get secondsTxt() : TextField { return panel.getChildByName("secondsTxt") as TextField;}
		public function get timerNextTxt() : TextField { return panel.getChildByName("timerNextTxt") as TextField;}
		
		public function get activateBtn() : MovieClip { return visual.getChildByName("activateBtn") as MovieClip;}
		public function get enableBtn() : MovieClip { return panel.getChildByName("enableBtn") as MovieClip;}
		public function get enableCheckedMc() : MovieClip { return enableBtn.getChildByName("checkedMc") as MovieClip;}
		public function get twitterSmallMc() : MovieClip { return panel.getChildByName("twitterSmallMc") as MovieClip;}		
		public function get removeBtn() : MovieClip { return panel.getChildByName("removeBtn") as MovieClip;}
		public function get connectBtn() : MovieClip { return panel.getChildByName("connectBtn") as MovieClip;}
		
		
		
	}
}
