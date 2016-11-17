package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCustomAnimConfig {
		public var metaCustomAnimNewFollow : MetaCustomAnim = new MetaCustomAnim();
		public var metaCustomAnimNewSub : MetaCustomAnim = new MetaCustomAnim();
		public var metaCustomAnimNewHost : MetaCustomAnim = new MetaCustomAnim();
		public var metaCustomAnimNewCheers : MetaCustomAnim = new MetaCustomAnim();
		public var metaCustomAnimNewDonation : MetaCustomAnim = new MetaCustomAnim();
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
