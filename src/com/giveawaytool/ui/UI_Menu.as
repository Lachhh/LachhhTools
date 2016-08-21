package com.giveawaytool.ui {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.DefaultMainGame;
	import com.giveawaytool.components.LogicNotifications;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Menu extends UIBase {
		private var viewCredits : ViewCredits;
		//private var logicOnOff :LogicOnOffNextFrame;
		private var wait:int = 0;
		public var logicNotification : LogicNotifications;
		public var viewMenuUISelect : ViewMenuUISelect;
		public var viewMenuAlerts : ViewMenuAlerts;
		public var viewTwitchConnect : ViewTwitchConnect;
		public var viewChatConnect : ViewChatConnect;
		public var viewOldMenu : ViewOldMenu;
		static public var instance:UI_Menu;

		public function UI_Menu() {
			super(AnimationFactory.ID_UI_MENU);
			instance = this;
			
			renderComponent.animView.stop();
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
						
			logicNotification = addComponent(new LogicNotifications(MetaGameProgress.instance)) as LogicNotifications;
			visual.gotoAndStop(1);
		}

		override public function start() : void {
			super.start();
			viewCredits = new ViewCredits(this, creditsBtn);
			viewMenuUISelect = new ViewMenuUISelect(this, menuSelectMc);
			viewMenuAlerts = new ViewMenuAlerts(this, alertMc);
			viewTwitchConnect = new ViewTwitchConnect(this, yourChannelMc);
			viewChatConnect = new ViewChatConnect(this, chatConnectMc);
			viewOldMenu = new ViewOldMenu(this, oldMenuMc);
			refresh();
		}

		override public function update() : void {
			super.update();
			
			visual.gotoAndStop(allowAccessToDonations() ? 2 : 1);
		}
		
		private function allowAccessToDonations():Boolean {
			if(!TwitchConnection.isLoggedIn()) return false;
			if(!TwitchConnection.instance.isUserAmemberOfKOTS()) return false;
			return true;
		}

		public function get yourChannelMc() : MovieClip {return visual.getChildByName("yourChannelMc") as MovieClip;}		
		public function get alertMc() : MovieClip { return visual.getChildByName("alertMc") as MovieClip;}
		public function get creditsBtn() : MovieClip {return visual.getChildByName("creditsBtn") as MovieClip;}
		public function get menuSelectMc() : MovieClip { return visual.getChildByName("menuSelectMc") as MovieClip;}
		public function get chatConnectMc() : MovieClip { return visual.getChildByName("chatConnectMc") as MovieClip;}

		public function get oldMenuMc() : MovieClip {
			return visual.getChildByName("oldMenuMc") as MovieClip;
		}

		public function show(b: Boolean) : void {
			visual.visible = b;
		}
		
		
		
	
	}
}
