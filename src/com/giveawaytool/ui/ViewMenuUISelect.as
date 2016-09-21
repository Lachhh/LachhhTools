package com.giveawaytool.ui {
	import com.giveawaytool.components.LogicNotifications;
	import com.giveawaytool.effect.EffectKickBackUI;
	import com.giveawaytool.effect.LogicAlphaOnOff;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewMenuUISelect extends ViewBase {
		public var uiCrnt:UIBase;
		public function ViewMenuUISelect(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);

			screen.registerClick(giveawayBtn, onGiveaway);
			screen.registerClick(donationsBtn, onDonations);
			screen.registerClick(followBtn, onFollow);
			screen.registerClick(playMovieBtn, onPlayMovie);
			screen.registerClick(cheersBtn, onCheers);
			screen.registerClick(chestBtn, onChest);

			onGiveaway();
		}

		private function onChest() : void {
			if(uiCrnt as UI_PatreonPromo) return ;
			closeCurrent();
			uiCrnt = new UI_PatreonPromo();
			animUIOpen(chestBtn);
		}

		private function onCheers() : void {
			if(uiCrnt as UI_CheerAlert) return ;
			if(!UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessCheers()) {
				onChest();
				return;
			}
			closeCurrent();
			uiCrnt = new UI_CheerAlert();
			animUIOpen(cheersBtn);
		}

		private function onGiveaway() : void {
			if(uiCrnt as UI_GiveawayMenu) return ;
			closeCurrent();
			uiCrnt = new UI_GiveawayMenu();
			animUIOpen(giveawayBtn);
		}
		
		private function onDonations() : void {
			if(uiCrnt as UI_Donation) return ;
			if(!UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessDonation()) {
				onChest();
				return;
			}
			closeCurrent();
			uiCrnt = new UI_Donation();
			animUIOpen(donationsBtn);
			
		}
		
		private function onFollow() : void {
			if(uiCrnt as UI_FollowSubAlert) return ;
			if(!UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessCheers()) {
				onChest();
				return;
			}
			closeCurrent();
			uiCrnt = new UI_FollowSubAlert();
			animUIOpen(followBtn);
		}
		
		private function onPlayMovie() : void {
			if(uiCrnt as UI_PlayMovies) return ;
			closeCurrent();
			uiCrnt = new UI_PlayMovies();
			animUIOpen(playMovieBtn);
		}
		
		private function animUIOpen(fromBtn:ButtonSelect):void {
			UI_Overlay.show();
			screen.doBtnPressAnim(fromBtn);
			
			var alpha : LogicAlphaOnOff = uiCrnt.addComponent(new LogicAlphaOnOff(uiCrnt.visual)) as LogicAlphaOnOff;
			alpha.callbackOnReach = new Callback(alpha.destroyAndRemoveFromActor, alpha, null);
			uiCrnt.visual.alpha = 0;
			
			EffectKickBackUI.addToActor(uiCrnt, uiCrnt.visual, 20, 0);
			
			screen.refresh();
		}
		
		private function closeCurrent():void {
			if(uiCrnt == null) return ;
			uiCrnt.destroy();
		}
	
		override public function refresh() : void {
			super.refresh();
			giveawayBtn.selectIfBoolean((uiCrnt as UI_GiveawayMenu) != null);
			donationsBtn.selectIfBoolean((uiCrnt as UI_Donation) != null);
			followBtn.selectIfBoolean((uiCrnt as UI_FollowSubAlert) != null);
			playMovieBtn.selectIfBoolean((uiCrnt as UI_PlayMovies) != null);
			playMovieBtn.visible = canPlayMovie();
			
			lockedMcCheers.visible = !UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessCheers();
			lockedMcDonation.visible = !UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessDonation();
			lockedMcFollow.visible = !UI_Menu.instance.logicNotification.logicPatreonAccess.canAccessFollow();
			
		}
		
		
		
		private function canPlayMovie():Boolean {
			if(TwitchConnection.instance == null) return false;
			if(!TwitchConnection.instance.isConnected()) return false;
			if(!TwitchConnection.instance.isUserAmemberOfKOTS()) return false;
			return true;
		}

		public function get giveawayBtn() : ButtonSelect {return visual.getChildByName("giveawayBtn") as ButtonSelect;};
		public function get donationsBtn() : ButtonSelect { return visual.getChildByName("donationsBtn") as ButtonSelect;}
		public function get followBtn() : ButtonSelect {return visual.getChildByName("followBtn") as ButtonSelect;}
		public function get playMovieBtn() : ButtonSelect { return visual.getChildByName("playMovieBtn") as ButtonSelect;}
		public function get cheersBtn() : ButtonSelect { return visual.getChildByName("cheersBtn") as ButtonSelect;}
		public function get chestBtn() : ButtonSelect { return visual.getChildByName("chestBtn") as ButtonSelect;}
		
		public function get lockedMcDonation() : MovieClip { return donationsBtn.getChildByName("lockedMc") as MovieClip;}
		public function get lockedMcFollow() : MovieClip { return followBtn.getChildByName("lockedMc") as MovieClip;}
		public function get lockedMcCheers() : MovieClip { return cheersBtn.getChildByName("lockedMc") as MovieClip;}
		

		public function isUIneedsWidget() : Boolean {
			if((uiCrnt as UI_Donation)) return true;
			if((uiCrnt as UI_FollowSubAlert)) return true;
			return false;
		}
			
	}
}
