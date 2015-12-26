package com.giveawaytool.ui.views {
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
		public var name:String ;
		
		
		public function ViewName(pScreen : UIBase) {
			var anim:MovieClip = AnimationManager.createAnimation(AnimationFactory.ID_FX_NAME_BTN);
			super(pScreen, anim);
			nameTxt.text = "Super Long Name";
		}
		
		override public function destroy() : void {
			super.destroy();
			if(visual) {
				screen.removeClickFromVisual(visual);
				Utils.LazyRemoveFromParent(visual);
				AnimationManager.destroy(visual as FlashAnimation);
				visual = null;
			}
		}

		override public function refresh() : void {
			super.refresh();
			if(visual == null) return ;
			var frame:int = (isModerator ? 2 : 1);
			nameMc.gotoAndStop(frame);
			nameTxt.text = name;
		}
		
		public function flash():void {
			if(destroyed) return ;
			//EffectFadeOut.addToActorWithSpecificMc(screen, visual, 5, 0x000000);
			EffectShakeRotateUI.addToActor(actor, visual, 30);
			//EffectSquashUI.addToActorWithSpecificDisplayObjAndRevolution(actor, visual, 1);
		}
		
		public function get isModerator():Boolean {
			return (MetaGameProgress.instance.isModerator(name));
		}
		
		public function get nameBtn() : MovieClip { return visual.getChildByName("nameBtn") as MovieClip;}
		public function get nameMc() : MovieClip { return nameBtn.getChildByName("nameMc") as MovieClip;}
		public function get nameTxt() : TextField { return nameMc.getChildByName("nameTxt") as TextField;}
	}
}
