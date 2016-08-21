package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.giveawaytool.meta.MetaHostAlert;
	import com.giveawaytool.DefaultMainGame;
	import com.giveawaytool.meta.MetaSubcriberAlert;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.AnimationManager;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_NewHostAnim extends UIBase {
		private var metaHostAlert : MetaHostAlert;
		public var callbackOnDestroy:Callback;
		public var anim : MovieClip;

		public function UI_NewHostAnim(m : MetaHostAlert) {
			super(0);
			var animId:int = (m.hasEnoughForRainbow() ? AnimationFactory.ID_UI_NEWHOSTBIG : AnimationFactory.ID_UI_NEWHOSTSMALL);
			anim = AnimationManager.createAnimation(animId);
			
			visual.addChild(anim);
			metaHostAlert = m;
			px = 640;
			py = 360;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE_NO_CLICK);
			CallbackWaitEffect.addWaitCallFctToActor(this, playSounds1, 5);
			CallbackWaitEffect.addWaitCallFctToActor(this, playSounds2, 23);
			JukeBox.playSound(SfxFactory.ID_SFX_NEW_HOST);
			refresh();
		}

		private function playSounds1() : void {
			JukeBox.playSound(SfxFactory.ID_SFX_CHILD_YAY);
			if(metaHostAlert.hasEnoughForRainbow()) {
				JukeBox.playSound(SfxFactory.ID_SFX_SPARKLES);
			}
		}
		
		private function playSounds2() : void {
			JukeBox.playSound(SfxFactory.ID_SFX_CROWD);
		}
		
		override public function destroy() : void {
			super.destroy();
			if(callbackOnDestroy) callbackOnDestroy.call();
			Utils.LazyRemoveFromParent(anim);
			FlashAnimationView.recurStop(anim);
		}
		
		override public function refresh() : void {
			super.refresh();
			
			hostNameTxt.text = metaHostAlert.name;
			isHostingUsTxt.text = metaHostAlert.getIsHostingUsMsg();
			numViewerstxt.text = metaHostAlert.numViewers + " viewers!";
			//rainbowMc.visible = metaHostAlert.hasEnoughForRainbow();
			numViewerstxt.visible = metaHostAlert.hasEnoughForRainbow();
			
		}
		
		override public function update() : void {
			super.update();
			if(anim.currentFrame >= anim.totalFrames-2) {
				destroy();
			}
		}
		
		//public function get rainbowMc() : MovieClip { return anim.getChildByName("rainbowMc") as MovieClip;}
		public function get nameAnimMc() : MovieClip { return anim.getChildByName("nameAnimMc") as MovieClip;}
		public function get nameOfHostMc() : MovieClip { return nameAnimMc.getChildByName("nameOfHostMc") as MovieClip;}
		public function get isHostingUsMc() : MovieClip { return nameAnimMc.getChildByName("isHostingUsMc") as MovieClip;}
		public function get numViewersMc() : MovieClip { return nameAnimMc.getChildByName("numViewersMc") as MovieClip;}
		
		public function get nameOfHost2Mc() : MovieClip { return nameOfHostMc.getChildByName("nameMc") as MovieClip;}
		public function get nameOfHost3Mc() : MovieClip { return nameOfHost2Mc.getChildByName("nameMc") as MovieClip;}
		
		public function get hostNameTxt() : TextField { return nameOfHost3Mc.getChildByName("nameTxt") as TextField;}
		public function get isHostingUsTxt() : TextField { return isHostingUsMc.getChildByName("txt") as TextField;}
		public function get numViewerstxt() : TextField { return numViewersMc.getChildByName("txt") as TextField;}
	}
}
