package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCharityConfig {
		public var settings : MetaCharityPrct = new MetaCharityPrct();
		public var listOfPastDonations : MetaCharityDonationList = new MetaCharityDonationList();
		public var charityOrganization : MetaCharityOrganization ;
		private var saveData : Dictionary = new Dictionary();
		
		public function MetaCharityConfig() {
			clear();
		}

		public function clear() : void {
			settings.clear();
			listOfPastDonations.clear();
			charityOrganization = new MetaCharityOrganization("", "", "", "");
			charityOrganization.decode(MetaCharityOrganizationEnum.CHILD_PLAY.encode());
		}
		
		public function encode():Dictionary {
			saveData["settings"] = settings.encode();
			saveData["listOfPastDonations"] = listOfPastDonations.encode();
			saveData["charityOrganization"] = charityOrganization.encode();
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			settings.decode(loadData["settings"]);
			listOfPastDonations.decode(loadData["listOfPastDonations"]);
			charityOrganization.decode(loadData["charityOrganization"]);
			
		}

		public function addCharityDonation(m : MetaCharityDonation) : void {
			listOfPastDonations.addDonation(m);
			settings.crntAmount = 0;
		}
	}
}
