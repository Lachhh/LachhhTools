package com.flashinit {
	import com.giveawaytool.MainGameTools;
	import com.giveawaytool.components.LogicIsSubToLachhh;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;
	/**
	 * @author LachhhSSD
	 */
	public class DebugLachhhToolsInitLocalServer extends Sprite {
		public function DebugLachhhToolsInitLocalServer() {
			super();
			VersionInfo.pioDebug = true;
			VersionInfo.isDebug = true;
			var m:MainGameTools = new MainGameTools();
			stage.addChild(m);
			m.init();
			new UI_Menu();
			LogicIsSubToLachhh.DEBUG_AlwaysShowAds = true;
		}
	}
}
