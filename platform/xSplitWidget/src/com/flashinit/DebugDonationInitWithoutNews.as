package com.flashinit {
	import com.giveawaytool.MainGame;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author LachhhSSD
	 */
	public class DebugDonationInitWithoutNews extends Sprite {
		public function DebugDonationInitWithoutNews() {
			super();
			
			VersionInfo.isDebug = false;
			VersionInfo.showNewsWhenNothing = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
			m.startDebugNoNews();
			
			
		}
	}
}
