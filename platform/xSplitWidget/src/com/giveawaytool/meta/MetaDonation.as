package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonation {
		static public var NULL:MetaDonation = new MetaDonation();
		public var donatorName:String = "";
		public var donatorMsg:String = "";
		public var amount:Number = 0;
		
		
		private var saveData : Dictionary = new Dictionary();

		public function MetaDonation() {
		}
		
		public function clear():void {
			donatorName = "";
			donatorMsg = "";
			amount = 0;
		}
		
		public function getDonationScrollMsg():String {
			if(this == NULL) return "$0";
			if(amount <= 0) return "$0";
			return getDonatorName() + " - " + getAmountTxt();
		}
		
		public function getAmountTxt():String {
			return "$" + amount; 
		}

		public function encode():Dictionary {
			saveData["donatorName"] = donatorName;
			saveData["amount"] = amount;
			saveData["donatorMsg"] = donatorMsg;
			
			return saveData;
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			donatorName = loadData["donatorName"];
			amount = loadData["amount"];
			donatorMsg = loadData["donatorMsg"];
		}
		
		public function getDonationMsg():String {
			if(donatorMsg == null) return "<No Message>";
			return donatorMsg;
		}
		
		public function getDonatorName():String {
			if(donatorName == null) return "<Anonymous>";
			return donatorName;
		}
		
		public function isEmpty():Boolean {
			return (amount == 0);
		}
		
		static public function createDummy():MetaDonation {
			var result:MetaDonation = new MetaDonation();
			result.donatorName = "An Awesome Dude";
			result.donatorMsg = "OMG You're so cool I love you with all my mouth. ";
			result.amount = Math.random()*30+3;
			result.amount = Math.ceil(result.amount*100)/100;
			return result;
		}
	
		
		static public function createTopDefault():MetaDonation {
			var result:MetaDonation = new MetaDonation();
			result.donatorName = "None";
			result.donatorMsg = "";
			result.amount = 0;
			return result;
		}

		public function isSameDonator(m : MetaDonation) : Boolean {
			
			return m.donatorName.toLowerCase() == donatorName.toLowerCase();
		}
	}
}
