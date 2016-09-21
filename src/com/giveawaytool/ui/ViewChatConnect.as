package com.giveawaytool.ui {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewChatConnect extends ViewBase {
		public function ViewChatConnect(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			screen.setNameOfDynamicBtn(retryBtn, "RECONNECT");

			screen.registerClick(retryBtn, onRetry);
			
			refresh();
		}

		private function onRetry() : void {
			UI_Menu.instance.logicNotification.logicListenToChat.quickConnect();
			refresh();
			retryBtn.select();
		}


		override public function refresh() : void {
			super.refresh();
			
			visual.visible = TwitchConnection.isLoggedIn();
			 
			if(!isConnected()) {
				chatTxt.text = "CHAT OFFLINE";
				chatTxt.textColor = 0xCC0000;
			} else {
				chatTxt.text = "Connected to chat";
				chatTxt.textColor = 0x00CC00;
			}
			retryBtn.deselect();
		}
		
		private function isConnected():Boolean {
			if(UI_Menu.instance.logicNotification.logicListenToChat == null) return false;
			return UI_Menu.instance.logicNotification.logicListenToChat.isConnected(); 
		}

		public function get chatTxt() : TextField {return visual.getChildByName("chatTxt") as TextField;}
		public function get retryBtn() : ButtonSelect { return visual.getChildByName("retryBtn") as ButtonSelect;}
		
	}
}
