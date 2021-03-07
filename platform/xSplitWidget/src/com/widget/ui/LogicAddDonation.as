package com.giveawaytool.ui {
	import com.giveawaytool.meta.twitch.MetaEmoteGroup;
	import com.giveawaytool.meta.twitch.MetaTwitchEmote;
	import com.giveawaytool.MetaCheerAlert;
	import com.adobe.serialization.json.JSONDecoder;
	import com.giveawaytool.meta.MetaDonationList;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaHostAlert;
	import com.giveawaytool.meta.MetaNewDonation;
	import com.giveawaytool.meta.MetaSubcriberAlert_widget;
	import com.giveawaytool.meta.MetaTwitterAlert;
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
	public class LogicAddDonation extends ActorComponent {
		public var metaDonationConfig : MetaDonationsConfig;
		private var socket : SimpleSocket;
		public var cmdGroup:MetaCmdGroup = new MetaCmdGroup();
		public var isDebug:Boolean= false;
		public function LogicAddDonation() {
			super();
			socket = new SimpleSocket(SimpleSocket.DEFAULT_PORT); 
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
				case "volumeMaster" :
					//JukeBox.getInstance().decode(d);
					/*newCmd = new MetaCmdPlayHalloweenAlert();
					cmdGroup.addCommandToQueue(newCmd);*/
					break;
				case "halloweenSpook" :
					newCmd = new MetaCmdPlayHalloweenAlert();
					cmdGroup.addCommandToQueue(newCmd);
					break;
				case "emoteFirework":
					var metaEmotes:MetaEmoteGroup = MetaEmoteGroup.createFromRawData(d); 
					newCmd = new MetaCmdEmoteFirework(metaEmotes);
					cmdGroup.addCommandToQueue(newCmd);
					break;
				case "tweetAlert" :
					var metaTwitter:MetaTwitterAlert = MetaTwitterAlert.createFromRawData(d);
					newCmd = new MetaCmdPlayTwitterAlert(metaTwitter);
					cmdGroup.addCommandToQueue(newCmd);
					break;
				case "refreshConfig" :
					var metaConfig:MetaDonationsConfig = MetaDonationsConfig.createFromRawData(d);
					newCmd = new MetaCmdRefreshConfig(metaConfig);
					cmdGroup.addCommandToQueue(newCmd);
					break;
				case "newDonation" :
					var metaDonation:MetaNewDonation = MetaNewDonation.createFromRawData(d);
					newCmd = new MetaCmdAddDonation(metaDonation);
					cmdGroup.addCommandToQueue(newCmd);
					break;
				case "cheerAlert" :
					var metaCheerAlert:MetaCheerAlert = MetaCheerAlert.createFromRawData(d);
					newCmd = new MetaCmdPlayCheerAlert(metaCheerAlert);
					cmdGroup.addCommandToQueue(newCmd);
					break; 
				case "hostAlert" :
					var metaHostAlert:MetaHostAlert = MetaHostAlert.createFromRawData(d);
					newCmd = new MetaCmdPlayHostAlert(metaHostAlert);
					cmdGroup.addCommandToQueue(newCmd);
					break; 
				case "subAlert" :
					var metaSubAlert:MetaSubcriberAlert_widget = MetaSubcriberAlert_widget.createFromRawData(d);
					newCmd = new MetaCmdPlaySubAlert(metaSubAlert);
					cmdGroup.addCommandToQueue(newCmd);
					break; 
				case "followAlert" :
					var metaNewFollower:MetaNewFollowerAlert = MetaNewFollowerAlert.createFromRawData(d);
					newCmd = new MetaCmdPlayNewFollowerAlert(metaNewFollower);
					cmdGroup.addCommandToQueue(newCmd);
					break; 
				
				case "newDonationList" :
					var donationsList:MetaDonationList = createDonationListFromRawData(d);
					for (var i : int = 0; i < donationsList.lastDonators.length; i++) {
						var m:MetaNewDonation = donationsList.lastDonators[i];
						newCmd = new MetaCmdAddDonation(m);
						cmdGroup.addCommandToQueue(newCmd);
					}
					break; 
				case "forceStopAnim" :
					UIBase.manager.destroyAll(UIDonationAdd);
					UIBase.manager.destroyAll(UIDonationBigGoalReached);
					UIBase.manager.destroyAll(UIDonationIntro);
					UIBase.manager.destroyAll(UIDonationIntroSmall);
					cmdGroup.clear();
					var metaConfig2:MetaDonationsConfig = MetaDonationsConfig.createFromRawData(d);
					newCmd = new MetaCmdRefreshConfig(metaConfig2);
					cmdGroup.addCommandToQueue(newCmd);
					JukeBox.fadeAllMusicToDestroy(120);
			}
			cmdGroup.tryToExecuteFirstCmd();
		}
		
		private function createDonationListFromRawData(rawData:Dictionary):MetaDonationList {
			var output:MetaDonationList = new MetaDonationList();			
			output.decode(rawData);
			return output;
		}

	}
}
