package com.giveawaytool.components {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class LogicPatreonAccess extends ActorComponent {
		public function LogicPatreonAccess() {
			super();
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
		
		public function canUseAlerts():Boolean {return isBronzeTier();}
		
		public function isBronzeTier():Boolean {
			return isAdminAccess();
		}
		
		public function isSilverTier():Boolean {
			return isAdminAccess();
		}
		
		public function isAdminAccess():Boolean {
			if(TwitchConnection.instance == null) return false;
			if(TwitchConnection.instance.isUserAmemberOfKOTS()) return true;
			return false;
		}
	}
}
