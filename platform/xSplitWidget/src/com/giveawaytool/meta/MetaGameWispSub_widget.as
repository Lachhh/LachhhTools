package com.giveawaytool.meta {
	import com.lachhh.flash.FlashUtils;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispSub_widget {
		public var name:String = "";
		public var status:String = "";
		public var tierCostStr:String = "";
		public var tierCostInCents : Number = 0;
		public var tierLevel : int = 0;
		public var tierTitle : String = "";
		public var tierDesc : String = "";
		private var saveData : Dictionary = new Dictionary();

		public function MetaGameWispSub_widget() {
			
		}

		static public function createFromDb(obj : Object) : MetaGameWispSub_widget {
			if(obj == null) return null;
			var result : MetaGameWispSub_widget = new MetaGameWispSub_widget();
			result.name = obj.name;
			result.status = obj.status;
			result.tierCostStr = obj.tierCost;
			result.tierLevel = obj.tierLevel;
			result.tierTitle = "";
			result.tierDesc = "";
			
			result.tierCostInCents = FlashUtils.myParseFloat(result.tierCostStr.substring(1)) * 100;

			return result;
		}
		
		public function encode():Dictionary {
			saveData["name"] = name;
			saveData["status"] = status;
			saveData["tierCostStr"] = tierCostStr;
			saveData["tierLevel"] = tierLevel;
			saveData["tierTitle"] = tierTitle;
			saveData["tierDesc"] = tierDesc;
			
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			name = loadData["name"];
			status = loadData["status"];
			tierCostStr = loadData["tierCostStr"];
			tierLevel = loadData["tierLevel"];
			tierTitle = loadData["tierTitle"];
			tierDesc = loadData["tierDesc"];
			
			tierCostInCents = FlashUtils.myParseFloat(tierCostStr.substring(1)) * 100;
		}
		
		
		
		public function isNameEquals(pName : String) : Boolean {
			if(name.toLowerCase() == pName.toLowerCase()) return true;
			if("twitch_" + name.toLowerCase() == pName.toLowerCase()) return true;
			return false;
		}

	
		public static function createDummy() : MetaGameWispSub_widget {
			var result : MetaGameWispSub_widget = new MetaGameWispSub_widget();
			result.name = "Mr Dummy_" + Math.ceil(Math.random()*100);
			result.status = "active";
			result.tierCostStr = "3";
			result.tierLevel = 2 ;
			result.tierCostInCents = 300;
			result.tierTitle = "Cool Tier";
			result.tierDesc = "Reward #1";
			return result;
		}

		public function getTwitchURL() : String {
			return "http://twitch.tv/" + name;
		}
		

		public function isActive() : Boolean {
			return status == "active";
		}
		
		public function isInactive() : Boolean {
			if(status == "inactive") return true;
			return false;
		}
				
		
	}
}
