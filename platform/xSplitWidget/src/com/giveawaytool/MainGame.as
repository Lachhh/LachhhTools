package com.giveawaytool {
	import com.giveawaytool.scenes.GameScene;
	import com.giveawaytool.ui.UI_Charity;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.scenes.GameSceneManager;
	import com.giveawaytool.ui.LogicAddDonation;
	import com.giveawaytool.ui.LogicPlayMovie;
	import com.giveawaytool.ui.LogicTweetOnly;
	import com.giveawaytool.ui.UI_DebugText;
	import com.giveawaytool.ui.UI_DonationWidget;
	import com.giveawaytool.ui.UI_DummyOverlay;
	import com.giveawaytool.ui.UI_News;
	import com.lachhh.flash.debug.UIFontLoopkup;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.text.Font;
	public class MainGame extends DefaultMainGame {		
		static public var instance:MainGame;
		public var gameSceneManager:GameSceneManager = new GameSceneManager();
		
		static public var dummyActor : Actor = new Actor();
		static public var logicListenToMain : LogicAddDonation ;
		static public var logicListenToMainPlayMovie : LogicPlayMovie ;
		static public var logicLachhhTweetOnly : LogicTweetOnly ;
		
		public function MainGame() {
			
		}
		
		override public function init():void{
			super.init();
			var fonts:Array = Font.enumerateFonts();
			var b:Buzzsaw;
			var c:FontJD;
			var h:FontLivingHell;
			for (var i : int = 0; i < fonts.length; i++) {
				var f:Font = fonts[i];
				trace(f.fontName);
			}
			
			instance = this;
			
			UIBase.manager.add(dummyActor);
			
			//new UIFontLoopkup();
			gameSceneManager.loadScene(new GameScene());
			stage.color = 0x00ff00;
		}
		
		public function startNormalDonation():void {
			logicListenToMain = dummyActor.addComponent(new LogicAddDonation()) as LogicAddDonation;
			if(VersionInfo.showNewsWhenNothing) new UI_DonationWidget();
			createNews();
		}
		
		public function startNormalDonationWithoutNewsAndWidget():void {
			logicListenToMain = dummyActor.addComponent(new LogicAddDonation()) as LogicAddDonation;
			//uiWidget = new UI_DonationWidget();
			//createNews();
		}
		
		public function startPlayMovie():void {
			logicListenToMainPlayMovie = dummyActor.addComponent(new LogicPlayMovie()) as LogicPlayMovie;
			//stage.scaleMode = StageScaleMode.SHOW_ALL;
		}
		
		public function startLachhhistersTweetsOnly():void {
			logicLachhhTweetOnly = dummyActor.addComponent(new LogicTweetOnly()) as LogicTweetOnly;
			//stage.scaleMode = StageScaleMode.SHOW_ALL;
		}
		
		public function startDebugNoNews():void {
			logicListenToMain = dummyActor.addComponent(new LogicAddDonation()) as LogicAddDonation;
			logicListenToMain.metaDonationConfig = MetaDonationsConfig.createDummy() ;
			logicListenToMain.isDebug = true;
			//new UI_DummyOverlay();
			dummyActor.addComponent(new DebugShortCut());
		}
		
		public function startDebug():void {
			logicListenToMain = dummyActor.addComponent(new LogicAddDonation()) as LogicAddDonation;
			logicListenToMain.metaDonationConfig = MetaDonationsConfig.createDummy() ;
			logicListenToMain.isDebug = true;
			new UI_DonationWidget();
			createNews();
			new UI_DummyOverlay();
			dummyActor.addComponent(new DebugShortCut());
		}
		
		public function startHalloweenDebug():void {
			logicListenToMain = dummyActor.addComponent(new LogicAddDonation()) as LogicAddDonation;
			//logicListenToMain.metaDonationConfig = MetaDonationsConfig.createDummy() ;
			//logicListenToMain.isDebug = true;
			new UI_DonationWidget();
			createNews();
			//new UI_DummyOverlay();
			new UI_Charity();
			//dummyActor.addComponent(new DebugShortCut());
		}
		
		public function startDoIt():void {
			
		}
		
		public function startNormalWithDebugText():void {
			new UI_DonationWidget();
			createNews();
			new UI_DebugText();
		}
		
		public function createNews():void {
			if(UIBase.manager.hasInstanceOf(UI_News)) return ;
			if(!VersionInfo.showNewsWhenNothing) return ;
			new UI_News();
		}

		override public function update():void {
			super.update();
			gameSceneManager.update();
			KeyManager.update();	
		}
	}
}
