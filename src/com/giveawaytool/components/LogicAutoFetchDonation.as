package com.giveawaytool.components {
	import com.animation.exported.UI_DONATION;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.io.DonationSourceConnection;
	import com.giveawaytool.io.DonationSourceRequest;
	import com.giveawaytool.io.twitch.streamlabs.StreamLabsConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.donations.MetaDonationFetchTimer;
	import com.giveawaytool.ui.UI_Donation;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.UI_PopUp;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class LogicAutoFetchDonation extends ActorComponent {
		private var timer : CallbackTimerEffect;
		public var metaTimer : MetaDonationFetchTimer;
		public var collectCallback:Callback;
		public var logicStreamLabs : LogicStreamLabs;

		
		public var donationSourceConnection : DonationSourceConnection;
		public var donationSourceConnectionStreamLabs : DonationSourceConnection;

		public function LogicAutoFetchDonation(m : MetaDonationFetchTimer) {
			super();
			metaTimer = m;
			donationSourceConnection = new DonationSourceConnection();
			donationSourceConnection.metaStreamTipConnection = MetaGameProgress.instance.metaDonationsConfig.metaStreamTipConnection;
			
			donationSourceConnectionStreamLabs = new DonationSourceConnection();
			donationSourceConnectionStreamLabs.metaStreamTipConnection = MetaGameProgress.instance.metaDonationsConfig.metaStreamLabsConnection;
			
			metaTimer.secondsLeft = 1;
		}

		override public function start() : void {
			super.start();
			
			logicStreamLabs = new LogicStreamLabs();
			logicStreamLabs.onConnect = new Callback(onEndTimer, this, null);
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, 1000);
			metaTimer.resetTimer();
			onEndTimer();
		}

		private function tick() : void {
			timer = CallbackTimerEffect.addWaitCallFctToActor(actor, tick, 1000);
			
			if(!metaTimer.enabled) return;
			metaTimer.secondsLeft -= 1;
			if(metaTimer.secondsLeft <= 0) {
				onEndTimer();
			}
		}
		
		
		
		private function onEndTimer():void {
			var r:DonationSourceRequest = donationSourceConnection.retrieveLast25Donations(new Callback(setDataToConfig, this, null), new Callback(onLoadDataError, this, [true]));
			
			if(metaTimer.autoCollect) {
				r.onSuccess.addCallback(new Callback(collectAllNewDonations, this, null));
			}
			requestStreamLabs();
			metaTimer.resetTimer();
			
			var uiDon:UI_Donation = (UIBase.manager.getFirst(UI_Donation) as UI_Donation);
			if(uiDon) uiDon.viewDonationsEdit.viewDonationsList.showLoading(true);
		}
		
		private function requestStreamLabs():void {
			var r:DonationSourceRequest = donationSourceConnectionStreamLabs.retrieveLast25Donations(new Callback(setDataToConfig, this, null), new Callback(onLoadDataError, this, [true]));
			
			if(metaTimer.autoCollect) {
				r.onSuccess.addCallback(new Callback(collectAllNewDonations, this, null));
			}
		}
		
		private function onLoadDataError(silent:Boolean):void {
			if(!silent) UI_PopUp.createOkOnly("Oops, something wrong happened.  Verify your " + VersionInfo.donationSource.name + " settings.", null);
			refresh();
		}
		
		public function setDataToConfig():void {
			MetaGameProgress.instance.metaDonationsConfig.allDonations.addFromSource(donationSourceConnection.lastDonations);
			MetaGameProgress.instance.metaDonationsConfig.allDonations.addFromSource(donationSourceConnectionStreamLabs.lastDonations);
			MetaGameProgress.instance.metaDonationsConfig.allDonations.refreshTopDonator();
			MetaGameProgress.instance.metaDonationsConfig.updateTopDonatorsIfBetter();
			MetaGameProgress.instance.metaDonationsConfig.allDonations.sortByDate();
			UIBase.manager.refresh();
			var uiDon:UI_Donation = (UIBase.manager.getFirst(UI_Donation) as UI_Donation);
			if(uiDon) uiDon.viewDonationsEdit.viewDonationsList.showLoading(false);
		}
		
		public function collectAllNewDonations():void {
			var collectedAmount:Number = MetaGameProgress.instance.metaDonationsConfig.allDonations.getAmountTotalOfNew();
			if(collectedAmount > 0) {
				if(canAlert()) {
					UI_Menu.instance.logicNotification.logicSendToWidget.sendAllNewDonation(MetaGameProgress.instance.metaDonationsConfig.allDonations);
					if(collectedAmount >= 5){
						MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerFromDonation();
					}
				}
				MetaGameProgress.instance.metaDonationsConfig.addAllNewToGoal();
				MetaGameProgress.instance.saveToLocal();
			}
		}
		
		private function canAlert():Boolean {
			if(!UI_Menu.instance.logicNotification.logicVIPAccess.canSendDonationIfNotLive()) return false;
			return true;
		}

		override public function destroy() : void {
			super.destroy();
			timer.destroyAndRemoveFromActor();
		}
	}
}
