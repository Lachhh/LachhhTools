package com.giveawaytool.meta.donations {
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.utils.Utils;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class ModelDonationSourceStreamLabs extends ModelDonationSource {
		

		public function ModelDonationSourceStreamLabs(pId : int, pName : String) {
			super(pId, name);
			name = pName;
		}

		override public function getUrlForLast(clientId : String, accessToken : String, limit : int) : String {
			return "https://www.twitchalerts.com/api/v1.0/donations?limit=" + limit + "&access_token=" + accessToken + "&currency=USD" ;
		}

		override public function convertRawDataToArray(output : Array, rawData : Object) : Array {
			Utils.ClearArray(output);
			var d:Dictionary = DataManager.stringToDictionnary(rawData + "");
			
			var tips:Dictionary = d.data;
			var i:int = 0;
			var crntTip:Dictionary = tips[i+""];
			  
			while(crntTip) {
				var newDonation:MetaDonation = MetaDonation.createFromStreamLabs(crntTip);
				output.push(newDonation);
				i++;
				crntTip = tips[i+""];
			}
			return output;
		}
	}
}
