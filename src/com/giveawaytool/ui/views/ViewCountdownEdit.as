package com.giveawaytool.ui.views {
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.effect.EffectFlashColorFadeIn;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_CountDown;
	import com.giveawaytool.ui.UI_Overlay;
	import com.giveawaytool.ui.UI_PlayCustomAnimation;
	import com.giveawaytool.ui.UI_SelectAnimation;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCountdownEdit extends ViewBase {
		private var viewCustomBtn : ViewCustomAnimBtn;
		
		
		public function ViewCountdownEdit(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			new ViewNeedToBeOnline(screen, needOnlineMc);
			pScreen.registerClick(playBtn, onPlay);
			targetTxt.addEventListener(FocusEvent.FOCUS_OUT, onEdit);
			text1Txt.addEventListener(FocusEvent.FOCUS_OUT, onEdit);
			countdownTxt.addEventListener(FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerClick(autoClaimBtn, onAutoClaim);

			pScreen.setNameOfDynamicBtn(playBtn, "Start");		
			
			viewCustomBtn = new ViewCustomAnimBtn(pScreen, selectBtn, MetaGameProgress.instance.metaCountdownConfig.metaAnimation);
			
			
			refresh();  
		}

		private function onAutoClaim() : void {
			MetaGameProgress.instance.metaCountdownConfig.autoChatClaim = !MetaGameProgress.instance.metaCountdownConfig.autoChatClaim;
			refresh();
			
		}

		private function onEdit(event : FocusEvent) : void {
			var i:int = FlashUtils.myParseFloat(countdownTxt.text);
			if(!isNaN(i)) {
				MetaGameProgress.instance.metaCountdownConfig.countdown = i;
				MetaGameProgress.instance.saveToLocal();
			}
			MetaGameProgress.instance.metaCountdownConfig.target = targetTxt.text;
			MetaGameProgress.instance.metaCountdownConfig.text1 = text1Txt.text;
			refresh();
		}

		private function onPlay() : void {
			UI_Overlay.hide();
			EffectFlashColorFadeIn.create(0x000000, 15, new Callback(toCountdownUI, this, null));
			screen.enableAllClicks(false);	
		}

		private function toCountdownUI() : void {
			screen.destroy();
			
			if(MetaGameProgress.instance.metaCountdownConfig.metaAnimation.useDefault) {
				new UI_CountDown();
			} else {
				new UI_PlayCustomAnimation(MetaGameProgress.instance.metaCountdownConfig.metaAnimation, MetaGameProgress.instance.metaCountdownConfig.encode());
			}
		}
		
		override public function refresh() : void {
			super.refresh();
			countdownTxt.text = MetaGameProgress.instance.metaCountdownConfig.countdown+"";
			targetTxt.text = MetaGameProgress.instance.metaCountdownConfig.target+"";
			text1Txt.text = MetaGameProgress.instance.metaCountdownConfig.text1+"" ;
			screen.setCheckBox(MetaGameProgress.instance.metaCountdownConfig.autoChatClaim, autoClaimBtn);
		}
		
		public function get targetTxt() : TextField { return visual.getChildByName("targetTxt") as TextField;}
		public function get text1Txt() : TextField { return visual.getChildByName("text1Txt") as TextField;}
		public function get countdownTxt() : TextField { return visual.getChildByName("countdownTxt") as TextField;}
		public function get playBtn() : MovieClip { return visual.getChildByName("playBtn") as MovieClip;}
		public function get selectBtn() : MovieClip { return visual.getChildByName("selectBtn") as MovieClip;}
		public function get autoClaimBtn() : MovieClip { return visual.getChildByName("autoClaimBtn") as MovieClip;}
		
		public function get needOnlineMc() : MovieClip { return visual.getChildByName("needOnlineMc") as MovieClip;}
		
	}
}
