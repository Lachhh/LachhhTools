package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonatorCalculatedList {
		public var donators:Dictionary = new Dictionary();
		public var topDonator:MetaDonation = MetaDonation.createTopDefault();
		public var firstDonator:MetaDonation = MetaDonation.createDateInTheFuture();
		private var saveData : Dictionary = new Dictionary();
		public function clear():void {
			donators = new Dictionary();
			topDonator = MetaDonation.createTopDefault();
			firstDonator = MetaDonation.createDateInTheFuture();
		}
		
		public function getDonationFromName(name:String):MetaDonation {
			name = name.toLowerCase();
			if(donators[name] == null) {
				var newDonation:MetaDonation = MetaDonation.createTopDefault();
				newDonation.donatorName = name; 
				donators[name] = newDonation; 
			}
			return donators[name];
		}
		
		public function getFirstByDate():MetaDonation {
			return null;
		}
				
		public function encode():Dictionary {
			saveData["donators"] = donators;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			donators = loadData["donators"];
		}
		
		public function addDonationToDonator(donation:MetaDonation):void {
			addAmountToDonator(donation.donatorName.toLowerCase(), donation.amount);
			if(donation.date < firstDonator.date) {
				firstDonator = donation;
			}
		}
		
		public function addAmountToDonator(donatorName:String, amount:Number):void {
			var m:MetaDonation = getDonationFromName(donatorName.toLowerCase());
			m.amount += amount;
			m.amount = trunkTo2Digits(m.amount);
			
			if(m.amount > topDonator.amount) topDonator = m;	
		}
		
		private function trunkTo2Digits(n:Number):Number {
			var i:int = n*100;
			var n2:Number = (i*0.01);
			return n2;
		}
	}
}
