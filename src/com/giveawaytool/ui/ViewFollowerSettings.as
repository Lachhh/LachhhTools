package com.giveawaytool.ui {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewFollowerToolTip;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewFollowerSettings extends ViewBase {
		public var viewFollowList : ViewFollowersList;
		//public var viewFollowGoals : ViewFollowersGoal;
		public var viewFollowAlert : ViewFollowersAlert;
		public var viewFollowToolTip : ViewFollowerToolTip;
		public function ViewFollowerSettings(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			viewFollowList = new ViewFollowersList(screen, lastFollowersMc);
			//viewFollowGoals = new ViewFollowersGoal(screen, followGoal);
			viewFollowAlert = new ViewFollowersAlert(screen, alertsMc);
			viewFollowToolTip = new ViewFollowerToolTip(screen, toolTipFollowerMc);
			viewFollowList.toolTip = viewFollowToolTip; 
			
			screen.setNameOfDynamicBtn(refreshBtn, "Refresh");
			screen.setNameOfDynamicBtn(collectBtn, "Alert New");

			screen.registerClick(refreshBtn, onRefresh);
			screen.registerClick(collectBtn, onCollect);
			viewFollowList.showLoading(true);
			refresh();
		}

		private function onCollect() : void {
			UI_Menu.instance.logicNotification.logicFollowAlert.collectNew();
			refresh();
		}

		private function onRefresh() : void {
			viewFollowList.showLoading(true);
			UI_Menu.instance.logicNotification.logicFollowAlert.refreshFollowers();
		}


		override public function refresh() : void {
			super.refresh();
			viewFollowList.setData(MetaGameProgress.instance.metaFollowConfig.metaFollowers.followers);
			viewFollowList.refresh();
			viewFollowList.showLoading(false);
			
			followersTxt.text = TwitchConnection.instance.channelData.numFollowers +"";
		}

		public function get lastFollowersMc() : MovieClip {return visual.getChildByName("lastFollowersMc") as MovieClip;}
		public function get alertsMc() : MovieClip { return visual.getChildByName("alertsMc") as MovieClip;}
		//public function get followGoal() : MovieClip { return visual.getChildByName("followGoal") as MovieClip;}
		public function get titleTxt() : TextField { return visual.getChildByName("titleTxt") as TextField;}
		public function get toolTipFollowerMc() : MovieClip { return visual.getChildByName("toolTipFollowerMc") as MovieClip;}
		
		public function get refreshBtn() : MovieClip { return visual.getChildByName("refreshBtn") as MovieClip;}
		public function get collectBtn() : MovieClip { return visual.getChildByName("collectBtn") as MovieClip;}
		public function get followersTxt() : TextField { return visual.getChildByName("followersTxt") as TextField;}
		
	}
}
