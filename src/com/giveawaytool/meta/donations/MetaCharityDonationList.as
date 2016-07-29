package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCharityDonationList {
		public var charityDonation:Array = new Array();
		private var saveData : Dictionary = new Dictionary();
		
		public function clear():void {
			charityDonation = new Array();
		}
		
		public function addDonation(m:MetaCharityDonation):void {
			charityDonation.push(m);
		}
		
		public function encode():Dictionary {
			saveData = new Dictionary();
			for (var i : int = 0; i < charityDonation.length; i++) {
				var m:MetaCharityDonation = charityDonation[i];
				saveData["charity" + i] = m.encode();	
			}
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			var i:int = 0;
			
			while(loadData["charity" + i]) {
				var m:MetaCharityDonation = new MetaCharityDonation();
				m.decode(loadData["charity" + i]);
				i++;
			}
		}
		
		public function getTotal():Number {
			var result:Number = 0;
			for (var i : int = 0; i < charityDonation.length; i++) {
				var m : MetaCharityDonation = charityDonation[i];
				result += m.amount;
			}
			return result;
		}

		public function getTotalAmountTxt() : String {
			return "$" + getTotal().toFixed(2);
		}

		public function sortByDate() : void {
			charityDonation.sort(sortDate);
		}
		
		public function sortDate(m1:MetaCharityDonation, m2:MetaCharityDonation):int {
			if(m1.date.time > m2.date.time) return -1;
			if(m1.date.time < m2.date.time) return 1;
			return 0;
		}

		public function getMetaDonation(i : int) : MetaCharityDonation {
			if(i < 0) return null;
			if(i >= charityDonation.length) return null;
			return charityDonation[i];
		}
	}
}
