package com.flashinit {
	import com.giveawaytool.ui.UI_SimpleCountdown;
	import com.giveawaytool.ui.UI_Charity;
	import com.giveawaytool.MainGame;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author LachhhSSD
	 */
	public class CountdownInit extends Sprite {
		public function CountdownInit() {
			super();
			
			VersionInfo.isDebug = false;
			VersionInfo.charityOnly = true;
			VersionInfo.showSub = false;
			VersionInfo.showGaz = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
			//m.startDebug();
			
			new UI_SimpleCountdown();
		}
	}
}
