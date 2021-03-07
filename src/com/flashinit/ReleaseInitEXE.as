package com.flashinit {
	import com.giveawaytool.MainGameTools;
	import com.giveawaytool.ui.UI_GiveawayMenu;
	import com.giveawaytool.ui.UI_Updater;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;

	/**
	 * @author LachhhSSD
	 */
	public class ReleaseInitEXE extends Sprite {
		public function ReleaseInitEXE() {
			
			VersionInfo.isDebug = false;
			var m:MainGameTools = new MainGameTools();
			stage.addChild(m);
			m.init();
			new UI_Updater("http://lachhhAndFriends.com/twitchTool/update_flashEXE.xml");
		}				
	}
}




