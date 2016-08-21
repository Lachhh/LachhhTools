package com.flashinit {
	import com.giveawaytool.MainGame;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author LachhhSSD
	 */
	public class ReleasePlayMovie extends Sprite {
		public function ReleasePlayMovie() {
			super();
			
			VersionInfo.isDebug = false;
			
			
			//m.startDebug();
			
			
			//new UIDonationTest();
			//new UI_Donation();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
			m.startPlayMovie();
		}
	}
}
