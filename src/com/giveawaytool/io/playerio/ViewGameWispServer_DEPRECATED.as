package com.giveawaytool.io.playerio {
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.UI_Loading;
	import com.giveawaytool.ui.UI_PopUp;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewGameWispServer_DEPRECATED extends ViewBase {
		public function ViewGameWispServer_DEPRECATED(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			statusMsgMc.gotoAndStop(1);
			screen.setNameOfDynamicBtn(connectBtn, "Reactivate");
			screen.setNameOfDynamicBtn(refreshDbBtn, "Force Refresh Database");

			screen.registerClick(connectBtn, onConnect);
			screen.registerClick(refreshDbBtn, onForceRefresh);
		}

		private function onForceRefresh() : void {
			UI_PopUp.createOkOnly("Is not coded yet.  I'm too lazy and the DB refresh itself every 5 minutes anyway so fuck that I'll go watch Walking dead.", null);
		}

		private function onConnect() : void {
			UI_PopUp.createLoading("Loading...");
			//UI_Menu.instance.logicNotification.logicGameWisp.logicServerGameWisp.tryToSendNewAccessTokenToDB(new Callback(onSuccess, this, null), new Callback(onError, this, null));
			onSuccess();
		}

		private function onSuccess() : void {
			UI_PopUp.closeAllPopups();
			UI_PopUp.createOkOnly("All done!", null);
			UIBase.manager.refresh();
		}

		private function onError() : void {
			UI_PopUp.closeAllPopups();
			UI_PopUp.createOkOnly("Oops, something went wrong...", null);
			UIBase.manager.refresh();
		}

		override public function refresh() : void {
			super.refresh();
			
			var isConnected:Boolean = UI_Menu.instance.logicNotification.logicIsSubToLachhh.logicServerGameWisp.isConnected();
			if(isConnected) {
				statusMsgMc.gotoAndStop(3);
			} else {
				statusMsgMc.gotoAndStop(1);
			}
		}

		public function get statusMsgMc() : MovieClip {return visual.getChildByName("statusMsgMc") as MovieClip;}
		public function get connectBtn() : MovieClip { return visual.getChildByName("connectBtn") as MovieClip;}
		public function get refreshDbBtn() : MovieClip { return visual.getChildByName("refreshDbBtn") as MovieClip;}
	}
}
