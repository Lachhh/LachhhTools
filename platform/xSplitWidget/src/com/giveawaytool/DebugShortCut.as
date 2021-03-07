package com.giveawaytool {
	import com.giveawaytool.meta.MetaHostAlert;
	import com.giveawaytool.meta.MetaNewDonation;
	import com.giveawaytool.meta.MetaSubcriberAlert_widget;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.giveawaytool.meta.twitch.MetaTwitchEmote;
	import com.giveawaytool.ui.MetaCmdEmoteFirework;
	import com.giveawaytool.ui.MetaNewFollowerAlert;
	import com.giveawaytool.ui.UI_Charity;
	import com.giveawaytool.ui.UI_NewCheerAnimExplode;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class DebugShortCut extends ActorComponent {
		public function DebugShortCut() {
			super();
		}

		override public function update() : void {
			super.update();
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_0)) {
				var metaSubAlert:MetaSubcriberAlert_widget = new MetaSubcriberAlert_widget();
				metaSubAlert.name = "hiimmikegaming";
				metaSubAlert.numMonthInARow = 6;
				var d:Dictionary = metaSubAlert.encode();
				d.type = "subAlert";
				MainGame.logicListenToMain.handleMsg(d);
			}
			
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_1)) {
				var metaNewFollow:MetaNewFollowerAlert = new MetaNewFollowerAlert();
				
				metaNewFollow.name = "Lachhh";
				
				var d:Dictionary = metaNewFollow.encode();
				d.type = "followAlert";
				MainGame.logicListenToMain.handleMsg(d);
			}
			
			var metaDonation:MetaNewDonation;
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_2)) {
				metaDonation = MetaNewDonation.createDummy();
				metaDonation.amount = 25;
				metaDonation.amountThisDay = 25;
				var d:Dictionary = metaDonation.encode();
				d.type = "newDonation";
				MainGame.logicListenToMain.handleMsg(d);
			}
						
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_3)) {
				VersionInfo.lachhhistersTweet = false;
				var metaTwitter:MetaTwitterAlert = MetaTwitterAlert.createDummy();
				metaTwitter.message = ".#Lachhhisters sucks balls! LOL";
				metaTwitter.searchedFor = "sucks";
				var d:Dictionary = metaTwitter.encode();
				d.type = "tweetAlert";
				MainGame.logicListenToMain.handleMsg(d);
			}
			
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_4)) {
				metaDonation = MetaNewDonation.createDummy();
				metaDonation.donatorName = "James";
				metaDonation.donatorMsg = "Lol nope";
				metaDonation.amount = 37;
				metaDonation.amountThisDay = 37;
				metaDonation.amountThisWeek = 37;
				var d:Dictionary = metaDonation.encode();
				d.type = "newDonation";
				MainGame.logicListenToMain.handleMsg(d);
			}
			
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_5)) {
				VersionInfo.lachhhistersTweet = true;
				var metaTwitter:MetaTwitterAlert = MetaTwitterAlert.createDummy();
				metaTwitter.message = ".#Lachhhisters sucks balls! LOL";
				metaTwitter.searchedFor = "#Lachhhisters";
				var d:Dictionary = metaTwitter.encode();
				d.type = "tweetAlert";
				MainGame.logicListenToMain.handleMsg(d);
			}
			
			
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_6)) {
				
				var metaHost:MetaHostAlert = MetaHostAlert.createDummy();
				var d:Dictionary = metaHost.encode();
				d.type = "hostAlert";
				MainGame.logicListenToMain.handleMsg(d);
			}
			
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_7)) {
				var metaHost2:MetaHostAlert = MetaHostAlert.createDummy();
				metaHost2.numViewers = 57;
				var d:Dictionary = metaHost2.encode();
				d.type = "hostAlert";
				MainGame.logicListenToMain.handleMsg(d);
			}
			
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_8)) {
				var ui:UI_Charity = UIBase.manager.getFirst(UI_Charity) as UI_Charity;
				if(ui == null) return ;
				ui.wait = -50000;
			}
			
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_9)) {
				//var ui:UI_Charity = UIBase.manager.getFirst(UI_Charity) as UI_Charity;
				//if(ui == null) return ;
				//ui.wait = -50000;
				MetaCmdEmoteFirework.loadAndSpawnEmoteWithDelay(MetaTwitchEmote.createDummy(), 1);
				
			}
			
			if(KeyManager.IsKeyPressed(Keyboard.INSERT)) {
				//var ui:UI_Charity = UIBase.manager.getFirst(UI_Charity) as UI_Charity;
				//if(ui == null) return ;
				//ui.wait = -50000;
				MetaCmdEmoteFirework.loadAndSpawnEmoteWithDelay(MetaTwitchEmote.createDummy(), 1);
			}
			
			if (KeyManager.IsKeyPressed(Keyboard.NUMPAD_5)) sendCheerMsg(10000);
			if (KeyManager.IsKeyPressed(Keyboard.NUMPAD_4)) sendCheerMsg(5000);
			if (KeyManager.IsKeyPressed(Keyboard.NUMPAD_3)) sendCheerMsg(1000);
			if (KeyManager.IsKeyPressed(Keyboard.NUMPAD_2)) sendCheerMsg(100);
			if (KeyManager.IsKeyPressed(Keyboard.NUMPAD_1)) sendCheerMsg(50);
			if (KeyManager.IsKeyPressed(Keyboard.NUMPAD_0)) sendCheerMsg(1);
			
			if (KeyManager.IsKeyPressed(Keyboard.NUMPAD_6)) {
				new UI_NewCheerAnimExplode();
			}
			
		}
		
		private function sendCheerMsg(amount:int):void {
			var metaCheerAlert : MetaCheerAlert = MetaCheerAlert.createDummy();
			metaCheerAlert.numBits = Math.random()*(amount*.5)+amount;
			metaCheerAlert.name = "m." + metaCheerAlert.numBits;
			if(amount == 1) metaCheerAlert.numBits = 1; 
			var d:Dictionary = metaCheerAlert.encode();
			d.type = "cheerAlert";
			MainGame.logicListenToMain.handleMsg(d);			
		}
	}
}
