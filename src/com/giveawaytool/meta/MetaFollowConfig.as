package com.giveawaytool.meta {
	import com.giveawaytool.ui.ModelAlertTypeEnum;
	import com.giveawaytool.ui.MetaHasBeenTested;
	import com.giveawaytool.ui.views.MetaFollower;
	import com.giveawaytool.ui.views.MetaFollowerList;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaFollowConfig {
		public var metaFollowers : MetaFollowerList = new MetaFollowerList();
		public var goalFollowers:int = 100;
		public var alertOnNewFollow:Boolean = true;
		public var alertOnReFollow:Boolean = false;
		public var followTrain:Boolean = true;
		public var followTrainNum:int = 3;
		private var saveData : Dictionary = new Dictionary();
		public var metaHasBeenTested : MetaHasBeenTested = new MetaHasBeenTested(ModelAlertTypeEnum.FOLLOW);

		public function MetaFollowConfig() {
		}
				
		public function encode():Dictionary {
			saveData["metaFollowers"] = metaFollowers.encode();
			saveData["goalFollowers"] = goalFollowers;
			saveData["alertOnNewFollow"] = alertOnNewFollow;
			saveData["alertOnReFollow"] = alertOnReFollow;
			saveData["followTrainNum"] = followTrainNum;
			saveData["followTrain"] = followTrain;
			saveData["metaHasBeenTested"] = metaHasBeenTested.encode();
			
			
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			metaFollowers.decode(loadData["metaFollowers"]);
			goalFollowers = (loadData["goalFollowers"]);
			
			alertOnNewFollow = (loadData["alertOnNewFollow"]);
			alertOnReFollow = (loadData["alertOnReFollow"]);
			followTrainNum = (loadData["followTrainNum"]);
			followTrain = (loadData["followTrain"]);
			metaHasBeenTested.decode(loadData["metaHasBeenTested"]);
			
		}
	}
}
