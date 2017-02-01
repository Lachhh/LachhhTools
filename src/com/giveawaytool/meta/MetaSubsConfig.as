package com.giveawaytool.meta {
	import com.giveawaytool.ui.ModelAlertTypeEnum;
	import com.giveawaytool.ui.MetaHasBeenTested;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import com.giveawaytool.constants.GameConstants;
	import com.lachhh.lachhhengine.meta.MetaUpgrade;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSubsConfig {
	
		public var crntSub:MetaUpgrade = new MetaUpgrade(GameConstants.SUB_NEEDED);
		public var alertOnNewSub:Boolean = true;
		public var alertOnReSub:Boolean = true;
		public var subTrainNum:int = 3;
		public var goalSub:int = 0;
		public var listOfSubs : MetaSubscribersList = new MetaSubscribersList();
		private var saveData : Dictionary = new Dictionary();
		public var metaHasBeenTested : MetaHasBeenTested = new MetaHasBeenTested(ModelAlertTypeEnum.SUB);

		public function clear() : void {
			listOfSubs.clear();
		}
		
		public function encode() : Dictionary {
			// saveData["crntSub"] = crntSub.value;
			saveData["alertOnNewSub"] = alertOnNewSub;
			saveData["alertOnReSub"] = alertOnReSub;
			saveData["subTrainNum"] = subTrainNum;
			saveData["goalSub"] = goalSub;
			saveData["listOfSubs"] = listOfSubs.encode();
			saveData["metaHasBeenTested"] = metaHasBeenTested.encode();
			
			
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			//crntSub.value = loadData["crntSub"];
			alertOnNewSub = loadData["alertOnNewSub"];
			alertOnReSub = loadData["alertOnReSub"];
			subTrainNum = loadData["subTrainNum"];
			goalSub = loadData["goalSub"];
			listOfSubs.decode(loadData["listOfSubs"]);
			metaHasBeenTested.decode(loadData["metaHasBeenTested"]);
			
		}

		public function setAutoNext(crnt:int) : void {
			crntSub.value = crnt;
			goalSub = crntSub.xpToNext;
		}

		public function getCrntSub() : int {
			if(TwitchConnection.instance == null) return 1;
			return TwitchConnection.instance.listOfSubs.subscribers.length;
		}
	}
}
