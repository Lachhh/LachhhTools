package com.giveawaytool.meta.donations {
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.giveawaytool.ui.ModelAlertTypeEnum;
	import com.giveawaytool.ui.MetaHasBeenTested;
	import com.giveawaytool.meta.MetaGameProgress;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonationsConfig {
		public var topDonation : MetaDonation = MetaDonation.createTopDefault();
		public var topDonationThisMonth : MetaDonation = MetaDonation.createTopDefault();
		public var topDonationThisDay : MetaDonation = MetaDonation.createTopDefault();
		public var topDonationThisWeek : MetaDonation = MetaDonation.createTopDefault();
		public var firstThisDay : MetaDonation = MetaDonation.createDateInTheFuture();
		
		public var allDonations : MetaDonationList = new MetaDonationList();
		public var metaRecurrentGoal:MetaDonationGoal = new MetaDonationGoal();
		public var metaBigGoal:MetaDonationGoal = new MetaDonationGoal();
		public var metaStreamTipConnection : MetaDonationSourceConnection = new MetaDonationSourceConnection();
		public var metaStreamLabsConnection : MetaDonationSourceConnection = MetaDonationSourceConnection.createStreamLabsConnection();
		public var metaAutoFetch : MetaDonationFetchTimer = new MetaDonationFetchTimer();
		public var metaCharity : MetaCharityConfig = new MetaCharityConfig();
		public var metaCustomAnim : MetaSelectAnimationConfig = new MetaSelectAnimationConfig();
		
		public var isDirty:Boolean = false;
		private var saveData : Dictionary = new Dictionary();
		public var metaHasBeenTested : MetaHasBeenTested = new MetaHasBeenTested(ModelAlertTypeEnum.DONATION);

		public function MetaDonationsConfig() {
			
		}
		
		public function clear():void {
			topDonation = MetaDonation.createTopDefault();
			topDonationThisMonth = MetaDonation.createTopDefault();
			topDonationThisDay = MetaDonation.createTopDefault();
			topDonationThisWeek = MetaDonation.createTopDefault();
			firstThisDay = MetaDonation.createDateInTheFuture();
			allDonations = new MetaDonationList();
			metaRecurrentGoal = new MetaDonationGoal();
			metaBigGoal = new MetaDonationGoal();
			metaAutoFetch = new MetaDonationFetchTimer();
			metaCharity = new MetaCharityConfig();
			metaCustomAnim = new MetaSelectAnimationConfig();
		}
				
		public function encode():Dictionary {
			//saveData["topDonation"] = topDonation.encode();
			//saveData["topDonationThisMonth"] = topDonationThisMonth.encode();
			//saveData["topDonationThisDay"] = topDonationThisDay.encode();
			saveData["lastDonators"] = allDonations.encode();
			saveData["metaRecurrentGoal"] = metaRecurrentGoal.encode();
			saveData["metaBigGoal"] = metaBigGoal.encode();
			saveData["metaStreamTipConnection"] = metaStreamTipConnection.encode();
			saveData["metaStreamLabsConnection"] = metaStreamLabsConnection.encode();
			
			
			saveData["metaAutoFetch"] = metaAutoFetch.encode();
			saveData["metaCharity"] = metaCharity.encode();
			saveData["metaCustomAnim"] = metaCustomAnim.encode();
			saveData["metaHasBeenTested"] = metaHasBeenTested.encode();
			
			
			return saveData; 
		}
				
		public function encodeForWidget():Dictionary {
			saveData["topDonation"] = topDonation.encode();
			saveData["topDonationThisMonth"] = topDonationThisMonth.encode();
			saveData["topDonationThisDay"] = topDonationThisDay.encode();
			saveData["topDonationThisWeek"] = topDonationThisWeek.encode();			
			saveData["firstThisDay"] = firstThisDay.encode();
			
			
			saveData["lastDonators"] = allDonations.encodeForWidget(this);
			saveData["metaRecurrentGoal"] = metaRecurrentGoal.encode();
			saveData["metaBigGoal"] = metaBigGoal.encode();
			saveData["numSubs"] = MetaGameProgress.instance.metaSubsConfig.getCrntSub();
			saveData["numSubsGoal"] = MetaGameProgress.instance.metaSubsConfig.goalSub;
			saveData["metaCharity"] = metaCharity.settings.encode();

			saveData["metaCustomAnim"] = metaCustomAnim.encodeWidget();
			saveData["jukebox"] = JukeBox.getInstance().encode();
			

			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			//topDonation.decode(loadData["topDonation"]);
			//topDonationThisMonth.decode(loadData["topDonationThisMonth"]);
			//topDonationThisDay.decode(loadData["topDonationThisDay"]);
			
			allDonations.decode(loadData["lastDonators"]);
			metaRecurrentGoal.decode(loadData["metaRecurrentGoal"]);
			metaBigGoal.decode(loadData["metaBigGoal"]);
			metaStreamTipConnection.decode(loadData["metaStreamTipConnection"]);
			metaStreamLabsConnection.decode(loadData["metaStreamLabsConnection"]);
			metaAutoFetch.decode(loadData["metaAutoFetch"]);
			metaCharity.decode(loadData["metaCharity"]);
			metaCustomAnim.decode(loadData["metaCustomAnim"]);
			metaHasBeenTested.decode(loadData["metaHasBeenTested"]);
			//numSubs = loadData["numSubs"];
			
		}
		
		public function addDonationToGoalsAndCharity(m:MetaDonation):void {
			if(metaBigGoal.isEnabled()) {
				metaBigGoal.crntAmount += m.amount;
				metaBigGoal.crntAmount = Math.floor(metaBigGoal.crntAmount*100)/100;
			}
			
			if(metaRecurrentGoal.isEnabled()) {
				metaRecurrentGoal.crntAmount += m.amount;
				while(metaRecurrentGoal.crntAmount >= metaRecurrentGoal.targetAmount) {
					 metaRecurrentGoal.crntAmount -= metaRecurrentGoal.targetAmount;
				}
				metaRecurrentGoal.crntAmount = Math.floor(metaRecurrentGoal.crntAmount*100)/100;
			}
			
			if(metaCharity.settings.isEnabled()) {
				metaCharity.settings.crntAmount += metaCharity.settings.getCharityCut(m.amount); 
				metaCharity.settings.crntAmount = Math.floor(metaCharity.settings.crntAmount*100)/100;
			}
		}
		
		public function addAllNewToGoal():void {
			for (var i : int = 0; i < allDonations.donations.length; i++) {
				var m:MetaDonation = allDonations.donations[i];
				if(m.isNew) {
					m.isNew = false;
					addDonationToGoalsAndCharity(m);
				}
			}
			
		}
		
		public function clearTopDonators():void {
			topDonation = MetaDonation.createTopDefault();
			topDonationThisMonth = MetaDonation.createTopDefault();
			topDonationThisDay = MetaDonation.createTopDefault();
			topDonationThisWeek = MetaDonation.createTopDefault();
			firstThisDay = MetaDonation.createDateInTheFuture();
		}
		
		public function updateTopDonatorsIfBetter():void {
			updateTopIfBetter(topDonation, allDonations.donationsByName);
			updateTopIfBetter(topDonationThisMonth, allDonations.donationsByNameThisMonth);
			updateTopIfBetter(topDonationThisDay, allDonations.donationsByNameThisDay);
			updateTopIfBetter(topDonationThisWeek, allDonations.donationsByNameThisWeek);
			updateTopIfNewer(firstThisDay, allDonations.donationsByNameThisDay);   
		}
		
		private function updateTopIfNewer(m:MetaDonation, mList:MetaDonatorCalculatedList):void {
			if(mList.firstDonator.date < m.date) {
				m.donatorName = mList.firstDonator.donatorName ;
				m.amount = mList.firstDonator.amount ;
			}
		}
		
		private function updateTopIfBetter(m:MetaDonation, mList:MetaDonatorCalculatedList):void {
			if(mList.topDonator.amount > m.amount) {
				m.donatorName = mList.topDonator.donatorName ;
				m.amount = mList.topDonator.amount ;
			}
		}
		
				
		
	}
}
