package com.giveawaytool.meta {
	import com.lachhh.lachhhengine.sfx.JukeBox;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonationsConfig {
		public var topDonation : MetaDonation = MetaDonation.createTopDefault();
		public var topDonationThisMonth : MetaDonation = MetaDonation.createTopDefault();
		public var topDonationThisWeek : MetaDonation = MetaDonation.createTopDefault();
		public var topDonationThisDay : MetaDonation = MetaDonation.createTopDefault();
		public var firstThisDay : MetaDonation = MetaDonation.createTopDefault();
		public var lastDonators : MetaDonationList = new MetaDonationList();
		public var metaRecurrentGoal:MetaDonationGoal = new MetaDonationGoal();
		public var metaBigGoal : MetaDonationGoal = new MetaDonationGoal();
		public var metaCharity : MetaCharityPrct = new MetaCharityPrct();
		public var metaCustomAnim : MetaSelectAnimationConfig = new MetaSelectAnimationConfig();
		public var numLastToShow:int = 5;
		public var numSubs:int = 62;
		public var numSubsGoal:int = 100;
		
		private var saveData : Dictionary = new Dictionary();

		public function MetaDonationsConfig() {
			
		}
		
		public function clear():void {
			topDonation.clear();
			topDonationThisMonth.clear();
			topDonationThisWeek.clear();
			topDonationThisDay.clear();
			lastDonators = new MetaDonationList();
			metaRecurrentGoal = new MetaDonationGoal();
			metaBigGoal = new MetaDonationGoal();
			metaCharity = new MetaCharityPrct();
			metaCustomAnim = new MetaSelectAnimationConfig();
		}
		
		public function addDonation(m:MetaNewDonation):void {
			setTopDonationIfHigher(topDonationThisDay, m, m.amountThisDay);
			setTopDonationIfHigher(topDonationThisWeek, m, m.amountThisWeek);
			setTopDonationIfHigher(topDonationThisMonth, m, m.amountThisMonth);
			setTopDonationIfHigher(topDonation, m, m.amountAllTime);
			
			if(firstThisDay.isEmpty()) firstThisDay = m;
			
			lastDonators.add(m);
			
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
			
			if(metaCharity.isEnabled()) {
				metaCharity.crntAmount += metaCharity.getCharityCut(m.amount);
			}
		}
		
		private function setTopDonationIfHigher(theTop:MetaDonation, newDonation:MetaNewDonation, amountTotal:int):void {
			if(amountTotal <= theTop.amount) return ;
			theTop.decode(newDonation.encode());
			theTop.amount = amountTotal; 
		}
				
		public function encode():Dictionary {
			saveData["topDonation"] = topDonation.encode();
			saveData["lastDonators"] = lastDonators.encode();
			saveData["metaRecurrentGoal"] = metaRecurrentGoal.encode();
			saveData["metaCharity"] = metaCharity.encode();
			
			saveData["metaBigGoal"] = metaBigGoal.encode();
			saveData["numSubs"] = numSubs;
			saveData["numSubsGoal"] = numSubsGoal;
			
			
			//saveData["metaStreamTipConnection"] = metaStreamTipConnection.encode();
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			topDonation.decode(loadData["topDonation"]);
			topDonationThisMonth.decode(loadData["topDonationThisMonth"]);
			topDonationThisDay.decode(loadData["topDonationThisDay"]);
			topDonationThisWeek.decode(loadData["topDonationThisWeek"]);
			firstThisDay.decode(loadData["firstThisDay"]);
			
			lastDonators.decode(loadData["lastDonators"]);
			metaRecurrentGoal.decode(loadData["metaRecurrentGoal"]);
			metaBigGoal.decode(loadData["metaBigGoal"]);
			metaCharity.decode(loadData["metaCharity"]);
			metaCustomAnim.decode(loadData["metaCustomAnim"]);
			
			numSubs = loadData["numSubs"];
			numSubsGoal = loadData["numSubsGoal"];
			JukeBox.getInstance().decode(loadData["jukebox"]);
			
		}
		
		public function getTopDonatorsMsg():String {
			if(topDonationThisDay == null) return "This month : None";
			return "This month : " + topDonationThisMonth.getDonationScrollMsg() + 
					" - Today : " + topDonationThisDay.getDonationScrollMsg() +
					" - This week : " + topDonationThisWeek.getDonationScrollMsg() + 
					" - All Time : " + topDonation.getDonationScrollMsg() ; 
		}
		
		public function getModelAwardsOfDonator(m:MetaDonation):Array {
			var result:Array = new Array();
			if(topDonation.isSameDonator(m)) result.push(ModelDonationAwardEnum.TOP_ALL_TIME);
			if(topDonationThisDay.isSameDonator(m)) result.push(ModelDonationAwardEnum.TOP_DAY);
			if(topDonationThisMonth.isSameDonator(m)) result.push(ModelDonationAwardEnum.TOP_MONTH);
			if(topDonationThisWeek.isSameDonator(m)) result.push(ModelDonationAwardEnum.TOP_WEEK);
			if(firstThisDay.isSameDonator(m)) result.push(ModelDonationAwardEnum.FIRST_DAY);
			return result;
		}
		
		public function feedAwardsOfDonator(m : MetaNewDonation) : void {
			m.modelCurrentAwards = getModelAwardsOfDonator(m);
			if(firstThisDay.isEmpty()) m.addAwardToNew(ModelDonationAwardEnum.FIRST_DAY);
			if(isHigherThanTopDonatorThisDay(m.amountThisDay) && !topDonationThisDay.isEmpty()) m.addAwardToNew(ModelDonationAwardEnum.TOP_DAY);
			if(isHigherThanTopDonatorThisWeek(m.amountThisWeek) && !topDonationThisWeek.isEmpty()) m.addAwardToNew(ModelDonationAwardEnum.TOP_WEEK);
			if(isHigherThanTopDonatorThisMonth(m.amountThisMonth) && !topDonationThisMonth.isEmpty()) m.addAwardToNew(ModelDonationAwardEnum.TOP_MONTH);
			if(isHigherThanTopDonatorAllTime(m.amountAllTime)) m.addAwardToNew(ModelDonationAwardEnum.TOP_ALL_TIME);	
		}
		
		public function isHigherThanTopDonatorThisDay(amount:Number):Boolean {return isHigherThanDonation(topDonationThisDay, amount);}
		public function isHigherThanTopDonatorThisWeek(amount:Number):Boolean {return isHigherThanDonation(topDonationThisWeek, amount);}
		public function isHigherThanTopDonatorThisMonth(amount:Number):Boolean {return isHigherThanDonation(topDonationThisMonth, amount);}
		public function isHigherThanTopDonatorAllTime(amount:Number):Boolean {return isHigherThanDonation(topDonation, amount);}
		
		
		public function isHigherThanDonation(m:MetaDonation, amount:Number):Boolean {
			if(m == null) return false;
			return amount > m.amount;
		}
		
		static public function createDummy():MetaDonationsConfig {
			var result:MetaDonationsConfig = new MetaDonationsConfig();
			result.metaBigGoal.reward = "Mortal Kombat Secret Stage";
			result.metaRecurrentGoal.reward = "Infernax's Early Access Giveaway!";
			result.metaRecurrentGoal.crntAmount = 0;
			result.metaRecurrentGoal.targetAmount = 100;
			result.metaBigGoal.crntAmount = 0;
			result.metaBigGoal.targetAmount = 0;
			result.metaCharity.crntAmount = 0;
			result.metaCharity.prct = 10;
			result.metaCharity.enabled = true;			
			return result;
		}
		
		static public function createFromRawData(rawData:Dictionary):MetaDonationsConfig {
			var result:MetaDonationsConfig = new MetaDonationsConfig();
			result.decode(rawData);
			return result;
		}

		
	}
}
