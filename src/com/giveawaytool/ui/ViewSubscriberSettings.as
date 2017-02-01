package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewCustomAnimBtn;
	import com.giveawaytool.ui.views.ViewSubscriberToolTip;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubscriberSettings extends ViewBase {
		public var viewSubscriberList : ViewSubscribersList;
		public var viewSubscriberToolTip : ViewSubscriberToolTip;
		public var viewSubscriberAlert : ViewSubscriberAlert;
		public var viewSubscriberGoal : ViewSubscriberGoal;
		public var viewCustomBtn : ViewCustomAnimBtn;
		private var viewTestFirst : ViewTestFirst;

		public function ViewSubscriberSettings(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewTestFirst = new ViewTestFirst(pScreen, testFirstMc);
			viewTestFirst.metaHasBeenTested = MetaGameProgress.instance.metaSubsConfig.metaHasBeenTested;
			
			viewSubscriberAlert = new ViewSubscriberAlert(screen, subAlertsMc);
			viewSubscriberGoal = new ViewSubscriberGoal(screen, goalsMc);
			viewSubscriberList = new ViewSubscribersList(screen, lastSubscriptionMc);
			viewSubscriberToolTip = new ViewSubscriberToolTip(screen, toolTipSubscriberMc);
			viewSubscriberList.toolTip = viewSubscriberToolTip; 
			
			viewCustomBtn = new ViewCustomAnimBtn(pScreen, customAnimBtn, MetaGameProgress.instance.metaDonationsConfig.metaCustomAnim.metaCustomAnimNewSub);
		
			screen.setNameOfDynamicBtn(refreshBtn, "Refresh");
			screen.setNameOfDynamicBtn(collectBtn, "Alert New");

			screen.registerClick(refreshBtn, onRefresh);
			screen.registerClick(collectBtn, onCollect);
			viewSubscriberList.showLoading(true);
			refresh();
		}

		private function onCollect() : void {
			UI_Menu.instance.logicNotification.logicSubAlert.collectNew();
			refresh();
		}

		private function onRefresh() : void {
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.clear();
			viewSubscriberList.showLoading(true);
			UI_Menu.instance.logicNotification.logicSubAlert.refreshSubsFromTwitch(new Callback(refresh, this, null));
		}

		override public function refresh() : void {
			super.refresh();
			
			viewSubscriberList.setData(MetaGameProgress.instance.metaSubsConfig.listOfSubs.subscribers);
			viewSubscriberList.refresh();
			viewSubscriberList.showLoading(false);
		}
		

		public function get lastSubscriptionMc() : MovieClip {return visual.getChildByName("lastSubscriptionMc") as MovieClip;}
		public function get toolTipSubscriberMc() : MovieClip { return visual.getChildByName("toolTipSubscriberMc") as MovieClip;}
		
		public function get refreshBtn() : MovieClip { return visual.getChildByName("refreshBtn") as MovieClip;}
		public function get collectBtn() : MovieClip { return visual.getChildByName("collectBtn") as MovieClip;}
		public function get subAlertsMc() : MovieClip { return visual.getChildByName("subAlertsMc") as MovieClip;}
		public function get goalsMc() : MovieClip { return visual.getChildByName("goalsMc") as MovieClip;}
		public function get customAnimBtn() : MovieClip { return visual.getChildByName("customAnimBtn") as MovieClip;}
		public function get testFirstMc() : MovieClip { return visual.getChildByName("testFirstMc") as MovieClip;}
		
	}
}
