package com.giveawaytool.io.playerio {
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.ModelSubcriberSourceEnum;
	import com.lachhh.flash.FlashUtils;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispSub {
		public var name:String = "";
		public var status:String = "";
		public var source:String = "";
		public var tierCostStr:String = "";
		public var tierCostInCents : Number = 0;
		public var tierLevel : int = 0;
		public var tierTitle : String = "";
		public var tierDesc: String = "";
		public var date:Date = new Date();
		static public var dateOnMonthEarlier:Date ;
		private var saveData : Dictionary = new Dictionary();

		public function MetaGameWispSub() {
			
		}

		static public function createFromDb(obj : Object) : MetaGameWispSub {
			if(obj == null) return null;
			
			var result : MetaGameWispSub = new MetaGameWispSub();
			result.name = obj.name;
			result.status = obj.status;
			result.source = obj.source;
			result.tierCostStr = obj.tierCost;
			result.tierLevel = obj.tierLevel;
			result.tierTitle = obj.tierTitle;
			result.tierDesc = obj.tierDesc;
			if(obj.date) {
				result.date = new Date(obj.date);
			} else {
				result.date = new Date();
			}
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
			try {
				tierCostInCents = FlashUtils.myParseFloat(tierCostStr.substring(1)) * 100;
			} catch (e:Error) {
				tierCostInCents = 0;
			}
		}
		
		static public function createFromGameWispRequest(obj : Object) : MetaGameWispSub {
			if(obj == null) return null;
			var result : MetaGameWispSub = new MetaGameWispSub();
			var tierId:String = obj["tier_id"];
			var metaTier:MetaGameWispTier = GameWispConnection_DEPRECATEDDD.getInstance().metaChannelInfo.metaTiers.getFromId(tierId);
			result.name = obj["user"]["data"]["username"];
			result.status = obj.status;
			result.tierCostStr = metaTier.tierCost;
			result.tierTitle = metaTier.tierTitle;
			result.tierDesc = metaTier.tierDescription;
			result.tierLevel = FlashUtils.myParseFloat(metaTier.tierLevel);
			result.tierCostInCents = FlashUtils.myParseFloat(result.tierCostStr.substring(1))*100;

			return result;
		}
		
		public function isNameEquals(pName : String) : Boolean {
			if(name.toLowerCase() == pName.toLowerCase()) return true;
			if("twitch_" + name.toLowerCase() == pName.toLowerCase()) return true;
			return false;
		}

		public function hasPledgeBronze() : Boolean {return hasPledge(ModelPatreonRewardEnum.STREAMER_BRONZE.thresholdCents);}
		public function hasPledgeSilver() : Boolean {return hasPledge(ModelPatreonRewardEnum.STREAMER_SILVER.thresholdCents);}
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
			result.tierTitle = "Cool Tier";
			result.tierDesc = "Reward #1";
			return result;
		}

		public function getTwitchURL() : String {
			return "http://twitch.tv/" + name;
		}
		
		public function getTwitchURLQuestion() : String {
			return "Visit " + name + "'s channel?";
		}
		
		public function toMetaSub():MetaSubscriber {
			var result:MetaSubscriber = new MetaSubscriber();
			result.modelSubSource = ModelSubcriberSourceEnum.GAMEWISP;
			result.name = name;
			result.metaGameWispSubInfo = this;
			return result;
		}
		
		public function hasBeenReactivatedOrPledgedHigher(newInfo:MetaGameWispSub):Boolean {
			if(hasBeenReactivated(newInfo)) return true;
			if(hasHigherPledge(newInfo)) return true;
			return false;
		}
		
		public function hasBeenReactivated(newInfo:MetaGameWispSub):Boolean {
			return !isActive() && newInfo.isActive();
		}
		
		public function hasHigherPledge(newInfo:MetaGameWispSub):Boolean {
			return tierCostInCents < newInfo.tierCostInCents;
		}

		public function isActive() : Boolean {
			if(isOutofDate()) {
				return false;
			}
			return status == "active";
		}
		
		public function isOutofDate() : Boolean {
			initEarlyDate();
			return date < dateOnMonthEarlier;
		}

		private function initEarlyDate() : void {
			if(dateOnMonthEarlier) return;
			dateOnMonthEarlier = new Date();
			dateOnMonthEarlier.time -= 1000*60*60*24*30;
		}
		
		public function isExpiring() : Boolean {
			return status == "grace_period";
		}
		
		public function getTierCents() :int {
			if(!isActive()) return 0;
			return tierCostInCents;
		}
		
		public function isInactive() : Boolean {
			if(status == "inactive") return true;
			if(isOutofDate()) return true;
			return false;
		}
				
		public function isLachhh() : Boolean {
			if(name == "lachhh") return true;
			return false;
		}
	}
}
