package com.giveawaytool.io.playerio {
	import com.lachhh.lachhhengine.meta.ModelBase;

	/**
	 * @author Eel
	 */
	public class ModelPatreonReward extends ModelBase {
		
		public var thresholdCents:int = -1;
		public var isManuallyControlled:Boolean = false;
		public var goldenXPChance:Number = 0;
		public var idStr:String;
		
		public function ModelPatreonReward(id:int, pId : String, pThresholdCents:int, pIsManuallyControlled:Boolean, pGoldenXPChance:Number) {
			super(id);
			idStr = pId;
			thresholdCents = pThresholdCents;
			isManuallyControlled = pIsManuallyControlled;
			goldenXPChance = pGoldenXPChance;
		}
		
		
		public function gameWispUserMeetsReward(user:MetaGameWispSub):Boolean{
			if(user == null) return false;
			return (user.tierCostInCents) >= thresholdCents;
		}
		
		public function isPledgeAboveOrEqual(pModelReward:ModelPatreonReward):Boolean{
			return thresholdCents >= pModelReward.thresholdCents;
		}
	}
}