package com.giveawaytool.meta.donations {
	import com.giveawaytool.io.DonationSourceRequest;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.utils.Utils;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class ModelDonationSourceTiltify extends ModelDonationSource {
		

		public function ModelDonationSourceTiltify(pId : int, pName : String) {
			super(pId, name);
			name = pName;
		}

		override public function getUrlForLast(clientId : String, accessToken : String, limit : int) : String {
			return "https://tiltify.com/api/v2/group/donations?access_token=" + accessToken;
		}
		
		override public function convertRawDataToArray(output:Array, rawData:Object):Array {
			Utils.ClearArray(output);
			var d:Dictionary = DataManager.stringToDictionnary(rawData + "");
			
			var campaignList:Dictionary = d;
			var i:int = 0;
			var j:int = 0;
			var campaign:Dictionary = campaignList[i+""];
			  
			while(campaign) {
				j = 0;
				var donationsList:Dictionary = campaign.donations;
				var crntDonation:Dictionary = donationsList[j+""];
				
				while(crntDonation) {
					var newDonation:MetaDonation = MetaDonation.createFromTiltifyData(crntDonation);
					output.push(newDonation);	
					j++;
					crntDonation = donationsList[j+""];
				}
				i++;
				campaign = campaignList[i+""];
			}
			return output;
		}
	}
}
