package com.giveawaytool.meta {
	import com.giveawaytool.ui.ModelAlertTypeEnum;
	import com.giveawaytool.ui.MetaHasBeenTested;
	import com.giveawaytool.ui.views.MetaCheerList;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCheerConfig {
		public var metaCheers : MetaCheerList = new MetaCheerList();
		
		public var alertOnNewCheer:Boolean = true;
		public var allowBurp:Boolean = false;
		private var saveData : Dictionary = new Dictionary();
		public var metaHasBeenTested : MetaHasBeenTested = new MetaHasBeenTested(ModelAlertTypeEnum.CHEERS);

		public function MetaCheerConfig() {
		}
				
		public function encode():Dictionary {
			saveData["metaCheers"] = metaCheers.encode();
			saveData["alertOnNewCheer"] = alertOnNewCheer;
			saveData["allowBurp"] = allowBurp;
			saveData["metaHasBeenTested"] = metaHasBeenTested.encode();
			
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			metaCheers.decode(loadData["metaCheers"]);
			metaHasBeenTested.decode(loadData["metaHasBeenTested"]);
			alertOnNewCheer = (loadData["alertOnNewCheer"]);
			
			allowBurp = (loadData["allowBurp"]);
			
		}
	}
}
