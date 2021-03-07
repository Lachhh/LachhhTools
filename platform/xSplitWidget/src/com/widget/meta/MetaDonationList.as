package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonationList {
		public var lastDonators:Array = new Array();
		private var saveData : Dictionary = new Dictionary();
		public var numLastToShow:int = 5;
		
		public function add(m:MetaDonation):void {
			lastDonators.unshift(m);
		}
		
		public function encode():Dictionary {
			for (var i : int = 0; i < lastDonators.length; i++) {
				var donation:MetaDonation = lastDonators[i];
				saveData["donation"+i] = donation.encode();	
			}
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			lastDonators = new Array();
			if(loadData == null) return ;
			var i:int = 0;
			while(loadData["donation" + i] != null) {
				var d:Dictionary = loadData["donation" + i];
				var newDonation:MetaNewDonation = MetaNewDonation.createFromRawData(d);
				lastDonators.push(newDonation);
				i++;
			}
			
		}
		
		public function getLastDonatorsMsg():String {
			if(lastDonators.length <= 0) return "None";
			var result:String = "";
			for (var i : int = 0; i < numLastToShow; i++) {
				if(i >= lastDonators.length) break;
				var m:MetaDonation = lastDonators[i];
				result += m.getDonationScrollMsg() + "  ";
			}
			return result; 
		}
		
		static public function createFromRawData(rawData:Dictionary):MetaDonationList {
			var output:MetaDonationList = new MetaDonationList();			
			output.decode(rawData);
			return output;
		} 
	}
}
