package com.giveawaytool.components {
	import com.giveawaytool.io.DonationSourceConnection;
	import com.giveawaytool.io.DonationSourceRequest;
	import com.giveawaytool.ui.views.ViewDonationsEdit;
	import com.lachhh.io.Callback;
	import com.giveawaytool.meta.donations.MetaDonationFetchTimer;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicAutoFetchDonation extends ActorComponent {
		private var timer : CallbackTimerEffect;
		public var metaTimer : MetaDonationFetchTimer;
		public var collectCallback:Callback;
		public var uiDonationEdit:ViewDonationsEdit;
		
		public var donationSourceConnection:DonationSourceConnection;
		public function LogicAutoFetchDonation(m:MetaDonationFetchTimer) {
			super();
			metaTimer = m;
			donationSourceConnection = new DonationSourceConnection();
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
			uiDonationEdit.viewAutoFetch.refresh();
		}
		
		private function onEndTimer():void {
			var r:DonationSourceRequest = uiDonationEdit.loadNewData(true);
			if(metaTimer.autoCollect) {
				r.onSuccess.addCallback(new Callback(uiDonationEdit.collectAllNewDonations, this, [true]));
			}
			metaTimer.resetTimer();
		}

		override public function destroy() : void {
			super.destroy();
			timer.destroyAndRemoveFromActor();
		}


	}
}
