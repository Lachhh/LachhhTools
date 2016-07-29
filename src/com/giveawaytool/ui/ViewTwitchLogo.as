package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class ViewTwitchLogo extends ViewBase {
		public var viewAvatarLogo:ViewAvatarLogo;
		public function ViewTwitchLogo(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewAvatarLogo = new ViewAvatarLogo(pScreen, pVisual);
		}

		override public function refresh() : void {
			super.refresh();
			if(!TwitchConnection.isLoggedIn()) {
				viewAvatarLogo.bmpData = null;
				viewAvatarLogo.refresh();
				return ;
			}
			if(TwitchConnection.instance.channelData.logoBmpData == null) {
				TwitchConnection.instance.channelData.refreshLogo(new Callback(refresh, this, null), null);
			} else {
				viewAvatarLogo.bmpData = TwitchConnection.instance.channelData.logoBmpData; 
			}
			viewAvatarLogo.refresh();
		}
	}
}
