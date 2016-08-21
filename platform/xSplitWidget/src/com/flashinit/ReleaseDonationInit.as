package com.flashinit {
	import com.giveawaytool.MainGame;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author LachhhSSD
	 */
	public class ReleaseDonationInit extends Sprite {
		public function ReleaseDonationInit() {
			super();
			VersionInfo.isDebug = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
			m.startNormalDonation();
		}
	}
}
