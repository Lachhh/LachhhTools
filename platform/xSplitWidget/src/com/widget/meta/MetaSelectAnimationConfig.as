package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSelectAnimationConfig {
		public var metaCustomAnimNewFollow : MetaSelectAnimation = new MetaSelectAnimation();
		public var metaCustomAnimNewSub : MetaSelectAnimation = new MetaSelectAnimation();
		public var metaCustomAnimNewHost : MetaSelectAnimation = new MetaSelectAnimation();
		public var metaCustomAnimNewCheers : MetaSelectAnimation = new MetaSelectAnimation();
		public var metaCustomAnimNewDonation : MetaSelectAnimation = new MetaSelectAnimation();
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["metaCustomAnimNewFollow"] = metaCustomAnimNewFollow.encode();
			saveData["metaCustomAnimNewSub"] = metaCustomAnimNewSub.encode();
			saveData["metaCustomAnimNewHost"] = metaCustomAnimNewHost.encode();
			saveData["metaCustomAnimNewCheers"] = metaCustomAnimNewCheers.encode();
			saveData["metaCustomAnimNewDonation"] = metaCustomAnimNewDonation.encode();
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			metaCustomAnimNewFollow.decode(loadData["metaCustomAnimNewFollow"]);
			metaCustomAnimNewSub.decode(loadData["metaCustomAnimNewSub"]);
			metaCustomAnimNewHost.decode(loadData["metaCustomAnimNewHost"]);
			metaCustomAnimNewCheers.decode(loadData["metaCustomAnimNewCheers"]);
			metaCustomAnimNewDonation.decode(loadData["metaCustomAnimNewDonation"]);
			
		}
	}
}
