package com.giveawaytool.io.twitch {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.giveawaytool.ui.views.MetaFollowerList;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.MetaFollower;
	import com.giveawaytool.components.MetaFollowAlert;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	public class LogicFollowAlert extends ActorComponent {
		
		private var followerCheckDelay:int = 1 * 60 * 1000;
		
		private var timer:Timer = new Timer(followerCheckDelay);
		
		public function LogicFollowAlert() {
			timer.addEventListener(TimerEvent.TIMER, OnTimer);
			timer.start();
		}
		
		public function refreshFollowers():void{
			if(!TwitchConnection.instance.isConnected()) return ;
			TwitchConnection.instance.refreshFollowers(new Callback(OnDataLoaded, this, null), null);
			timer.reset();
			timer.start();
		}
		
		public function OnDataLoaded():void{
			var metaData:MetaFollowerList = TwitchConnection.instance.followersData;
		
			HandleFollowers(metaData);
			
			trace("Looking for new followers...");
		}
		
		public function HandleFollowers(metaData:MetaFollowerList):void{
			
			if(MetaGameProgress.instance.metaFollowConfig.metaFollowers.isEmpty()) {
				MetaGameProgress.instance.metaFollowConfig.metaFollowers.clone(metaData);
			} else {
				for (var i : int = 0; i < metaData.followers.length; i++) {
					var m:MetaFollower = metaData.getMetaFollower(i);
					MetaGameProgress.instance.metaFollowConfig.metaFollowers.addIfNameNotInList(m);
				}
			}
			
			MetaGameProgress.instance.metaFollowConfig.metaFollowers.sortByDate();
			collectNew();
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refresh();
		}
		
		public function collectNew():void {
			UI_Menu.instance.logicNotification.logicSendToWidget.sendAllNewFollow(MetaGameProgress.instance.metaFollowConfig.metaFollowers);
			MetaGameProgress.instance.metaFollowConfig.metaFollowers.setAllNew(false);
		}
		
		public function NotifyOfNewFollower(metaFollower:MetaFollower):void{
			MetaGameProgress.instance.metaFollowConfig.metaFollowers.addIfNameNotInList(metaFollower);
		}
		
		public function OnTimer(event:Event):void{
			refreshFollowers();
		}
	}
	
}
