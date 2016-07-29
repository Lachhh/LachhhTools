package com.giveawaytool.meta {
	import com.giveawaytool.io.twitch.MetaTwithConnection;
	import com.kojaktsl.TwitterAPI.MetaTweet;
	import com.giveawaytool.meta.donations.MetaDonationsConfig;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.sfx.JukeBox;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameProgress {
		static public var instance:MetaGameProgress = new MetaGameProgress();
		public var winners:Array;
		
		public var metaGiveawayConfig : MetaGiveawayConfig;
		public var metaCountdownConfig : MetaCountdownConfig;
		public var metaExportPNGConfig : MetaExportPNGConfig;
		public var metaShareOnTwitter : MetaShareOnTwitter;
		public var metaToolConfig: MetaToolConfig;
		public var metaDonationsConfig : MetaDonationsConfig;
		public var metaTweetAlertConfig : MetaTweetAlertConfig ;
		public var metaSubsConfig : MetaSubsConfig;
		public var metaFollowConfig : MetaFollowConfig;
		public var metaTwitchConnection : MetaTwithConnection;
		public var metaTwitchChat : MetaTwitchChat;
		
		private var saveData : Dictionary = new Dictionary();
		
		public function MetaGameProgress() {			
			clear();
		}
		
		public function DEBUGDummyValues():void {
			//Debug game progress here 
		}
		
		public function clear():void {
			winners = [];
			
			metaGiveawayConfig = new MetaGiveawayConfig();
			metaCountdownConfig = new MetaCountdownConfig();
			metaExportPNGConfig = new MetaExportPNGConfig();
			metaToolConfig = new MetaToolConfig();
			metaShareOnTwitter = new MetaShareOnTwitter();
			metaDonationsConfig = new MetaDonationsConfig();
			metaSubsConfig = new MetaSubsConfig();
			metaTweetAlertConfig = new MetaTweetAlertConfig();
			metaTwitchConnection = new MetaTwithConnection();
			metaFollowConfig = new MetaFollowConfig();
			metaTwitchChat = new MetaTwitchChat();
		}
		
		public function encode():Dictionary {
			saveData["winners"] = winners;
			saveData["jukebox"] = JukeBox.getInstance().encode();
			saveData["metaGiveawayConfig"] = metaGiveawayConfig.encode();
			saveData["metaCountdownConfig"] = metaCountdownConfig.encode();
			saveData["metaExportPNGConfig"] = metaExportPNGConfig.encode();
			saveData["metaToolConfig"] = metaToolConfig.encode();
			saveData["metaShareOnTwitter"] = metaShareOnTwitter.encode();
			saveData["metaDonationsConfig"] = metaDonationsConfig.encode();
			saveData["metaSubsConfig"] = metaSubsConfig.encode();
			saveData["metaTweetAlertConfig"] = metaTweetAlertConfig.encode();
			saveData["metaTwitchConnection"] = metaTwitchConnection.encode();
			saveData["metaFollowConfig"] = metaFollowConfig.encode();
			
			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			winners = obj["winners"];
			JukeBox.getInstance().decode(obj["jukebox"]);
			
			metaGiveawayConfig.decode(obj["metaGiveawayConfig"]) ;
			metaCountdownConfig.decode(obj["metaCountdownConfig"]) ;
			metaExportPNGConfig.decode(obj["metaExportPNGConfig"]) ;
			metaToolConfig.decode(obj["metaToolConfig"]) ;
			metaShareOnTwitter.decode(obj["metaShareOnTwitter"]) ;
			metaDonationsConfig.decode(obj["metaDonationsConfig"]) ;
			metaSubsConfig.decode(obj["metaSubsConfig"]) ;
			metaTweetAlertConfig.decode(obj["metaTweetAlertConfig"]) ;
			metaTwitchConnection.decode(obj["metaTwitchConnection"]) ;
			metaFollowConfig.decode(obj["metaFollowConfig"]) ;

			if(winners == null) winners = [];
		}
		
		
		
		public function isEmpty():Boolean {
			return (winners.length <= 0);
		}		
		
		public function saveToLocal():void {
			 DataManager.saveLocally(encode());
		}
		
		public function loadFromLocal():void {
			if(DataManager.isEmpty) {
				return ;
			}
			
			var d:Dictionary = DataManager.loadLocally();
			decode(d);
		}
	}
}
