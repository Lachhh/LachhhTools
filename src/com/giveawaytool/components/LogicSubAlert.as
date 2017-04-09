package com.giveawaytool.components {
	import com.giveawaytool.ui.ModelSubcriberSourceEnum;
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.io.playerio.MetaGameWispSub;
	import com.MetaIRCMessage;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.io.playerio.GameWispConnection;
	import com.giveawaytool.io.playerio.MetaGameWispSubGroup;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.MetaSubcriberAlert;
	import com.giveawaytool.ui.UI_FollowSubAlert;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.views.MetaFollower;
	import com.giveawaytool.ui.views.MetaFollowerList;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class LogicSubAlert extends ActorComponent {
		private var logicChat : LogicTwitchChat;
		private var timer : CallbackTimerEffect;
		private var subCheckDelay:Number = 1000*60;

		public function LogicSubAlert(pLogicChat : LogicTwitchChat) {
			super();
			logicChat = pLogicChat;
			logicChat.callbackMsgReceived.addCallback(new Callback(onMsgReceived, this, null));
		}

		override public function start() : void {
			super.start();
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, subCheckDelay);
		}
		
		public function tick():void{
			refreshSubsOnGameWisp();
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, subCheckDelay);
			trace("LogicSubAlert : tick");
		}

		public function refreshSubsOnGameWisp() : void {
			if(!GameWispConnection.getInstance().isConnected()) return ;
			GameWispConnection.getInstance().refreshSubs(new Callback(OnDataLoaded, this, null), MetaGameProgress.instance.metaGameWispConnection.channelInfo);
		}
		
		public function OnDataLoaded():void{
			var metaData:MetaGameWispSubGroup = GameWispConnection.getInstance().metaChannelSubsGroup;
			
			HandleGameWispSub(metaData);
			
			trace("Looking for new followers...");
		}
		
		public function HandleGameWispSub(metaData:MetaGameWispSubGroup):void{
			
			//TEST_removeFlamingStatusLocally();
			
			for (var i : int = 0; i < metaData.listOfSub.length; i++) {
				var mGameWisp:MetaGameWispSub = metaData.listOfSub[i];
				var mSub:MetaSubscriber = mGameWisp.toMetaSub();
				MetaGameProgress.instance.metaSubsConfig.listOfSubs.addGameWispSubIfNewOrNowActive(mSub);
				
			}
			
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.sortByDate();
			
			if(MetaGameProgress.instance.metaSubsConfig.alertOnGameWispSub) {
				collectNew();	
			} else {
				MetaGameProgress.instance.metaSubsConfig.listOfSubs.setAllNew(false);
			}
			
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refreshAll(UI_FollowSubAlert);
		}
		
		private function TEST_changeFlamingStatusLocally() : void {
			var m : MetaSubscriber = MetaGameProgress.instance.metaSubsConfig.listOfSubs.getMetaSubByNameAndSource("flamingmonocle", ModelSubcriberSourceEnum.GAMEWISP);
			if(m.isNull()) return ;
			m.metaGameWispSubInfo.status = "grace_peciod";
		}
		
		private function TEST_removeFlamingStatusLocally() : void {
			var m : MetaSubscriber = MetaGameProgress.instance.metaSubsConfig.listOfSubs.getMetaSubByNameAndSource("flamingmonocle", ModelSubcriberSourceEnum.GAMEWISP);
			if(m.isNull()) return ;
		
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.remove(m);
		}

		private function onMsgReceived() : void {
			var lastMsg:MetaIRCMessage = logicChat.lastMsgReceived;
			
			if(lastMsg == null) return ;
		
			if(lastMsg.isNewSubAlert() || lastMsg.isReSubAlert()) {
				var newSub:MetaSubcriberAlert = MetaSubcriberAlert.createFromIRCMsg(lastMsg);
				
				if(canAlert(lastMsg)){
					UI_Menu.instance.logicNotification.logicSendToWidget.sendSubscriberAlert(newSub);
					MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerFromSubscription();
				}
				newSub.metaSubscriber.isNew = false;
				MetaGameProgress.instance.metaSubsConfig.listOfSubs.updateMetaSub(newSub.metaSubscriber);
				MetaGameProgress.instance.metaSubsConfig.listOfSubs.sortByDate();
				UIBase.manager.refreshAll(UI_FollowSubAlert);
			}	
		}
		
		public function canAlert(mMsg:MetaIRCMessage):Boolean {
			if(!UI_Menu.instance.logicNotification.logicVIPAccess.canSendSubIfNotLive()) return false;
			if(mMsg.isReSubAlert() && MetaGameProgress.instance.metaSubsConfig.alertOnReSub) return true;
			if(mMsg.isNewSubAlert() && MetaGameProgress.instance.metaSubsConfig.alertOnNewSub) return true;
			return false;
		}

		
		static public function addToActor(actor: Actor, chat:LogicTwitchChat): LogicSubAlert {
			var result: LogicSubAlert = new LogicSubAlert(chat);
			actor.addComponent(result);
			return result;
		}

		public function refreshSubsFromTwitch(c : Callback) : void {
			TwitchConnection.instance.refreshSub(new Callback(refreshSubOnGameWisp, this, null), c);
		}
		
		private function refreshSubOnGameWisp():void {
			
			if(GameWispConnection.getInstance().isConnected()) {
				GameWispConnection.getInstance().refreshSubs(new Callback(onGameWispSubRefresh, this, null), MetaGameProgress.instance.metaGameWispConnection.channelInfo);
			} else {
				GameWispConnection.getInstance().metaChannelSubsGroup.clear();
				mergeTwitchSubsInSavedList();
				UIBase.manager.refreshAll(UI_FollowSubAlert);
			}
			
		}
		
		public function onGameWispSubRefresh():void {
			mergeTwitchSubsInSavedList();
			UIBase.manager.refreshAll(UI_FollowSubAlert);
		}
		
		public function mergeTwitchSubsInSavedList():void {
			var listOfTwitchSub:MetaSubscribersList = TwitchConnection.instance.listOfSubs;
			var listOfGameWispSub:MetaSubscribersList = GameWispConnection.getInstance().metaChannelSubsGroup.toMetaSubList();
			
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.appendIfNotSameNameAndSource(listOfTwitchSub);
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.appendIfNotSameNameAndSource(listOfGameWispSub);
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.sortByDate();
		}

		public function collectNew():void {
			UI_Menu.instance.logicNotification.logicSendToWidget.sendAllNewSubscriber(MetaGameProgress.instance.metaSubsConfig.listOfSubs);
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.setAllNew(false);
		}
	}
}
