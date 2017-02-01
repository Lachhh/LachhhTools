package com.giveawaytool.io.playerio {
	/**
	 * @author Eel
	 */
	public class ModelPatreonRewardEnum {
		
		public static var DOLLAR:int = 100;
		
		public static var ALL:Array = new Array();
		
		public static var NULL:ModelPatreonReward = new ModelPatreonReward(-1, "", -1, false, 0);
		
		public static var STREAMER_BRONZE:ModelPatreonReward = 		create(0, "pledge5_broadcaster", 	5*DOLLAR, false, 0);
		public static var STREAMER_SILVER:ModelPatreonReward = 		create(1, "pledge10_broadcaster", 	10*DOLLAR, false, 0);
		public static var STREAMER_GOLD:ModelPatreonReward = 		create(2, "pledge25_broadcaster",   25*DOLLAR, true,  0);
		
		public static function create(id:int, idStr:String, thresholdCents:int, isManuallyControlled:Boolean, goldenXPChance:Number):ModelPatreonReward{
			if (!getFromId(id).isNull) throw new Error("Duplicate ID!");
			var result:ModelPatreonReward = new ModelPatreonReward(id, idStr, thresholdCents, isManuallyControlled, goldenXPChance);
			ALL.push(result);
			return result;
		}
		
		static public function getFromId(id : int) : ModelPatreonReward {
			for (var i : int = 0; i < ALL.length; i++) {
				var g : ModelPatreonReward = ALL[i] as ModelPatreonReward;
				if (id == g.id) return g;
			}
			return NULL;
		}
		
		static public function getIndexOf(modelPatreon:ModelPatreonReward):int {
			return ALL.indexOf(modelPatreon);
		}

		static public function getHighestPledge(cents : Number) : ModelPatreonReward {
			var sortedList:Array = ALL.slice();
			sortedList.sort(sortByCents);
			
			for (var i : int = (ALL.length-1); i >= 0; i--) {
				var g : ModelPatreonReward = ALL[i] as ModelPatreonReward;
				if (g.thresholdCents <= cents) return g;
			}
			return NULL;
		}
		

		static public function getFromIndex(index : int) : ModelPatreonReward {
			if (index >= ALL.length) return NULL;
			if (index < 0) return NULL;
			return ALL[index] as ModelPatreonReward;
		}

		static public function getNum() : int {
			return ALL.length;
		}
		
		static public function sortByCents(m1:ModelPatreonReward, m2:ModelPatreonReward):int {
			if(m1.thresholdCents < m2.thresholdCents) return -1;
			if(m1.thresholdCents > m2.thresholdCents) return 1;
			return 0;
		}
		
	}
}