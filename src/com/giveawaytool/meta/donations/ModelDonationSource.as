package com.giveawaytool.meta.donations {
	import com.lachhh.lachhhengine.meta.ModelBase;

	/**
	 * @author LachhhSSD
	 */
	public class ModelDonationSource extends ModelBase {
		public var name:String;
		public function ModelDonationSource(pId : int, pName:String) {
			super(pId);
			name = pName;
		}
		
		public function isCalculated():Boolean {
			return id == ModelDonationSourceEnum.CALCULATED.id;
		}
		
		public function getUrlForLast(clientId:String, accessToken:String, limit:int):String { 
			throw new Error("ModelDonationSource.getUrl : To Override");
		}
		
		public function convertRawDataToArray(output:Array, rawData:Object):Array {
			return output;
		}
	}
}
