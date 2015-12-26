package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonationGoal {
		public var reward:String ;
		public var crntAmount:Number ;
		public var targetAmount : int;
		public var enabled : Boolean = true;
		public var showWidget : Boolean = true;
		private var saveData : Dictionary = new Dictionary();

		public function MetaDonationGoal() {
			clear();
		}
		
		public function clear():void {
			reward = "";
			crntAmount = 0;
			targetAmount = 100;
			enabled = true;
			showWidget = true;
		}
		
		public function getPrctComplete():Number {
			return (targetAmount/crntAmount);
		}
		
		public function encode():Dictionary {
			saveData["reward"] = reward;
			saveData["crntAmount"] = crntAmount;
			saveData["targetAmount"] = targetAmount;
			saveData["enabled"] = enabled;
			saveData["showWidget"] = showWidget;
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			reward = loadData["reward"];
			crntAmount = loadData["crntAmount"];
			targetAmount = loadData["targetAmount"];
			enabled = loadData["enabled"];
			showWidget = loadData["showWidget"];
		}
		
		public function isEnabled():Boolean {
			if(!enabled) return false;
			return (targetAmount > 0);
		}
		
		public function numRecurrentGoalReachedIfAmountAdded(amount:Number):int {
			if(!isEnabled()) return 0;
			var total:Number = crntAmount+amount;
			var goalReached:int = Math.floor(total/targetAmount);
			return goalReached;
		}
		
		public function getProgressPrct():Number {
			if(crntAmount < 0) return 0;
			if(crntAmount >= targetAmount) return 1;
			return crntAmount/targetAmount;
		}
	}
}
