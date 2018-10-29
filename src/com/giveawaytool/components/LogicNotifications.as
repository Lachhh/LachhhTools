package com.giveawaytool.components {
	import com.animation.exported.UI_LOADING;
	import com.LogicTransferFileToUserDoc;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.io.playerio.MetaServerProgress;
	import com.giveawaytool.io.twitch.LogicFollowAlert;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.io.twitch.emotes.LogicListenForEmotes;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_Loading;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class LogicNotifications extends ActorComponent {
		public var logicSendToWidgetAuth: LogicSendToWidget;
		public var logicSendToWidget: LogicSendToWidget;
		public var logicSendToWidgetPlayMovie: LogicSendToWidget;
		
		public var logicDonationsAutoFetch : LogicAutoFetchDonation;
		public var logicSubAlert : LogicSubAlert;
		public var logicHostAlert : LogicHostAlert;
		public var logicCheerAlert : LogicCheerAlert;
		public var logicTweetAutoFetch : LogicAutoFetchTweet;
		public var logicListenToChat: LogicTwitchChat;
		public var logicFollowAlert : LogicFollowAlert;
		public var logicListenForEmotes:LogicListenForEmotes;
		
		public var logicGiveAwayAutoChat : LogicGiveawayAutoChat;
		public var logicVIPAccess : LogicVIPAccess;
		public var logicGameWisp : LogicIsSubToLachhh;
		
		
		
		public var metaGameProgress:MetaGameProgress;
		
		//private var simpleIRCBot : SimpleIRCBot;
		
		public function LogicNotifications(m:MetaGameProgress) {
			super();
			LogicTransferFileToUserDoc.execute();
			metaGameProgress = m;
			//Security.loadPolicyFile("http://www.berzerkstudio.com/crossdomain.xml");
		}

		override public function start() : void {
			super.start();
			
			logicListenToChat = actor.addComponent(new LogicTwitchChat()) as LogicTwitchChat;
			logicDonationsAutoFetch = actor.addComponent(new LogicAutoFetchDonation(metaGameProgress.metaDonationsConfig.metaAutoFetch)) as LogicAutoFetchDonation;
			logicTweetAutoFetch = actor.addComponent(new LogicAutoFetchTweet(metaGameProgress.metaTweetAlertConfig)) as LogicAutoFetchTweet;
			logicSubAlert = actor.addComponent(new LogicSubAlert(logicListenToChat)) as LogicSubAlert;	
			logicHostAlert = actor.addComponent(new LogicHostAlert(logicListenToChat)) as LogicHostAlert;
			logicCheerAlert = actor.addComponent(new LogicCheerAlert(logicListenToChat)) as LogicCheerAlert;
			logicSendToWidget = actor.addComponent(new LogicSendToWidget(9231, true)) as LogicSendToWidget;
			logicSendToWidgetAuth = actor.addComponent(new LogicSendToWidget(9233, false)) as LogicSendToWidget;
			logicSendToWidgetPlayMovie = actor.addComponent(new LogicSendToWidget(9232, true)) as LogicSendToWidget;
			logicFollowAlert = actor.addComponent(new LogicFollowAlert()) as LogicFollowAlert;
			logicGiveAwayAutoChat = actor.addComponent(new LogicGiveawayAutoChat(logicListenToChat)) as LogicGiveawayAutoChat;
			logicGameWisp = actor.addComponent(new LogicIsSubToLachhh()) as LogicIsSubToLachhh;
			logicListenForEmotes = LogicListenForEmotes.addToActor(actor, logicListenToChat);
			
			logicVIPAccess = actor.addComponent(new LogicVIPAccess()) as LogicVIPAccess;

			refreshIfIsLive();
		}
		
		private function refreshIfIsLive():void {
			if(TwitchConnection.instance != null) TwitchConnection.instance.checkIfIsLive();
			CallbackTimerEffect.addWaitCallFctToActor(actor, refreshIfIsLive, 1000*60*3);
			
		}
		
		
		public function onConectedToTwitch():void {
			logicListenToChat.callbackOnConnectGroup.addCallback(new Callback(onConnectToChat, this, null));
			logicListenToChat.quickConnect();
			
			logicFollowAlert.refreshFollowers();
			logicSubAlert.mergeTwitchSubsInSavedList();
			
			
			logicGameWisp.connect(new Callback(onGameWispDone, this, null));
		}
		
		public function onGameWispDone():void {
			
			//if(TwitchConnection.instance.isLachhhAndFriends()) {
				//UI_Loading.show("Refreshing DB because you're Lachhh");
				//MetaServerProgress.instance.refreshTwitchSub(TwitchConnection.instance.accessToken, new Callback(onAllDone, this, null), new Callback(onAllDone, this, null));
			//} else {
				UI_Loading.show("Checking if you're sub to Lachhh");
				MetaServerProgress.instance.refreshTwitchSubLachhh(TwitchConnection.instance.accessToken, TwitchConnection.getAccountId(),  new Callback(onAllDone, this, null), new Callback(onAllDone, this, null));
			//}
			
			
		}
		
		private function onAllDone():void {
			UI_Loading.hide();
			
			logicGameWisp.checkToShowAds();
			
			UIBase.manager.refresh();
		}
		
		private function onConnectToChat():void {
			
			TwitchConnection.instance.refreshMods(logicListenToChat, null, null);
		}
	}
}
