package com.giveawaytool.meta {
	import com.giveawaytool.constants.GameConstants;
	import com.lachhh.lachhhengine.meta.MetaUpgrade;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSubsConfig {
	
		public var crntSub:MetaUpgrade = new MetaUpgrade(GameConstants.SUB_NEEDED);
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["crntSub"] = crntSub.value;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			crntSub.value = loadData["crntSub"];
		}
	}
}
