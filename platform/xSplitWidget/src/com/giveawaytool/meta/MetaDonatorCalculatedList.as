package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonatorCalculatedList {
		public var donators:Dictionary = new Dictionary();
		public var topDonator:MetaDonation = MetaDonation.createTopDefault();
		private var saveData : Dictionary = new Dictionary();
		public function clear():void {
			donators = new Dictionary();
			topDonator = MetaDonation.createTopDefault();
		}
		
		public function getDonationFromName(name:String):MetaDonation {
			if(donators[name] == null) {
				var newDonation:MetaDonation = MetaDonation.createTopDefault();
				newDonation.donatorName = name; 
				donators[name] = newDonation; 
			}
			return donators[name];
		}
				
		public function encode():Dictionary {
			saveData["donators"] = donators;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			donators = loadData["donators"];
			calculateTop();
		}
		
		private function calculateTop():MetaDonation {
			var result:int = -1;
			var resultName:String = "";
			
			for (var k:Object in donators) {
			    var value:int = donators[k];
			    var key:String = k.toString();
				if(value > result) {
					result = value;
					resultName = key;
				}
			}
			
			if(result == -1) return MetaDonation.createTopDefault();
			return getDonationFromName(resultName);
		}
		
		public function addDonationToDonator(donation:MetaDonation):void {
			addAmountToDonator(donation.donatorName, donation.amount);
		}
		
		public function addAmountToDonator(donatorName:String, amount:Number):void {
			var m:MetaDonation = getDonationFromName(donatorName);
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
