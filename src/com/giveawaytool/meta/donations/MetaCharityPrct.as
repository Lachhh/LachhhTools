package com.giveawaytool.meta.donations {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCharityPrct {
		
		public var title:String ;
		public var crntAmount:Number ;
		public var prct:int ;
		
		public var enabled : Boolean = false;
		
		private var saveData : Dictionary = new Dictionary();
		
		
		public function MetaCharityPrct() {
			clear();
		}
		
		public function clear():void {
			title = "Charity";
			crntAmount = 0;
			prct = 10;
			enabled = true;
		}
		
		public function isEnabled():Boolean {
			if(prct <= 0) return enabled;
			return enabled;
		}
		
		public function getCharityCut(n:Number):Number {
			
			var amount:Number = n*(prct*0.01);
			if(amount > n) return n;
			if(amount < 0) return 0;
			return Math.floor(amount*100)/100; 
		}
				
		public function getAmountTxt():String {
			return crntAmount+""; 
		}
		
		public function encode():Dictionary {
			saveData["title"] = title;
			saveData["crntAmount"] = crntAmount;
			saveData["enabled"] = enabled;
			saveData["prct"] = prct;
			
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			//enabled = false;
			if(loadData == null) return ;
			title = loadData["title"];
			crntAmount = loadData["crntAmount"];
			enabled = loadData["enabled"];
			prct = loadData["prct"];
			
		}
	}
}
