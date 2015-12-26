package com.giveawaytool.meta {
	import isle.susisu.twitter.Twitter;
	import com.giveawaytool.meta.donations.MetaDonationFetchTimer;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaTweetAlertConfig {
		public var metaAutoFetch : MetaDonationFetchTimer = new MetaDonationFetchTimer();
		
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["metaAutoFetch"] = metaAutoFetch.encode();
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			
			metaAutoFetch.decode(loadData["metaAutoFetch"]);
		}
		
		public function getTwitterAccount():MetaTwitterAccount {
			if(MetaGameProgress.instance.metaShareOnTwitter.twitterAccounts.accounts.length <= 0) return null; 
			return MetaGameProgress.instance.metaShareOnTwitter.twitterAccounts.accounts[0];
		}
		
		public function getTwitter():Twitter {
			var metaTwitterAccount:MetaTwitterAccount = getTwitterAccount();
			if(metaTwitterAccount == null) return null; 
			return metaTwitterAccount.twitter;
		}
	}
}
