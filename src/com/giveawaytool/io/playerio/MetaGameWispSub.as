package com.giveawaytool.io.playerio {
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.utils.Utils;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispSub {
		public var name:String = "";
		public var status:String = "";
		public var tierCostStr:String = "";
		public var tierCostInCents : Number = 0;
		public var tierLevel : int = 0;

		public function MetaGameWispSub() {
			
		}

		static public function createFromDb(obj : Object) : MetaGameWispSub {
			if(obj == null) return null;
			var result : MetaGameWispSub = new MetaGameWispSub();
			result.name = obj.name;
			result.status = obj.status;
			result.tierCostStr = obj.tierCost;
			result.tierLevel = obj.tierLevel;
			result.tierCostInCents = FlashUtils.myParseFloat(result.tierCostStr.substring(1))*100;

			return result;
		}
		
		public function isNameEquals(pName : String) : Boolean {
			if(name.toLowerCase() == pName.toLowerCase()) return true;
			if("twitch_" + name.toLowerCase() == pName.toLowerCase()) return true;
			return false;
		}

		public function hasPledgeBronze() : Boolean {
			return hasPledge(ModelPatreonRewardEnum.STREAMER_BRONZE.thresholdCents);
		}

		public function hasPledgeSilver() : Boolean {
			return hasPledge(ModelPatreonRewardEnum.STREAMER_SILVER.thresholdCents);
		}
		public function hasPledgeGold() : Boolean {return hasPledge(ModelPatreonRewardEnum.STREAMER_GOLD.thresholdCents);}
		
		
		public function hasPledge(cost:Number) : Boolean {
			if(tierCostInCents >= cost) return true;
			return false;
		}

		public static function createDummy() : MetaGameWispSub {
			var result : MetaGameWispSub = new MetaGameWispSub();
			result.name = "Mr Dummy_" + Math.ceil(Math.random()*100);
			result.status = "active";
			result.tierCostStr = "3";
			var randomTier:ModelPatreonReward = (Math.random() < 0.66 ? (Math.random() < 0.33 ? ModelPatreonRewardEnum.STREAMER_BRONZE : ModelPatreonRewardEnum.STREAMER_SILVER) : ModelPatreonRewardEnum.STREAMER_GOLD);
			result.tierLevel = randomTier.thresholdCents ;
			result.tierCostInCents = randomTier.thresholdCents;
			return result;
		}

		public function getTwitchURL() : String {
			return "http://twitch.tv/" + name;
		}
		
		public function getTwitchURLQuestion() : String {
			return "Visit " + name + "'s channel?";
		}
	}
}
