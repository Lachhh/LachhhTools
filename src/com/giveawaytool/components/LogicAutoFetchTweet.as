package com.giveawaytool.components {
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
		public var collectCallback:Callback;
		private var tweetSearch : LogicCheckForNewTweets;
		public var uiDonation : UI_Donation;
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
		}

		private function tick() : void {
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, 1000);
			
			if(!metaTimer.enabled) return;
			metaTimer.secondsLeft -= 1;
			if(metaTimer.secondsLeft <= 0) {
				onEndTimer();
			}
			uiDonation.viewDonationsEdit.viewTweetConnection.refresh();
		}
		
		private function onEndTimer():void {
			/*var r:StreamTipRequest = uiDonationEdit.loadNewData(true);
			if(metaTimer.autoCollect) {
				r.onSuccess.addCallback(new Callback(uiDonationEdit.collectAllNewDonations, this, [true]));
			}*/
			tweetSearch.twitter = metaTweetAlertConfig.getTwitter();
			tweetSearch2.twitter = metaTweetAlertConfig.getTwitter();
			//tweetSearch.searchTweets("#Lachhhisters");
			//tweetSearch.searchTweets("@LachhhAndFriends");
			tweetSearch.searchTweets("lachhh.tv");
			tweetSearch2.searchTweets("#Lachhhisters");
			//tweetSearch.searchTweets("twitch.tv/LachhAndFriends");
			metaTimer.resetTimer();
		}
		
		private function onNewTweet(metaTweet:MetaTweet):void {
			if(metaTweet == null) return;
			var m:MetaTwitterAlert = MetaTwitterAlert.createFromMetaTweet(metaTweet);
			m.searchedFor = "lachhh.tv";
			
			uiDonation.sendTwitterAlert(m);
		}
		
		private function onNewTweet2(metaTweet:MetaTweet):void {
			if(metaTweet == null) return;
			var m:MetaTwitterAlert = MetaTwitterAlert.createFromMetaTweet(metaTweet);
			m.searchedFor = "#Lachhhisters";
			
			uiDonation.sendTwitterAlert(m);
		}

		override public function destroy() : void {
			super.destroy();
			timer.destroyAndRemoveFromActor();
		}


	}
}
