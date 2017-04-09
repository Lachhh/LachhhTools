package com.giveawaytool.ui {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.io.playerio.GameWispConnection;
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
	public class ViewGameWispSubAlert extends ViewBase {
		public var callbackOnConnectionChanged:Callback;
		public function ViewGameWispSubAlert(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			visualMc.gotoAndStop(1);
			screen.registerClick(logoutBtn, onLogOut);
		}

		private function onLogOut() : void {
			if (isConnected()) {
				logOut();
			} else {
				connect();
			}
		}

		private function logOut() : void {
			GameWispConnection.getInstance().logout();
			MetaGameProgress.instance.metaGameWispConnection.lastAccessToken = "";
			if(callbackOnConnectionChanged) callbackOnConnectionChanged.call();
			refresh();
		}

		private function connect() : void {
			UI_PopUp.createOkOnly("A webpage should be opened.  Authorize the LachhhTools there and come back!", null);
			GameWispConnection.getInstance().fecthNewAccessToken(new Callback(onSuccess, this, null), new Callback(onError, this, null));
		}
		
		private function onSuccess() : void {
			MetaGameProgress.instance.metaGameWispConnection.lastAccessToken = GameWispConnection.instance.accessTokenClient;
			MetaGameProgress.instance.metaGameWispConnection.channelInfo.decode(GameWispConnection.instance.metaChannelInfo.encode());
			MetaGameProgress.instance.saveToLocal();
			
			UI_PopUp.closeAllPopups();
			UI_PopUp.createOkOnly("All good!", null);
			if(callbackOnConnectionChanged) callbackOnConnectionChanged.call();
			refresh();
		}

		private function onError() : void {
			UI_PopUp.closeAllPopups();
			UI_PopUp.createOkOnly("Oops, something went wrong trying to connect you on GameWisp...", null);
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			if(isConnected()) {
				visualMc.gotoAndStop(2);
				
				connectedText.text = getTextConnected();
				connectedText.textColor = 0x006600;
				screen.setNameOfDynamicBtn(logoutBtn, "Log Out");
			} else {
				visualMc.gotoAndStop(1);
				connectedText.text = "Not Connected";
				connectedText.textColor = 0x660000;
				screen.setNameOfDynamicBtn(logoutBtn, "Connect");
			}
			Utils.SetMaxSizeOfTxtField(connectedText, 12);
		}
		
		private function getTextConnected():String {
			var name:String = MetaGameProgress.instance.metaGameWispConnection.channelInfo.displayName;
			
			if(name.length < 12) {
				return "Welcome\n" + name;
			} else {
				return "Connected Successfully";
			}
		}
		
		private function isConnected():Boolean {
			return GameWispConnection.getInstance().isConnected();
		}
		
		public function get logoutBtn() : MovieClip { return visual.getChildByName("logoutBtn") as MovieClip;}
		public function get newSubGamewispBtn() : MovieClip { return visual.getChildByName("newSubGamewispBtn") as MovieClip;}
		public function get connectedText() : TextField { return visual.getChildByName("connectedText") as TextField;}
	}
}
