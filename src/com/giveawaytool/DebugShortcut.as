package com.giveawaytool {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_Menu;
	import com.MetaIRCMessage;
	import com.giveawaytool.ui.UI_Donation;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.ui.Keyboard;

	/**
	 * @author LachhhSSD
	 */
	public class DebugShortcut extends ActorComponent {
		public function DebugShortcut() {
			super();
		}

		override public function update() : void {
			super.update();
			/*if(KeyManager.IsKeyPressed(Keyboard.NUMBER_1)) {
				var ui : UI_Donation = UIBase.manager.getFirst(UI_Donation) as UI_Donation;
				var ircMsg : MetaIRCMessage = MetaIRCMessage.createDummyHost();
				UI_Menu.logicNotification.logicHostAlert.processIRCMsg(ircMsg);
			}
			
			if(KeyManager.IsKeyPressed(Keyboard.NUMBER_2)) {
				var ui : UI_Donation = UIBase.manager.getFirst(UI_Donation) as UI_Donation;
				var ircMsg : MetaIRCMessage = MetaIRCMessage.createDummyHost();
				ircMsg.text = "GrosPenis is now hosting you for 55 viewers.";
				ui.logicNotification.logicHostAlert.processIRCMsg(ircMsg);
			}*/
			
			if(KeyManager.IsKeyPressed(Keyboard.DELETE)) {
				MetaGameProgress.instance.metaFollowConfig.metaHasBeenTested.clear();
				MetaGameProgress.instance.metaSubsConfig.metaHasBeenTested.clear();
				MetaGameProgress.instance.metaHostAlertConfig.metaHasBeenTested.clear();
				MetaGameProgress.instance.metaDonationsConfig.metaHasBeenTested.clear();
				MetaGameProgress.instance.metaCheerAlertConfig.metaHasBeenTested.clear();
				//MetaGameProgress.instance.saveToLocal();
				UIBase.manager.refresh();
			}
		}
	}
}
