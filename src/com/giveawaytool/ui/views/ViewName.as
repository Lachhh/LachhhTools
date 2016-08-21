package com.giveawaytool.ui.views {
	import flash.display.DisplayObjectContainer;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import flash.display.BitmapData;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.ui.ViewAvatarLogo;
	import com.animation.exported.BTN_NAME;
	import com.giveawaytool.effect.EffectKickBack;
	import com.giveawaytool.effect.ui.EffectShakeRotateUI;
	import com.giveawaytool.effect.ui.EffectSquashUI;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.AnimationManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewName extends ViewBase {
		public var name : String ;
		private var viewSubBadge : ViewAvatarLogo;
		private var flashAnim : FlashAnimationView;
		private var rotateEffect : EffectShakeRotateUI;

		public function ViewName(pScreen : UIBase, pVisual : DisplayObjectContainer) {
			flashAnim = new FlashAnimationView(pVisual);
			flashAnim.setAnim(AnimationFactory.ID_FX_NAME_BTN);
			
			super(pScreen, flashAnim.anim);
			
			nameTxt.text = "Super Long Name";
			viewSubBadge = new ViewAvatarLogo(pScreen, avatarMc);
			viewSubBadge.rect.x = 2;
			viewSubBadge.rect.y = 2;
			viewSubBadge.rect.width = 14;
			viewSubBadge.rect.height = 14;
			nameMc.gotoAndStop(1);
			visual.rotation = 0;
		}
		
		override public function destroy() : void {
			super.destroy();
			screen.removeClickFromVisual(visual);
			flashAnim.destroy();
			if(rotateEffect && !rotateEffect.destroyed) {
				rotateEffect.destroyAndRemoveFromActor();
			}
		}

		override public function refresh() : void {
			super.refresh();
			if(visual == null) return ;
			
			var frame:int = (isModerator ? 2 : 1);
			
			viewSubBadge.bmpData = getSubBadgeBmpData();
			viewSubBadge.refresh();
			avatarMc.visible = false;
			
			if(TwitchConnection.isLoggedIn()){
				if(TwitchConnection.instance.isSubscriber(name)) {
					frame += 2;
					avatarMc.visible = true;
				}
			}
			
			nameMc.gotoAndStop(frame);
			nameTxt.text = name;
		}
		
		public function getSubBadgeBmpData():BitmapData {
			if(!TwitchConnection.isLoggedIn()) return null;
			return TwitchConnection.instance.channelData.logoSubBadge;
		}
		
		public function flash():void {
			if(destroyed) return ;
			//EffectFadeOut.addToActorWithSpecificMc(screen, visual, 5, 0x000000);
			rotateEffect = EffectShakeRotateUI.addToActor(actor, visual, 30);
			//EffectSquashUI.addToActorWithSpecificDisplayObjAndRevolution(actor, visual, 1);
		}
		
		public function get isModerator():Boolean {
			return (MetaGameProgress.instance.metaGiveawayConfig.isModerator(name));
		}
		
		public function get nameBtn() : MovieClip { return visual.getChildByName("nameBtn") as MovieClip;}
		public function get nameMc() : MovieClip { return nameBtn.getChildByName("nameMc") as MovieClip;}
		public function get nameTxtMc() : MovieClip { return nameMc.getChildByName("nameTxtMc") as MovieClip;}
		public function get nameTxt() : TextField { return nameTxtMc.getChildByName("nameTxt") as TextField;}
		public function get avatarMc() : MovieClip { return nameMc.getChildByName("avatarMc") as MovieClip;}
		
		
		
	}
}
