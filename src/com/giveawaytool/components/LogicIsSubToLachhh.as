package com.giveawaytool.components {
	import playerio.DatabaseObject;

	import com.giveawaytool.MainGame;
	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.giveawaytool.io.playerio.LogicServerGameWispCheck;
	import com.giveawaytool.io.playerio.MetaGameWispSub;
	import com.giveawaytool.io.playerio.MetaServerProgress;
	import com.giveawaytool.io.playerio.ModelExternalPremiumAPIEnum;
	import com.giveawaytool.io.playerio.ModelPatreonRewardEnum;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_AnnoyingPopup;
	import com.giveawaytool.ui.UI_LachhhToolsAds;
	import com.giveawaytool.ui.UI_LachhhToolsAds2;
	import com.giveawaytool.ui.UI_Loading;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class LogicIsSubToLachhh extends ActorComponent {
		
		private var isLoaded : Boolean = false;
		public var logicServerGameWisp : LogicServerGameWispCheck;
		private var success : Callback;

		public function LogicIsSubToLachhh() {
			super();
			PlayerIOLachhhRPGController.InitInstance(MainGame.instance, ModelExternalPremiumAPIEnum.TWITCH, VersionInfo.pioDebug);
			logicServerGameWisp = new LogicServerGameWispCheck();
		}
				

		public function connect(success:Callback) : void {
			this.success = success;
			PlayerIOLachhhRPGController.getInstance().mySecuredConnection.SecureConnectTwitch(TwitchConnection.instance.accessToken, new Callback(onLoginSuccess, this, null), new Callback(onLoginError, this, null));
			UI_Loading.show("Connecting to Server");
		}

		private function onLoginSuccess() : void {
			PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connectToGameRoom(new Callback(onConnectedToGame, this, null));
		}

		private function onConnectedToGame() : void {
			MetaServerProgress.instance.loadTwitchSub(TwitchConnection.getNameOfAccount(), new Callback(onLoadMySub, this, null), new Callback(onLoginError, this, null));
			MetaGameProgress.instance.metaLachhhToolGameWispSub.loadIfEmpty();
		}

		private function onLoadMySub(db:DatabaseObject) : void {
			
			MetaGameProgress.instance.metaGameWispClientSubToLachhhTools = MetaGameWispSub.createFromDb(db); 
		
			isLoaded = true;
			if(LogicVIPAccess.isAdminAccess()) {
				logicServerGameWisp.fetchServerData();
			} else {
				logicServerGameWisp.validateToken(MetaGameProgress.instance.metaGameWispConnection.lastAccessToken, new Callback(onValidate, this, null));
			}
			
			if(success) success.call();
		}

		private function onValidate() : void {
			MetaGameProgress.instance.metaGameWispConnection.lastAccessToken = "";
		}
		
		public function checkToShowAds():void {
			
			if(!shouldShowAnnoying()) return ;
			/*new UI_LachhhToolsAds2();
			return ;*/ 
			if(Math.random() < 0.33) {
				new UI_AnnoyingPopup();
			} else if(Math.random() < 0.5) { 
				new UI_LachhhToolsAds();
			} else {
				new UI_LachhhToolsAds2();
			}
		}
		
		public function shouldShowAnnoying():Boolean {
			if(!MetaGameProgress.instance.atLeastOneHasBeenTested()) return false;
			if(!isLoaded) return false;
			if(isBronzeTier()) return false;
			if(isSilverTier()) return false;
			
			return true;
		}
		
		public function isBronzeTier():Boolean {
			if(MetaGameProgress.instance.metaGameWispClientSubToLachhhTools == null) return false;
			if(ModelPatreonRewardEnum.STREAMER_BRONZE.gameWispUserMeetsReward(MetaGameProgress.instance.metaGameWispClientSubToLachhhTools)) return true;
			return false;
		}
		
		public function isSilverTier():Boolean {
			if(MetaGameProgress.instance.metaGameWispClientSubToLachhhTools == null) return false;
			if(ModelPatreonRewardEnum.STREAMER_SILVER.gameWispUserMeetsReward(MetaGameProgress.instance.metaGameWispClientSubToLachhhTools)) return true;
			return false;
		}

		private function onLoginError() : void {
			UI_Loading.hide();
		}
	}
}
