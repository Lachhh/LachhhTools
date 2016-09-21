package com.giveawaytool.io.twitch {
	import com.animation.exported.UI_MENU;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_FollowSubAlert;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.views.MetaFollower;
	import com.giveawaytool.ui.views.MetaFollowerList;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;
	
	public class LogicFollowAlert extends ActorComponent {
		
		private var followerCheckDelay:int = 1 * 1000;
		
		private var timer:CallbackTimerEffect ;
		
		public function LogicFollowAlert() {
		}

		override public function start() : void {
			super.start();
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, followerCheckDelay);
		}
		
		public function tick():void{
			refreshFollowers();
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, 1000*60);
			trace("LogicFollowAlert : tick");
		}

		public function refreshFollowers() : void {
			if(!TwitchConnection.instance.isConnected()) return ;
			TwitchConnection.instance.refreshFollowers(new Callback(OnDataLoaded, this, null), null);
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
					var isNew:Boolean = MetaGameProgress.instance.metaFollowConfig.metaFollowers.addIfNameNotInList(m);
					m.isNew = isNew;
				}
			}
			
			MetaGameProgress.instance.metaFollowConfig.metaFollowers.sortByDate();
			collectNew();
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refreshAll(UI_FollowSubAlert);
			
		}
		
		public function collectNew() : void {
			if (canAlert()) UI_Menu.instance.logicNotification.logicSendToWidget.sendAllNewFollow(MetaGameProgress.instance.metaFollowConfig.metaFollowers);
			MetaGameProgress.instance.metaFollowConfig.metaFollowers.setAllNew(false);
		}

		private function canAlert() : Boolean {
			if(!UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessFollow()) return false;
			return MetaGameProgress.instance.metaFollowConfig.alertOnNewFollow;
		}
		
		public function NotifyOfNewFollower(metaFollower:MetaFollower):void{
			MetaGameProgress.instance.metaFollowConfig.metaFollowers.addIfNameNotInList(metaFollower);
		}
		
	
	}
	
}
