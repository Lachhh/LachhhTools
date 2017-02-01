package com.giveawaytool.components {
	import com.giveawaytool.ui.UI_FollowSubAlert;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.MetaIRCMessage;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.ui.MetaSubcriberAlert;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicSubAlert extends ActorComponent {
		private var logicChat : LogicTwitchChat;
		
		

		public function LogicSubAlert(pLogicChat: LogicTwitchChat) {
			super();
			logicChat = pLogicChat;
			logicChat.callbackMsgReceived.addCallback(new Callback(onMsgReceived, this, null));
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
			TwitchConnection.instance.refreshSub(new Callback(mergeAndRefresh, this, null), c);
		}
		
		private function mergeAndRefresh():void {
			mergeTwitchSubsInSavedList();
			UIBase.manager.refreshAll(UI_FollowSubAlert);
		}
		
		public function mergeTwitchSubsInSavedList():void {
			var listOfTwitchSub:MetaSubscribersList = TwitchConnection.instance.listOfSubs;
			//MetaGameProgress.instance.metaSubsConfig.clear();
			for (var i : int = 0; i < listOfTwitchSub.subscribers.length; i++) {
				var m:MetaSubscriber = listOfTwitchSub.getMetaSubscriber(i);
				if(!MetaGameProgress.instance.metaSubsConfig.listOfSubs.containsName(m.name)) {
					MetaGameProgress.instance.metaSubsConfig.listOfSubs.add(m);
				}
			}
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.sortByDate();
		}

		public function collectNew():void {
			UI_Menu.instance.logicNotification.logicSendToWidget.sendAllNewSubscriber(MetaGameProgress.instance.metaSubsConfig.listOfSubs);
			MetaGameProgress.instance.metaSubsConfig.listOfSubs.setAllNew(false);
		}
	}
}
