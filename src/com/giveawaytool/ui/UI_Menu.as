package com.giveawaytool.ui {
	import com.TwitchLachhhIsLiveSimpleCheckUp;
	import com.flashinit.WidgetInWindow;
	import com.giveawaytool.DefaultMainGame;
	import com.giveawaytool.components.LogicNotifications;
	import com.giveawaytool.effect.ui.EffectShakeUI;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Menu extends UIBase {
		private var viewCredits : ViewCredits;
		
		public var logicNotification : LogicNotifications;
		public var viewMenuUISelect : ViewMenuUISelect;
		public var viewMenuAlerts : ViewMenuAlerts;
		public var viewTwitchConnect : ViewTwitchConnect;
		public var viewChatConnect : ViewChatConnect;
		public var viewOldMenu : ViewOldMenu;
		static public var instance : UI_Menu;
		private var windowWidget : WidgetInWindow;

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
			TwitchLachhhIsLiveSimpleCheckUp.checkIfDevsAreLive();
			TwitchLachhhIsLiveSimpleCheckUp.onRefreshed = new Callback(viewCredits.refresh, this, null);
			
			checkForNewWindow();
			refresh();
		}

		override public function update() : void {
			super.update();
			
			visual.gotoAndStop(allowAccessToDonations() ? 2 : 1);
		}

		override public function refresh() : void {
			super.refresh();
			alertMc.visible = TwitchConnection.isLoggedIn();
			//alertMc.visible = logicNotification.logicVIPAccess.canUseAlerts();
		}

		private function allowAccessToDonations() : Boolean {
			if(!TwitchConnection.isLoggedIn()) return false;
			if(!TwitchConnection.instance.isUserAmemberOfKOTS()) return false;
			return true;
		}

		public function get yourChannelMc() : MovieClip {return visual.getChildByName("yourChannelMc") as MovieClip;}		
		public function get alertMc() : MovieClip { return visual.getChildByName("alertMc") as MovieClip;}
		public function get creditsBtn() : MovieClip {return visual.getChildByName("creditsBtn") as MovieClip;}
		public function get menuSelectMc() : MovieClip { return visual.getChildByName("menuSelectMc") as MovieClip;}
		public function get chatConnectMc() : MovieClip { return visual.getChildByName("chatConnectMc") as MovieClip;}

		public function get oldMenuMc() : MovieClip {return visual.getChildByName("oldMenuMc") as MovieClip;}
		
		
		

		public function show(b: Boolean) : void {
			visual.visible = b;
			if(!b) {
				UI_LachhhToolsAds.hide();
				UI_AnnoyingPopup.hide();
			}
		}

		public function shakeAll() : void {
			EffectShakeUI.addToActor(this, visual, 50, 50);
			EffectShakeUI.addToActor(this, viewMenuUISelect.uiCrnt.visual, 50, 50);
		}
		
		
		private function checkForNewWindow() : void {
			if(windowWidget != null) return;
			windowWidget = new WidgetInWindow();
		}
		
	}
}
