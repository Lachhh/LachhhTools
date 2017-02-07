package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonationSourceConnection {
		public var clientId:String = "";
		public var accessToken:String = "";
		public var modelSource:ModelDonationSource = ModelDonationSourceEnum.STREAM_TIP;
		
		private var saveData : Dictionary = new Dictionary();
		
		public function encode():Dictionary {
			saveData["clientId"] = clientId;
			saveData["accessToken"] = accessToken;
			saveData["modelSource"] = modelSource.id;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			clientId = loadData["clientId"];
			accessToken = loadData["accessToken"];
			modelSource = ModelDonationSourceEnum.getFromId(loadData["modelSource"]);
			
			if(modelSource.isNull) {
				modelSource = ModelDonationSourceEnum.STREAM_TIP;
			}
		}
		
		
		public function getUrlForLast(limit:int):String {
			return modelSource.getUrlForLast(clientId, accessToken, limit);
		}
		
		static public function createStreamLabsConnection():MetaDonationSourceConnection {
			var result: MetaDonationSourceConnection = new MetaDonationSourceConnection();
			result.modelSource = ModelDonationSourceEnum.STREAM_LABS;
			return result; 
		}
	
	}
}
