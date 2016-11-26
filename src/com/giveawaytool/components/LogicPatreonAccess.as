package com.giveawaytool.components {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.GoogleSheetData;
	import com.GoogleSheetsAPI;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicPatreonAccess extends ActorComponent {
		public var googleSheetData : GoogleSheetData_Patreon = new GoogleSheetData_Patreon(null);
		public function LogicPatreonAccess() {
			super();
			var sheet:GoogleSheetsAPI = new GoogleSheetsAPI(); 
			
			sheet.init(VersionInfoDONTSTREAMTHIS.PATREON_DATA_SHEET_ID, VersionInfoDONTSTREAMTHIS.GOOGLE_SHEETS_API_KEY);
			sheet.loadSheetData("ManualListBroadcasters", new Callback(onSheetData, this, null), new Callback(onSheetDataError, this, null));
		}
		
		private function onSheetDataError() : void {
			trace("onSheetDataError");
		}
		
		private function onSheetData(data:Object):void {
			googleSheetData = new GoogleSheetData_Patreon(data);
			UIBase.manager.refresh();
		}
		
		public function canAccessTweets():Boolean {
			if(TwitchConnection.instance == null) return false;
			if(!TwitchConnection.instance.isLachhhAndFriends()) return false;
			if(!isBronzeTier()) return false;
			return true;
		}
		
		public function canAccessFollow():Boolean {return isBronzeTier();}		
		public function canAccessHost():Boolean {return isBronzeTier();}		
		public function canAccessSub():Boolean {return isBronzeTier();}
		public function canAccessCheers():Boolean {return isSilverTier();}		
		public function canAccessDonation():Boolean {return isSilverTier();}
		
		public function canSendFollowIfNotLive():Boolean {return isBronzeTier() || !TwitchConnection.instance.isLive;}		
		public function canSendHostIfNotLive():Boolean {return isBronzeTier() || !TwitchConnection.instance.isLive;}		
		public function canSendSubIfNotLive():Boolean {return isBronzeTier() || !TwitchConnection.instance.isLive;}
		public function canSendCheersIfNotLive():Boolean {return isSilverTier() || !TwitchConnection.instance.isLive;}		
		public function canSendDonationIfNotLive():Boolean {return isSilverTier() || !TwitchConnection.instance.isLive;}
		
		public function canUseAlerts():Boolean {return isBronzeTier();}
		
		public function isBronzeTier():Boolean {
			
			if(googleSheetData.isInBronze(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			if(googleSheetData.isInSilver(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			if(googleSheetData.isInGold(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			if(isAdminAccess()) return true;
			return false;
		}
		
		public function isSilverTier():Boolean {
			if(isAdminAccess()) return true;
			
			if(googleSheetData.isInSilver(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			if(googleSheetData.isInGold(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			return false;
		}
		
		
		public function isAdminAccess():Boolean {
			if(TwitchConnection.instance == null) return false;
			if(TwitchConnection.instance.isUserAmemberOfKOTS()) return true;
			return false;
		}
	}
}
