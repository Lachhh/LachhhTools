package com.giveawaytool.ui.views {
	import com.lachhh.lachhhengine.VersionInfo;
	import com.giveawaytool.ui.UIPopUp;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.giveawaytool.io.DonationSourceRequest;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_Donation;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationsEdit extends ViewBase {
		public var viewStreamTip : ViewStreamTipConnection ;
		public var viewDonationsList : ViewDonationsList;
		public var viewTopDonator : ViewDonationBtn;
		public var viewTopDonatorThisMonth : ViewDonationBtn;
		public var viewTopDonatorThisWeek : ViewDonationBtn;
		public var viewTopDonatorThisDay : ViewDonationBtn;
		
		public var viewDonationToolTip : ViewDonationToolTip;
		public var viewRecurrentGoal : ViewDonationGoal ;
		public var viewBigGoal : ViewDonationGoal ;
		public var viewAutoFetch : ViewDonationTimer;
		public var viewTweetConnection : ViewTweetTimer;
		public var viewCharity : ViewCharity;

		public function ViewDonationsEdit(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewCharity = new ViewCharity(pScreen, charityMc);
			viewCharity.metaCharity = MetaGameProgress.instance.metaDonationsConfig.metaCharity;
			
			viewStreamTip = new ViewStreamTipConnection(pScreen, streamTipMc);
			viewStreamTip.onNewSettings = new Callback(loadNewData, this, [false]);
			viewStreamTip.metaConnection = MetaGameProgress.instance.metaDonationsConfig.metaStreamTipConnection;
			viewStreamTip.streamTip.metaStreamTipConnection = viewStreamTip.metaConnection;
			
			viewAutoFetch = new ViewDonationTimer(pScreen, autoFetchMc);
			viewAutoFetch.metaTimer = MetaGameProgress.instance.metaDonationsConfig.metaAutoFetch;
			
			viewTweetConnection = new ViewTweetTimer(pScreen, autoTwitterMc);
			viewTweetConnection.metaTweetAlertConfig = MetaGameProgress.instance.metaTweetAlertConfig;
			
			viewDonationsList = new ViewDonationsList(pScreen, lastDonationMc);
			viewTopDonator = new ViewDonationBtn(pScreen, topDonationMc);
			viewTopDonatorThisMonth = new ViewDonationBtn(pScreen, topDonationThisMonthMc);
			viewTopDonatorThisWeek = new ViewDonationBtn(pScreen, topDonationThisWeekMc);
			viewTopDonatorThisDay = new ViewDonationBtn(pScreen, topDonationThisDayMc);
			
			viewDonationToolTip = new ViewDonationToolTip(pScreen, toolTipDonationMc);
			viewDonationToolTip.registerDonationView(viewTopDonator);
			viewDonationToolTip.registerDonationView(viewTopDonatorThisMonth);
			viewDonationToolTip.registerDonationView(viewTopDonatorThisWeek);
			viewDonationToolTip.registerDonationView(viewTopDonatorThisDay);
			
			viewDonationToolTip.registerDonationViewList(viewDonationsList.views);
			
			viewRecurrentGoal = new ViewDonationGoal(pScreen, recurrentGoalMc);
			viewBigGoal = new ViewDonationGoal(pScreen, bigGoalMc);
			
			viewRecurrentGoal.metaGoal = MetaGameProgress.instance.metaDonationsConfig.metaRecurrentGoal;
			viewBigGoal.metaGoal = MetaGameProgress.instance.metaDonationsConfig.metaBigGoal;
			
			pScreen.setNameOfDynamicBtn(refreshBtn, "Refresh");
			pScreen.setNameOfDynamicBtn(applySaveBtn, "Apply & Save");
			pScreen.setNameOfDynamicBtn(collectBtn, "Collect New");
			pScreen.setNameOfDynamicBtn(forceStopBtn, "Stop All Anims");
			
			
			pScreen.registerClick(refreshBtn, onRefreshList);
			pScreen.registerClick(applySaveBtn, onRefreshConfig);
			pScreen.registerClick(collectBtn, onCollect);
			pScreen.registerClick(forceStopBtn, onForceStop);
		}

		private function onRefreshList() : void {
			loadNewData(false);
			viewAutoFetch.metaTimer.resetTimer();
		}

		private function onForceStop() : void {
			var ui:UI_Donation = (screen as UI_Donation);
			ui.sendForceStopAnim();
		}

		private function onCollect() : void {
			collectAllNewDonations(false);
		}
		
		public function collectAllNewDonations(silent:Boolean):void {
			var collectedAmount:Number = MetaGameProgress.instance.metaDonationsConfig.allDonations.getAmountTotalOfNew();
			if(collectedAmount > 0) {
				var ui:UI_Donation = (screen as UI_Donation);
				ui.sendAllNewDonation(MetaGameProgress.instance.metaDonationsConfig.allDonations);
				
				var goalReached:int = MetaGameProgress.instance.metaDonationsConfig.metaRecurrentGoal.numRecurrentGoalReachedIfAmountAdded(collectedAmount);
				MetaGameProgress.instance.metaDonationsConfig.addAllNewToGoal();
				MetaGameProgress.instance.saveToLocal();
				screen.refresh();
				
				if(!silent) UIPopUp.createOkOnly("You've collected $" + collectedAmount + "!\nCongrats!",  new Callback(afterOkCollected, this, [goalReached]));
				
			} else {
				if(!silent) UIPopUp.createOkOnly("There are no new donations! Sorry!",  null);
			}
		}
		
		private function afterOkCollected(num:int):void {
			UIBase.manager.refresh();
			if(num <= 0) return ;
			UIPopUp.createOkOnly("Oh! Also, your recurrent goal has been reached " + num + " time" + (num > 1 ? "s" : "") + " with that new money!  Give your audience a treat :D!", null);
			
		}
		
		private function onRefreshConfig() : void {
			var ui:UI_Donation = (screen as UI_Donation);
			ui.sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
			
			MetaGameProgress.instance.metaDonationsConfig.isDirty = false;
			screen.doBtnPressAnim(applySaveBtn);
			MetaGameProgress.instance.saveToLocal();
			refresh();
		}
		
		public function initData() : DonationSourceRequest {
			var r:DonationSourceRequest = viewStreamTip.streamTip.retrieveLast25Donations(new Callback(setDataToConfig, this, null), new Callback(refresh, this, null));
			r.onSuccess.addCallback(new Callback(viewDonationsList.showLoading, viewDonationsList, [false]));
			r.onSuccess.addCallback(new Callback(sendConfigToWidget, this, null));
			r.onError.addCallback(new Callback(viewDonationsList.showLoading, viewDonationsList, [false]));
			
			viewDonationsList.showLoading(true);
			return r;
		}
		
		public function loadNewData(silent:Boolean) : DonationSourceRequest {
			var r:DonationSourceRequest = viewStreamTip.streamTip.retrieveLast25Donations(new Callback(setDataToConfig, this, null), new Callback(onLoadDataError, this, [silent]));
			r.onSuccess.addCallback(new Callback(viewDonationsList.showLoading, viewDonationsList, [false]));
			r.onError.addCallback(new Callback(viewDonationsList.showLoading, viewDonationsList, [false]));
			
			viewDonationsList.showLoading(true);
			return r;
		}
		
		private function onLoadDataError(silent:Boolean):void {
			if(!silent) UIPopUp.createOkOnly("Oops, something wrong happened.  Verify your " + VersionInfo.donationSource.name + " settings.", null);
			refresh();
		}
		
		public function setDataToConfig():void {
			//MetaGameProgress.instance.metaDonationsConfig.topDonation = viewStreamTip.streamTip.getTopDonation();
			MetaGameProgress.instance.metaDonationsConfig.allDonations.addFromSource(viewStreamTip.streamTip.lastDonations);
			MetaGameProgress.instance.metaDonationsConfig.allDonations.refreshTopDonator();
			MetaGameProgress.instance.metaDonationsConfig.updateTopDonatorsIfBetter();
			refresh();
		}
		
		public function sendConfigToWidget():void {
			var uiDonation:UI_Donation = (screen as UI_Donation);
			uiDonation.sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
		}
		

		
		override public function refresh() : void {
			super.refresh();
			viewTopDonator.metaDonation = MetaGameProgress.instance.metaDonationsConfig.topDonation ;
			viewTopDonator.refresh();
			
			viewTopDonatorThisMonth.metaDonation = MetaGameProgress.instance.metaDonationsConfig.topDonationThisMonth ;
			viewTopDonatorThisMonth.refresh();
			
			viewTopDonatorThisWeek.metaDonation = MetaGameProgress.instance.metaDonationsConfig.topDonationThisWeek ;
			viewTopDonatorThisWeek.refresh();
			
			viewTopDonatorThisDay.metaDonation = MetaGameProgress.instance.metaDonationsConfig.topDonationThisDay ;
			viewTopDonatorThisDay.refresh();
		
			viewDonationsList.metaDonations = MetaGameProgress.instance.metaDonationsConfig.allDonations;
			viewDonationsList.refresh();
			
			viewStreamTip.refresh();
			dirtyNoticeMc.visible = MetaGameProgress.instance.metaDonationsConfig.isDirty;
		}
		
		public function get settingsMc() : MovieClip { return visual.getChildByName("settingsMc") as MovieClip;}		
		public function get listMc() : MovieClip { return visual.getChildByName("listMc") as MovieClip;}
		public function get goalsMc() : MovieClip { return visual.getChildByName("goalsMc") as MovieClip;}
		public function get charityMc() : MovieClip { return visual.getChildByName("charityMc") as MovieClip;}
		
		public function get streamTipMc() : MovieClip { return settingsMc.getChildByName("streamTipMc") as MovieClip;}
		public function get autoFetchMc() : MovieClip { return settingsMc.getChildByName("autoFetchMc") as MovieClip;}
		public function get autoTwitterMc() : MovieClip { return settingsMc.getChildByName("autoTwitterMc") as MovieClip;}
		
		public function get topDonationMc() : MovieClip { return listMc.getChildByName("topDonationMc") as MovieClip;}
		public function get topDonationThisMonthMc() : MovieClip { return listMc.getChildByName("topDonationThisMonthMc") as MovieClip;}
		public function get topDonationThisWeekMc() : MovieClip { return listMc.getChildByName("topDonationThisWeekMc") as MovieClip;}
		public function get topDonationThisDayMc() : MovieClip { return listMc.getChildByName("topDonationThisDayMc") as MovieClip;}
		
		public function get lastDonationMc() : MovieClip { return listMc.getChildByName("lastDonationMc") as MovieClip;}
		public function get toolTipDonationMc() : MovieClip { return visual.getChildByName("toolTipDonationMc") as MovieClip;}
		public function get refreshBtn() : MovieClip { return listMc.getChildByName("refreshBtn") as MovieClip;}
		public function get collectBtn() : ButtonSelect { return listMc.getChildByName("collectBtn") as ButtonSelect;}
		
		public function get recurrentGoalMc() : MovieClip { return goalsMc.getChildByName("recurrentGoalMc") as MovieClip;}
		public function get bigGoalMc() : MovieClip { return goalsMc.getChildByName("bigGoalMc") as MovieClip;}
		public function get applySaveBtn() : MovieClip { return goalsMc.getChildByName("applySaveBtn") as MovieClip;}
		public function get dirtyNoticeMc() : MovieClip { return goalsMc.getChildByName("dirtyNoticeMc") as MovieClip;}
		public function get forceStopBtn() : MovieClip { return goalsMc.getChildByName("forceStopBtn") as MovieClip;}
		
	}
}
