package com.giveawaytool.meta.donations {
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.utils.Utils;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class ModelDonationSourceStreamTip extends ModelDonationSource {
		

		public function ModelDonationSourceStreamTip(pId : int, pName : String) {
			super(pId, name);
			name = pName;
		}

		override public function getUrlForLast(clientId : String, accessToken : String, limit : int) : String {
			return "https://streamtip.com/api/tips?limit=" + limit + "&client_id=" + clientId + "&access_token=" + accessToken ;
		}

		override public function convertRawDataToArray(output : Array, rawData : Object) : Array {
			Utils.ClearArray(output);
			var d:Dictionary = DataManager.stringToDictionnary(rawData + "");
			
			var tips:Dictionary = d.tips;
			var i:int = 0;
			var crntTip:Dictionary = tips[i+""];
			  
			while(crntTip) {
				var newDonation:MetaDonation = MetaDonation.createFromStreamTipData(crntTip);
				output.push(newDonation);
				i++;
				crntTip = tips[i+""];
			}
			return output;
		}
	}
}
