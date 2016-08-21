package com.giveawaytool.meta {
	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class MetaNewDonation extends MetaDonation {
		public var amountAllTime:Number;
		public var amountThisMonth:Number;
		public var amountThisDay : Number;
		public var amountThisWeek : Number;
		public var modelNewAwards:Array = new Array();
		public var modelCurrentAwards:Array = new Array(); 
		public function MetaNewDonation() {
			super();
		}
		
		
		override public function encode() : Dictionary {
			var result:Dictionary = super.encode();
			result["amountAllTime"] = amountAllTime;
			result["amountThisDay"] = amountThisDay;
			result["amountThisMonth"] = amountThisMonth;
			result["amountThisWeek"] = amountThisWeek;
			return result;
		}

		override public function decode(loadData : Dictionary) : void {
			super.decode(loadData);
			amountAllTime = loadData["amountAllTime"];
			amountThisMonth = loadData["amountThisMonth"];
			amountThisDay = loadData["amountThisDay"];
			amountThisWeek = loadData["amountThisWeek"];
		}
		
		static public function createFromRawData(rawData:Dictionary):MetaNewDonation {			
			var result:MetaNewDonation = new MetaNewDonation();
			result.decode(rawData);
			return result;
		}

		public static function createDummy() : MetaNewDonation {
			var result:MetaNewDonation = new MetaNewDonation();
			result.donatorName = "An Awesome Dude";
			result.donatorMsg = "OMG You're so cool I love you with all my mouth. ";
			result.amount = Math.random()*30+3;
			result.amount = Math.ceil(result.amount*100)/100;
			result.amountAllTime = 27;
			result.amountThisMonth = result.amount;
			result.amountThisDay = result.amount;
			result.amountThisWeek = result.amount;
			return result;
		}
		
		public function isFirstOfTheDay(mConfig:MetaDonationsConfig):Boolean {
			return mConfig.topDonationThisDay.amount <= 0;
		}
		
		public function hasCurrentAward():Boolean {
			return modelCurrentAwards.length > 0;
		}
		
		public function addAwardToNew(m:ModelDonationAward):void {
			if(hasAward(m)) return ;
			modelNewAwards.push(m);
		}
		
		public function hasNewAward():Boolean {
			return modelNewAwards.length > 0;
		}
		
		public function hasAward(m:ModelDonationAward):Boolean {
			return modelCurrentAwards.indexOf(m) != -1;
		}

	}
}
