package com.giveawaytool.ui {
	import com.adobe.serialization.json.JSONDecoder;
	import com.giveawaytool.meta.MetaPlayMovie;
	import com.lachhh.io.Callback;
	import com.lachhh.io.SimpleSocket;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class LogicPlayMovie extends ActorComponent {
		private var socket : SimpleSocket;
		public var cmdGroup:MetaCmdGroupPlayMovie = new MetaCmdGroupPlayMovie();
		public var isDebug : Boolean = false;

		public function LogicPlayMovie() {
			super();
			socket = new SimpleSocket(9232); 
			socket.connect();
			socket.onNewData.addCallback(new Callback(onNewData, this, null));
		}
		
		
		private function onNewData() : void {
			if(socket.rawData == null) return ;
			var msgArray:Array = socket.rawData.split("\n");
			for (var i : int = 0; i < msgArray.length; i++) {
				var msg:String = msgArray[i];
				if(msg == null || msg == "") continue;
				var jsonDecoder:JSONDecoder = new JSONDecoder(msg,true);
	         	var data:Object = jsonDecoder.getValue();
				var d:Dictionary = DataManager.objToDictionary(data);
				handleMsg(d);		
			}
		}
		
		public function handleMsg(d:Dictionary):void {
			var newCmd:MetaCmd;
			switch(d.type) {
				case "playMovie" :
					stopAllAnim();
					var metaPlayMovie:MetaPlayMovie = createPlayMovieFromRawData(d);
					newCmd = new MetaCmdPlayMovie(metaPlayMovie);
					cmdGroup.addCommandToQueue(newCmd);
					break; 
				case "forceStopAnim" :
					stopAllAnim();
					break;
			}
			cmdGroup.tryToExecuteFirstCmd();
		}
		
		private function stopAllAnim():void {
			UIBase.manager.destroyAll(UI_FlvPlayer);
			cmdGroup.clear();
			JukeBox.fadeAllMusicToDestroy(120);
		}
				
		private function createPlayMovieFromRawData(rawData:Dictionary):MetaPlayMovie {			
			var result:MetaPlayMovie = new MetaPlayMovie();
			result.decode(rawData);
			return result;
		}
				
		override public function update() : void {
			super.update();
		}
	}
}
