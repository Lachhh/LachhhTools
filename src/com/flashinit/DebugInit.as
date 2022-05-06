package com.flashinit {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.components.LogicIsSubToLachhh;
	import com.giveawaytool.MainGameTools;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * @author LachhhSSD
	 */
	public class DebugInit extends Sprite {
		private var mainWindow : NativeWindow;
		private var newWindow : NativeWindow;
		private var windowWidget : WidgetInWindow;

		public function DebugInit() {
			super();
			//VersionInfo.pioDebug = true;
			VersionInfo.isDebug = true;
			var m:MainGameTools = new MainGameTools();
			stage.addChild(m);
			m.init();
			new UI_Menu();
			//MetaGameProgress.instance.firstLogin = true;
			LogicIsSubToLachhh.DEBUG_AlwaysShowAds = true;
			
		}
	}
}
