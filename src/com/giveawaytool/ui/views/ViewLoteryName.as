package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.CallbackWaitEffect;
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
	public class ViewLoteryName extends ViewBase {
		public var name:String ;
		
		private var phase2Fade:Boolean = false;
		private var fadingOut:Boolean = false;
		private var speedX:Number = 0;
		private var winAnim:Boolean = false;
		

			
		public function ViewLoteryName(pScreen : UIBase) {
			var anim:MovieClip = AnimationManager.createAnimation(AnimationFactory.ID_FX_LOTERYNAME);
			super(pScreen, anim);
			nameTxt.text = "Super Long Name";
			fadingOut = false;
			visualMc.gotoAndStop(1);
			visual.visible = true;
		}
		
		override public function destroy() : void {
			super.destroy();
			if(visual) {
				visualMc.gotoAndStop(1);
				Utils.LazyRemoveFromParent(visual);
				AnimationManager.destroy(visual as FlashAnimation);
				visual = null;
			}
		}
		
		public function startWinAnim():void {
			winAnim = true;
		}
		
		public function fadeOut():void {
			fadingOut = true;
			CallbackWaitEffect.addWaitCallFctToActor(screen, startPhase2Fade, 10);
		}

		private function startPhase2Fade():void {
			phase2Fade = true; 	 
		}
		
		override public function update() : void {
			super.update();
			if(fadingOut) {
				if(phase2Fade) {
					if(visual.visible) {
						visual.x += speedX;
						speedX += 4;
						visual.visible = (visual.x < 2000);
					}
				} else {
					visual.x += (600-visual.x)*0.2;
				}
			}
			
			if(winAnim) {
				if(visualMc.currentFrame >= visualMc.totalFrames) {
					visualMc.gotoAndPlay(18);
				} else {
					visualMc.nextFrame();
				}
			}
		}
		
		override public function refresh() : void {
			super.refresh();
			if(visual == null) return ;
			nameTxt.text = name;
		}
		
		
		public function get nameMc() : MovieClip { return visual.getChildByName("nameMc") as MovieClip;}
		public function get nameTxt() : TextField { return nameMc.getChildByName("nameTxt") as TextField;}
	}
}
