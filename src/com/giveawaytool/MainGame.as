package com.giveawaytool {
	import com.giveawaytool.io.GoogleAnalyticController;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.scenes.GameSceneManager;
	import com.giveawaytool.ui.UI_LoterySpin;
	import com.giveawaytool.ui.UI_PopUp;
	import com.lachhh.flash.debug.UIFontLoopkup;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	public class MainGame extends DefaultMainGame {
		static public var instance:MainGame;
		public var gameSceneManager:GameSceneManager = new GameSceneManager();
		
		static public var dummyActor : Actor = new Actor();
		static public var debugShortCut : DebugShortcut ;
		
		public function MainGame() {
			
		}
		
		override public function init():void{
			super.init();
			instance = this;
						
			UIBase.manager.add(dummyActor);
						
			stage.scaleMode = StageScaleMode.NO_BORDER;
			stage.color = 0x000000;
			
			new UIFontLoopkup();
			
			try {
				MetaGameProgress.instance.loadFromLocal();
			} catch(e:Error) {
				UI_PopUp.createOkOnly("Error Loading config :(", null);
			}
			
			if(VersionInfo.isDebug) {
				debugShortCut = dummyActor.addComponent(new DebugShortcut()) as DebugShortcut;
			}
			
			VersionInfo.trackerAPI = new GoogleAnalyticController(this, 'UA-50260892-4');
			VersionInfo.trackerAPI.trackView("Tools Opened");
		}				
		
		override public function update():void {
			super.update();
			gameSceneManager.update();
			KeyManager.update();
		}
		
		
		public function loadExternalNamesForLotery(channelName:String):void {
			   var myTextLoader:URLLoader = new URLLoader();
			   var url:String = "https://tmi.twitch.tv/group/user/" + channelName.toLocaleLowerCase() + "/chatters";
			   var request:URLRequest = new URLRequest(url);
			   
			   var loader:URLLoader = new URLLoader();
			   loader.addEventListener(Event.COMPLETE, onDataLoaded);
			   loader.load(request);
	 	 }
	  
	 	 private function onDataLoaded(event:Event) : void {
		   var loader:URLLoader = URLLoader(event.target);
		   trace("DATA = " + loader.data);
		   var obj:Object = JSON.parse(loader.data);
		   
		   new UI_LoterySpin(obj.chatters.viewers);
	 	 }
	}
}
