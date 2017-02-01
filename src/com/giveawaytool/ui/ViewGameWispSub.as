package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import flash.display.DisplayObjectContainer;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import com.giveawaytool.io.playerio.MetaGameWispSub;
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.AnimationManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author Jack
	 */
	public class ViewGameWispSub extends ViewBase 
	{
		public var metaGamewispSub : MetaGameWispSub;
		private var flashFx:FlashAnimationView;
		
		public function ViewGameWispSub(pScreen : UIBase, pParent:DisplayObjectContainer){
			flashFx = new FlashAnimationView(pParent);
			flashFx.setAnim(AnimationFactory.ID_FX_HALLOFFAME_BTN);
			super(pScreen, flashFx.anim);
			iconMc.gotoAndStop(1);
			screen.registerClick(visual, onClick);
		}

		private function onClick() : void {
			if(metaGamewispSub == null) return ;
			UI_PopUp.createYesNo(metaGamewispSub.getTwitchURLQuestion(), new Callback(onYes, this, null), null);
		}

		private function onYes() : void {
			Utils.navigateToURLAndRecord(metaGamewispSub.getTwitchURL());
		}
		
		override public function destroy() : void {
			super.destroy();
			screen.removeClickFromVisual(visual);
			flashFx.destroy();
		}
		
		override public function refresh() : void{
			super.refresh();
			if(theBtn == null) return ;
			if(metaGamewispSub == null) {
				visual.visible = false;
				return;
			}
			if(visual == null)
				return;
			
			visual.visible = true;
			
			nameTxt.text = metaGamewispSub.name ;
			iconMc.gotoAndStop(getIconFrame());
		}
		
		private function getIconFrame():int {
			if(metaGamewispSub.hasPledgeGold()) return 3;
			if(metaGamewispSub.hasPledgeSilver()) return 2;
			return 1;
		}
		
		public function get theBtn() : MovieClip { 
			if(!flashFx.hasAnim()) return null ; 
			return flashFx.anim.getChildByName("patreonBtn") as MovieClip;
		}
	
		
		public function get hallOfFameMc() : MovieClip { return theBtn.getChildByName("hallOfFameMc") as MovieClip;}
		public function get iconMc() : MovieClip { return hallOfFameMc.getChildByName("iconMc") as MovieClip;} 
		public function get nameMc() : MovieClip { return hallOfFameMc.getChildByName("nameMc") as MovieClip;}
		public function get backMc() : MovieClip { return hallOfFameMc.getChildByName("backMc") as MovieClip;}
		
		public function get nameTxt() : TextField { return nameMc.getChildByName("nameTxt") as TextField;}	
	}
}