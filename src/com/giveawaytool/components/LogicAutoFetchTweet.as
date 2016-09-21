package com.giveawaytool.components {
	import com.giveawaytool.ui.UI_PlayMovies;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.giveawaytool.ui.UI_Donation;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.meta.MetaTweetAlertConfig;
	import com.giveawaytool.meta.donations.MetaDonationFetchTimer;
	import com.giveawaytool.ui.views.ViewDonationsEdit;
	import com.kojaktsl.TwitterAPI.LogicCheckForNewTweets;
	import com.kojaktsl.TwitterAPI.MetaTweet;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicAutoFetchTweet extends ActorComponent {
		private var timer : CallbackTimerEffect;
		public var metaTweetAlertConfig : MetaTweetAlertConfig;
		public var metaTimer : MetaDonationFetchTimer;
		public var tickCallback:Callback;
		private var tweetSearch : LogicCheckForNewTweets;
		public var tweetSearch2 : LogicCheckForNewTweets;
		

		public function LogicAutoFetchTweet(m : MetaTweetAlertConfig) {
			super();
			metaTweetAlertConfig = m;
			metaTimer = metaTweetAlertConfig.metaAutoFetch;
			tweetSearch = new LogicCheckForNewTweets(new Callback(onNewTweet, this, null));
			tweetSearch2 = new LogicCheckForNewTweets(new Callback(onNewTweet2, this, null));
			
		}

		override public function start() : void {
			super.start();
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, 1000);
			metaTimer.resetTimer();
			metaTimer.secondsLeft = 3;
		}

		private function tick() : void {
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, 1000);
			
			if(!metaTimer.enabled) return;
			metaTimer.secondsLeft -= 1;
			if(metaTimer.secondsLeft <= 0) {
				onEndTimer();
			}
			
			if(tickCallback) tickCallback.call();
			var ui:UI_PlayMovies = UIBase.manager.getFirst(UI_PlayMovies) as UI_PlayMovies;
			if(ui) ui.viewTwitter.refreshTimer();
		}
		
		private function onEndTimer():void {

			if(!UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessTweets()) return ;
			
			tweetSearch.twitter = metaTweetAlertConfig.getTwitter();
			tweetSearch2.twitter = metaTweetAlertConfig.getTwitter();
			
			tweetSearch.searchTweets("lachhh.tv");
			tweetSearch2.searchTweets("#Lachhhisters");
			
			metaTimer.resetTimer();
		}
		
		private function onNewTweet(metaTweet:MetaTweet):void {
			if(metaTweet == null) return;
			var m:MetaTwitterAlert = MetaTwitterAlert.createFromMetaTweet(metaTweet);
			m.searchedFor = "lachhh.tv";
			
			UI_Menu.instance.logicNotification.logicSendToWidget.sendTwitterAlert(m);
		}
		
		private function onNewTweet2(metaTweet:MetaTweet):void {
			if(metaTweet == null) return;
			var m:MetaTwitterAlert = MetaTwitterAlert.createFromMetaTweet(metaTweet);
			m.searchedFor = "#Lachhhisters";
			
			UI_Menu.instance.logicNotification.logicSendToWidget.sendTwitterAlert(m);
		}

		override public function destroy() : void {
			super.destroy();
			timer.destroyAndRemoveFromActor();
		}


	}
}
