package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_NewFollowerAnim extends UIBase {
		private var metaNewFollowAlert : MetaNewFollowerAlert;
		public var callbackOnDestroy:Callback;

		public function UI_NewFollowerAnim(m : MetaNewFollowerAlert) {
			super(AnimationFactory.ID_UI_NEWFOLLOWER);
			renderComponent.animView.stop();
			renderComponent.animView.anim.play();
			metaNewFollowAlert = m;
			px = 640;
			py = 360;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE_NO_CLICK);
			refresh();	
		}
		
		
		override public function destroy() : void {
			super.destroy();
			if(callbackOnDestroy) callbackOnDestroy.call();
			
		}
		
		override public function refresh() : void {
			super.refresh();
			nameTxt.text = metaNewFollowAlert.name;
		}
		
		override public function update() : void {
			super.update();
			if(visual.currentFrame >= visual.totalFrames-2) {
				destroy();
			}
		}
		
		public function get nameMc() : MovieClip {return visual.getChildByName("nameMc") as MovieClip;}
		public function get nameTxt() : TextField { return nameMc.getChildByName("nameTxt") as TextField;}
	}
}
