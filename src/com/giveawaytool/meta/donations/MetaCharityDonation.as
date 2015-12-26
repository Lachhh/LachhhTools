package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCharityDonation {
		public static const NULL : MetaCharityDonation = new MetaCharityDonation();
		public var date : Date = new Date();
		public var nameOfOrganisation : String = "Child's play";
		public var amount:Number = 0;
		
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["date"] = date.time;
			saveData["nameOfOrganisation"] = nameOfOrganisation;
			saveData["amount"] = amount;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;

			date = new Date(loadData["date"]);
			nameOfOrganisation = loadData["nameOfOrganisation"];
			amount = loadData["amount"];
		}

		public function isNull() : Boolean {
			return (this == NULL);
		}
	}
}
