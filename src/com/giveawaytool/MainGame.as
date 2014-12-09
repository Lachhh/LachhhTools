package com.giveawaytool {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.scenes.GameSceneManager;
	import com.giveawaytool.ui.UIPopUp;
	import com.giveawaytool.ui.UI_LoterySpin;
	import com.lachhh.flash.debug.UIFontLoopkup;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	public class MainGame extends DefaultMainGame {
		static public var instance:MainGame;
		public var gameSceneManager:GameSceneManager = new GameSceneManager();
		
		static public var dummyActor:Actor = new Actor();
		
		public function MainGame() {
			
		}
		
		override public function init():void{
			super.init();
			instance = this;
						
			UIBase.manager.add(dummyActor);
			
			
			/*if(VersionInfo.isDebug) {
				MetaGameProgress.instance.DEBUGDummyValues();
				
				gameSceneManager.loadScene(new GameScene());
				
			} else {
				MetaGameProgress.instance.loadFromLocal();
				stage.quality = StageQuality.MEDIUM;				
			}*/
			
			//stage.frameRate = 60;
			//new UI_LoterySpin();
			
			stage.scaleMode = StageScaleMode.NO_BORDER;
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.color = 0x000000;
			
			new UIFontLoopkup();
			
			try {
				MetaGameProgress.instance.loadFromLocal();
			} catch(e:Error) {
				UIPopUp.createOkOnly("Error Loading config :(", null);
			}
		}
		
		/*public function loadExternalNamesForLotery():void {
			var myTextLoader:URLLoader = new URLLoader();

			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);
			
			function onLoaded(e:Event):void {
				var names:String = e.target.data;
				var arrayOfNames:Array = nameToArray(names);
				new UI_LoterySpin(arrayOfNames);
			}
			
			myTextLoader.load(new URLRequest("names.txt"));
		}*/
				
		
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
