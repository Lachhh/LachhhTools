package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonationGoal {
		public var reward:String ;
		public var crntAmount:Number ;
		public var targetAmount : Number;
		public var enabled : Boolean = true;
		private var saveData : Dictionary = new Dictionary();
		public var showWidget : Boolean = true;

		public function MetaDonationGoal() {
			clear();
		}
		
		public function clear():void {
			reward = "";
			crntAmount = 0;
			targetAmount = 100;
		}
		
		public function isEnabled():Boolean {
			if(!enabled) return false;
			return (targetAmount > 0);
		}
		
		public function getPrctComplete():Number {
			return (targetAmount/crntAmount);
		}
		
		public function isCompleted():Boolean {
			return (crntAmount >= targetAmount);
		}
		
		public function willBeNewlyCompletedIfAdded(amount:Number):Boolean{
			if(isCompleted()) return false;
			if(!isEnabled()) return false;
			return ((crntAmount+amount) >= targetAmount);
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
	}
}
