package com.giveawaytool.ui {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewTwitchConnect extends ViewBase {
		public var firstAutoSign : Boolean = true;
		public var viewTwitchLogo : ViewTwitchLogo;
		public var viewGameWispBadge : ViewGameWispBadge;
		public function ViewTwitchConnect(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewTwitchLogo = new ViewTwitchLogo(screen, avatarMc);
			viewGameWispBadge = new ViewGameWispBadge(screen, myGameWispSubMc);
			screen.setNameOfDynamicBtn(logOutBtn, "Log Out");
			screen.setNameOfDynamicBtn(logInBtn, "LogIn");

			screen.registerClick(logInBtn, onLogin);
			screen.registerClick(logOutBtn, onLogout);
			
			TwitchConnection.instance = new TwitchConnection(true);
			TwitchConnection.instance.onConnect = new Callback(onConnected, this, null);
			TwitchConnection.instance.onConnectError = new Callback(onError, this, null);
			TwitchConnection.instance.accessToken = MetaGameProgress.instance.metaTwitchConnection.lastAccessTokenHelix;
			
			//GameWispConnection_DEPRECATED.getInstance().validateClientToken(MetaGameProgress.instance.metaGameWispConnection.lastAccessToken, null);
			refresh();
		}

		override public function start() : void {
			super.start();
			if(MetaGameProgress.instance.metaTwitchConnection.hasLoggedInBefore()) {
				onLogin();
			} else {
				firstAutoSign = false;
			}
			
		}

		public function onLogin() : void {
			TwitchConnection.instance.connect();
			UI_Loading.show("Connecting to Twitch");
		}

		private function onError() : void {
			UI_Loading.hide();
			UI_PopUp.createOkOnly("Oops! Something went wrong... : " + TwitchConnection.instance.connectErrorMsg, null);
			firstAutoSign = false;
			TwitchConnection.instance.accessToken = "";
			MetaGameProgress.instance.metaTwitchConnection.lastAccessTokenHelix = "";
			MetaGameProgress.instance.saveToLocal();
			refresh();
		}

		private function onConnected() : void {
			refresh();
			screen.doBtnPressAnim(avatarMc);
			UI_Loading.hide();
			UI_PopUp.closeAllPopups();
			MetaGameProgress.instance.metaTwitchConnection.lastNameLogin = TwitchConnection.getNameOfAccount();
			MetaGameProgress.instance.metaTwitchConnection.lastAccessTokenHelix = TwitchConnection.instance.accessToken;
			
			MetaGameProgress.instance.saveToLocal();
			UI_Menu.instance.logicNotification.onConectedToTwitch();
			UIBase.manager.refresh();
			
			if(!firstAutoSign) UI_PopUp.createOkOnly("Welcome!\n" + TwitchConnection.getNameOfAccount(), null);
			firstAutoSign = false;
		}

		private function onLogout() : void {
			MetaGameProgress.instance.metaTwitchConnection.clear();
			MetaGameProgress.instance.saveToLocal();
			TwitchConnection.instance.logout(new Callback(onLogoutSuccess, this, null));
		}

		private function onLogoutSuccess() : void {
			
			UI_PopUp.createOkOnly("Logged Out successfully!", null);
			UIBase.manager.refresh();
		}

		override public function refresh() : void {
			super.refresh();
			logInBtn.visible = false;
			logOutBtn.visible = false;
			viewGameWispBadge.metaGameSub = MetaGameProgress.instance.metaGameWispClientSubToLachhhTools;
			viewGameWispBadge.refresh();
			if(!TwitchConnection.instance.isConnected()) {
				nameTxt.text = "OFFLINE";
				nameTxt.textColor = 0xCC0000;
				logInBtn.visible = true;
			} else {
				nameTxt.text = TwitchConnection.getNameOfAccount();
				logOutBtn.visible = true;
				nameTxt.textColor = 0xBAE4DD;
			}
		}

		public function get nameTxt() : TextField {return visual.getChildByName("nameTxt") as TextField;}
		public function get logOutBtn() : MovieClip { return visual.getChildByName("logOutBtn") as MovieClip;}
		public function get logInBtn() : MovieClip { return visual.getChildByName("logInBtn") as MovieClip;}
		public function get avatarMc() : MovieClip { return visual.getChildByName("avatarMc") as MovieClip;}
		public function get myGameWispSubMc() : MovieClip { return visual.getChildByName("myGameWispSubMc") as MovieClip;}
		
	}
}
