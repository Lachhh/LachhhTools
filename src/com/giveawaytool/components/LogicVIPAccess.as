package com.giveawaytool.components {
	import com.giveawaytool.ui.UI_Menu;
	import com.animation.exported.UI_MENU;
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
	public class LogicVIPAccess extends ActorComponent {
		public var googleSheetData : GoogleSheetData_Patreon = new GoogleSheetData_Patreon(null);
		public function LogicVIPAccess() {
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
		
		public function canSendFollowIfNotLive():Boolean {return /*isBronzeTier() || !TwitchConnection.instance.isLive || */ true;}		
		public function canSendHostIfNotLive():Boolean {return /*isBronzeTier() || !TwitchConnection.instance.isLive || */ true;}		
		public function canSendSubIfNotLive():Boolean {return /*isBronzeTier() || !TwitchConnection.instance.isLive || */ true;}
		public function canSendCheersIfNotLive():Boolean {return /*isSilverTier() || !TwitchConnection.instance.isLive || */ true;}		
		public function canSendDonationIfNotLive():Boolean {return /*isSilverTier() || !TwitchConnection.instance.isLive || */ true;}
		
		public function isBronzeTier():Boolean {
			if(UI_Menu.instance.logicNotification.logicIsSubToLachhh.isBronzeTier()) return true;
			if(googleSheetData.isInBronze(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			if(googleSheetData.isInSilver(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			if(googleSheetData.isInGold(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			if(isAdminAccess()) return true;
			return false;
		}
		
		public function isSilverTier():Boolean {
			if(isAdminAccess()) return true;
			if(UI_Menu.instance.logicNotification.logicIsSubToLachhh.isBronzeTier()) return true;
			if(UI_Menu.instance.logicNotification.logicIsSubToLachhh.isSilverTier()) return true;
			if(googleSheetData.isInSilver(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			if(googleSheetData.isInGold(TwitchConnection.getNameOfAccountWithTwitchPrefix())) return true;
			return false;
		}
		
		
		static public function isAdminAccess():Boolean {
			if(TwitchConnection.instance == null) return false;
			if(TwitchConnection.instance.isUserAmemberOfKOTS()) return true;
			return false;
		}
		
		static public function isLachhh():Boolean {
			if(TwitchConnection.instance == null) return false;
			if(TwitchConnection.instance.isLachhhAndFriends()) return true;
			return false;
		}
	}
}
