package com.giveawaytool.components {
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.lachhh.io.Callback;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.io.twitch.LogicFollowAlert;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicNotifications extends ActorComponent {
		public var logicSendToWidget: LogicSendToWidget;
		public var logicSendToWidgetPlayMovie: LogicSendToWidget;
		
		public var logicDonationsAutoFetch : LogicAutoFetchDonation;
		public var logicSubAlert : LogicSubAlert;
		public var logicHostAlert : LogicHostAlert;
		public var logicTweetAutoFetch : LogicAutoFetchTweet;
		public var logicListenToChat: LogicTwitchChat;
		public var logicFollowAlert : LogicFollowAlert;
		public var logicGiveAwayAutoChat : LogicGiveawayAutoChat;
		
		
		public var metaGameProgress:MetaGameProgress;
		
		//private var simpleIRCBot : SimpleIRCBot;
		
		public function LogicNotifications(m:MetaGameProgress) {
			super();
			metaGameProgress = m;
		}

		override public function start() : void {
			super.start();
			
			logicListenToChat = actor.addComponent(new LogicTwitchChat()) as LogicTwitchChat;
			logicDonationsAutoFetch = actor.addComponent(new LogicAutoFetchDonation(metaGameProgress.metaDonationsConfig.metaAutoFetch)) as LogicAutoFetchDonation;
			logicTweetAutoFetch = actor.addComponent(new LogicAutoFetchTweet(metaGameProgress.metaTweetAlertConfig)) as LogicAutoFetchTweet;
			logicSubAlert = actor.addComponent(new LogicSubAlert(logicListenToChat)) as LogicSubAlert;	
			logicHostAlert = actor.addComponent(new LogicHostAlert(logicListenToChat)) as LogicHostAlert;
			logicSendToWidget = actor.addComponent(new LogicSendToWidget(9231)) as LogicSendToWidget;
			logicSendToWidgetPlayMovie = actor.addComponent(new LogicSendToWidget(9232)) as LogicSendToWidget;
			logicFollowAlert = actor.addComponent(new LogicFollowAlert()) as LogicFollowAlert;
			logicGiveAwayAutoChat = actor.addComponent(new LogicGiveawayAutoChat(logicListenToChat)) as LogicGiveawayAutoChat;
			
			//logicListenToChat.connect(oauth);
		}
		
		public function onConectedToTwitch():void {
			logicListenToChat.callbackOnConnectGroup.addCallback(new Callback(onConnectToChat, this, null));
			logicListenToChat.quickConnect();
			
			logicFollowAlert.refreshFollowers();
			logicSubAlert.mergeTwitchSubsInSavedList();
			
		}
		
		private function onConnectToChat():void {
			
			TwitchConnection.instance.refreshMods(logicListenToChat, null, null);
		}
	}
}
