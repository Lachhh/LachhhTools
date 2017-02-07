package com.giveawaytool.ui.views {
	import com.giveawaytool.io.DonationSourceRequest;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.UI_PopUp;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationsEdit extends ViewBase {
		public var viewStreamTip : ViewStreamTipConnection ;
		public var viewStreamLabs : ViewStreamLabsConnection;
		public var viewDonationsList : ViewDonationList;
		
		public var viewTopDonator : ViewFollowerBtn;
		public var viewTopDonatorThisMonth : ViewFollowerBtn;
		public var viewTopDonatorThisWeek : ViewFollowerBtn;
		public var viewTopDonatorThisDay : ViewFollowerBtn;
		
		public var viewDonationToolTip : ViewDonationToolTip;
		public var viewRecurrentGoal : ViewDonationGoal ;
		public var viewBigGoal : ViewDonationGoal ;
		public var viewAutoFetch : ViewDonationTimer;
		public var viewCharity : ViewCharity;
		public var viewCustomBtn : ViewCustomAnimBtn;

		public function ViewDonationsEdit(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewCustomBtn = new ViewCustomAnimBtn(pScreen, customAnimBtn, MetaGameProgress.instance.metaDonationsConfig.metaCustomAnim.metaCustomAnimNewDonation);
			
			viewCharity = new ViewCharity(pScreen, charityMc);
			viewCharity.metaCharity = MetaGameProgress.instance.metaDonationsConfig.metaCharity;
			
			viewStreamTip = new ViewStreamTipConnection(pScreen, streamTipMc);
			viewStreamTip.onNewSettings = new Callback(loadNewData, this, [false]);
			viewStreamTip.metaConnection = MetaGameProgress.instance.metaDonationsConfig.metaStreamTipConnection;
			viewStreamTip.donationSourceConnection.metaStreamTipConnection = viewStreamTip.metaConnection;
			
			viewStreamLabs = new ViewStreamLabsConnection(pScreen, streamLabsMc);
			viewStreamLabs.onNewSettings = new Callback(loadNewData, this, [false]);
			
			viewAutoFetch = new ViewDonationTimer(pScreen, autoFetchMc);
			viewAutoFetch.metaTimer = MetaGameProgress.instance.metaDonationsConfig.metaAutoFetch;
			
			viewDonationsList = new ViewDonationList(pScreen, lastDonationMc);
			viewTopDonator = new ViewFollowerBtn(pScreen, topDonationMc);
			viewTopDonatorThisMonth = new ViewFollowerBtn(pScreen, topDonationThisMonthMc);
			viewTopDonatorThisWeek = new ViewFollowerBtn(pScreen, topDonationThisWeekMc);
			viewTopDonatorThisDay = new ViewFollowerBtn(pScreen, topDonationThisDayMc);
			
			viewDonationToolTip = new ViewDonationToolTip(pScreen, toolTipDonationMc);
			viewDonationToolTip.registerDonationView(viewTopDonator);
			viewDonationToolTip.registerDonationView(viewTopDonatorThisMonth);
			viewDonationToolTip.registerDonationView(viewTopDonatorThisWeek);
			viewDonationToolTip.registerDonationView(viewTopDonatorThisDay);
			viewDonationsList.toolTip = viewDonationToolTip;
			
			viewRecurrentGoal = new ViewDonationGoal(pScreen, recurrentGoalMc);
			viewBigGoal = new ViewDonationGoal(pScreen, bigGoalMc);
			
			viewRecurrentGoal.metaGoal = MetaGameProgress.instance.metaDonationsConfig.metaRecurrentGoal;
			viewBigGoal.metaGoal = MetaGameProgress.instance.metaDonationsConfig.metaBigGoal;
			
			pScreen.setNameOfDynamicBtn(refreshBtn, "Refresh");
			pScreen.setNameOfDynamicBtn(collectBtn, "Collect New");
			
			pScreen.registerClick(refreshBtn, onRefreshList);
			pScreen.registerClick(collectBtn, onCollect);
			
		}

		private function onRefreshList() : void {
			viewDonationsList.showLoading(true);
			viewAutoFetch.metaTimer.secondsLeft = 0;
		}

		private function onCollect() : void {
			collectAllNewDonations();
		}
		
		private function collectAllNewDonations():void {
			var collectedAmount:Number = MetaGameProgress.instance.metaDonationsConfig.allDonations.getAmountTotalOfNew();
			
			if(collectedAmount > 0) {
				var goalReached:int = MetaGameProgress.instance.metaDonationsConfig.metaRecurrentGoal.numRecurrentGoalReachedIfAmountAdded(collectedAmount);
				UI_PopUp.createOkOnly("You've collected $" + collectedAmount + "!\nCongrats!",  new Callback(afterOkCollected, this, [goalReached]));
				UI_Menu.instance.logicNotification.logicDonationsAutoFetch.collectAllNewDonations();
				screen.refresh();
			} else {
				UI_PopUp.createOkOnly("There are no new donations! Sorry!",  null);
			}
		}
		
		private function afterOkCollected(num:int):void {
			UIBase.manager.refresh();
			if(num <= 0) return ;
			UI_PopUp.createOkOnly("Oh! Also, your recurrent goal has been reached " + num + " time" + (num > 1 ? "s" : "") + " with that new money!  Give your audience a treat :D!", null);
		}
		
		public function initData() : DonationSourceRequest {
			var r:DonationSourceRequest = viewStreamTip.donationSourceConnection.retrieveLast25Donations(new Callback(setDataToConfig, this, null), new Callback(refresh, this, null));
			r.onSuccess.addCallback(new Callback(viewDonationsList.showLoading, viewDonationsList, [false]));
			r.onSuccess.addCallback(new Callback(sendConfigToWidget, this, null));
			r.onError.addCallback(new Callback(viewDonationsList.showLoading, viewDonationsList, [false]));
			
			viewDonationsList.showLoading(true);
			return r;
		}
		
		public function loadNewData(silent:Boolean) : DonationSourceRequest {
			var r:DonationSourceRequest = viewStreamTip.donationSourceConnection.retrieveLast25Donations(new Callback(setDataToConfig, this, null), new Callback(onLoadDataError, this, [silent]));
			r.onSuccess.addCallback(new Callback(viewDonationsList.showLoading, viewDonationsList, [false]));
			r.onError.addCallback(new Callback(viewDonationsList.showLoading, viewDonationsList, [false]));
			
			viewDonationsList.showLoading(true);
			return r;
		}
		
		private function onLoadDataError(silent:Boolean):void {
			if(!silent) UI_PopUp.createOkOnly("Oops, something wrong happened.  Verify your " + VersionInfo.donationSource.name + " settings.", null);
			refresh();
		}
		
		public function setDataToConfig():void {
			MetaGameProgress.instance.metaDonationsConfig.allDonations.addFromSource(viewStreamTip.donationSourceConnection.lastDonations);
			MetaGameProgress.instance.metaDonationsConfig.allDonations.refreshTopDonator();
			MetaGameProgress.instance.metaDonationsConfig.updateTopDonatorsIfBetter();
			refresh();
		}
		
		public function sendConfigToWidget():void {
			UI_Menu.instance.logicNotification.logicSendToWidget.sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
		}
		

		
		override public function refresh() : void {
			super.refresh();
			viewTopDonator.metaData = MetaGameProgress.instance.metaDonationsConfig.topDonation ;
			viewTopDonator.refresh();
			
			viewTopDonatorThisMonth.metaData = MetaGameProgress.instance.metaDonationsConfig.topDonationThisMonth ;
			viewTopDonatorThisMonth.refresh();
			
			viewTopDonatorThisWeek.metaData = MetaGameProgress.instance.metaDonationsConfig.topDonationThisWeek ;
			viewTopDonatorThisWeek.refresh();
			
			viewTopDonatorThisDay.metaData = MetaGameProgress.instance.metaDonationsConfig.topDonationThisDay ;
			viewTopDonatorThisDay.refresh();
		
			viewDonationsList.setData(MetaGameProgress.instance.metaDonationsConfig.allDonations.donations);
			viewDonationsList.refresh();
			
			viewStreamTip.refresh();
			viewStreamLabs.refresh();
			//dirtyNoticeMc.visible = MetaGameProgress.instance.metaDonationsConfig.isDirty;
		}
		
		public function get settingsMc() : MovieClip { return visual.getChildByName("settingsMc") as MovieClip;}		
		public function get listMc() : MovieClip { return visual.getChildByName("listMc") as MovieClip;}
		public function get goalsMc() : MovieClip { return visual.getChildByName("goalsMc") as MovieClip;}
		public function get customAnimBtn() : MovieClip { return settingsMc.getChildByName("customAnimBtn") as MovieClip;}
		
		public function get charityMc() : MovieClip { return visual.getChildByName("charityMc") as MovieClip;}
		
		public function get streamTipMc() : MovieClip { return settingsMc.getChildByName("streamTipMc") as MovieClip;}
		public function get streamLabsMc() : MovieClip { return settingsMc.getChildByName("streamLabsMc") as MovieClip;}
		
		public function get autoFetchMc() : MovieClip { return settingsMc.getChildByName("autoFetchMc") as MovieClip;}
		//public function get autoTwitterMc() : MovieClip { return settingsMc.getChildByName("autoTwitterMc") as MovieClip;}
		
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
		//public function get dirtyNoticeMc() : MovieClip { return goalsMc.getChildByName("dirtyNoticeMc") as MovieClip;}
		//public function get applySaveBtn() : MovieClip { return goalsMc.getChildByName("applySaveBtn") as MovieClip;}
		//public function get forceStopBtn() : MovieClip { return goalsMc.getChildByName("forceStopBtn") as MovieClip;}
		
	}
}
