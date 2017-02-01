package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonationList {
		public var donations:Array = new Array();
		private var saveData : Dictionary = new Dictionary();
		public var numLastToShow:int = 5;
		public var donationsByName:MetaDonatorCalculatedList = new MetaDonatorCalculatedList();
		public var donationsByNameThisMonth:MetaDonatorCalculatedList = new MetaDonatorCalculatedList();
		public var donationsByNameThisDay:MetaDonatorCalculatedList = new MetaDonatorCalculatedList();
		public var donationsByNameThisWeek:MetaDonatorCalculatedList = new MetaDonatorCalculatedList();
		
		
		public function addFromSource(a:Array):void {
			for (var i : int = 0; i < a.length; i++) {
				var newDonation:MetaDonation = a[i];
				if(!hasDonation(newDonation)) {
					addCopyAsNew(newDonation);
				}
			}
		}
		
		public function sortByDate():void {
			donations.sort(sortDate);
		}
		
		public function sortDate(m1:MetaDonation, m2:MetaDonation):int {
			if(m1.date.time < m2.date.time) return 1;
			if(m1.date.time > m2.date.time) return -1;
			return 0;
		}
		
		private function addCopyAsNew(m:MetaDonation):void {
			var newDonation:MetaDonation = m.clone();
			newDonation.isNew = true;
			donations.push(newDonation);
		}
		
		public function encodeNewDonation(d:Dictionary, m:MetaDonation):void {
			d["amountAllTime"] = donationsByName.getDonationFromName(m.donatorName).amount;
			d["amountThisMonth"] = donationsByNameThisMonth.getDonationFromName(m.donatorName).amount;
			d["amountThisDay"] = donationsByNameThisDay.getDonationFromName(m.donatorName).amount;
			d["amountThisWeek"] = donationsByNameThisWeek.getDonationFromName(m.donatorName).amount;
			
		}
		
		private function hasDonation(m:MetaDonation):Boolean {
			for (var i : int = 0; i < donations.length; i++) {
				var donation:MetaDonation = donations[i];
				if(donation.isEquals(m)) return true;
			}
			return false;
		}
		
		public function encode():Dictionary {
			saveData = new Dictionary();
			for (var i : int = 0; i < donations.length; i++) {
				var donation:MetaDonation = donations[i];
				saveData["donation"+i] = donation.encode();	
			}
			
			return saveData; 
		}
				
		public function getMetaDonation(i:int):MetaDonation {
			if(i < 0) return MetaDonation.NULL;
			if(i >= donations.length) return MetaDonation.NULL;
			return donations[i];
			
		}
		
		public function encodeForWidget(m:MetaDonationsConfig):Dictionary {
			saveData = new Dictionary();
			for (var i : int = 0; i < donations.length; i++) {
				var donation:MetaDonation = donations[i];
				var d:Dictionary = donation.encode();
				m.allDonations.encodeNewDonation(d, donation);
				saveData["donation"+i] = d;
				if(i >= (numLastToShow-1)) break;	
			}
			
			return saveData; 
		}
		
		public function copyKeepingOnlyNew():MetaDonationList {
			var result:MetaDonationList = new MetaDonationList();
			for (var i : int = 0; i < donations.length; i++) {
				var d:MetaDonation = donations[i];
				if(d.isNew) {
					result.donations.push(d);
				}
			}
			return result;
		}
		
		public function remove(m:MetaDonation):void {
			var i:int = donations.indexOf(m);
			if(i != -1) donations.splice(i,1);
			refreshTopDonator();
		}
		
		public function decode(loadData:Dictionary):void {
			donations = new Array();
			if(loadData == null) return ;
			var i:int = 0;
			while(loadData["donation" + i] != null) {
				var d:Dictionary = loadData["donation" + i];
				donations.push(MetaDonation.create(d));
				i++;
			}
			
		}
		
		public function getdonationsMsg():String {
			if(donations.length <= 0) return "None";
			var result:String = "";
			for (var i : int = 0; i < numLastToShow; i++) {
				if(i >= donations.length) break;
				var m:MetaDonation = donations[i];
				result += m.getDonationScrollMsg() + "  ";
			}
			return result; 
		}
		
		public function getAmountTotalOfNew():Number {
			var result:Number = 0;
			for (var i : int = 0; i < donations.length; i++) {
				var metaDonation:MetaDonation = donations[i];
				if(metaDonation.isNew) {
					result += metaDonation.amount;
				}
			} 
			return result;
		}
		
		public function refreshTopDonator():void {
			donationsByName.clear();
			donationsByNameThisMonth.clear();
			donationsByNameThisDay.clear();
			donationsByNameThisWeek.clear();
			TodayDate.refresh();
			for (var i : int = 0; i < donations.length; i++) {
				var m:MetaDonation = donations[i];
				donationsByName.addDonationToDonator(m);
				if(m.isThisMonth()) donationsByNameThisMonth.addDonationToDonator(m);
				if(m.isThisDay()) donationsByNameThisDay.addDonationToDonator(m);
				if(m.isThisWeek()) donationsByNameThisWeek.addDonationToDonator(m);
			}
		}
		
		
	}
}
