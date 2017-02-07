package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaSelectAnimation;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.UI_SelectAnimation;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCustomAnimBtn extends ViewBase {
		public var metaSelectAnimation:MetaSelectAnimation;
		public var viewOptionSlider:ViewOptionSlider;
		public function ViewCustomAnimBtn(pScreen : UIBase, pVisual : DisplayObject, pMetaAnim:MetaSelectAnimation) {
			super(pScreen, pVisual);
			viewOptionSlider = new ViewOptionSlider(pScreen, soundSliderMc);
			
			viewOptionSlider.callbackOnUpdate = new Callback(onUpdateVolume, this, null);
			viewOptionSlider.callbackOnUpdateFinished = new Callback(onUpdateWidgetSound, this, null);
			
			metaSelectAnimation = pMetaAnim;
			screen.setNameOfDynamicBtn(customBtn, "Select\nAnimation");
			screen.registerClick(customBtn, onSelect);
			if(testBtn) {
				screen.setNameOfDynamicBtn(testBtn, "Test");
				screen.registerClick(testBtn, onTest);
			}
			visualMc.gotoAndStop(1);
			refresh();
		}
		
		private function onUpdateWidgetSound() : void {
			UI_Menu.instance.logicNotification.logicSendToWidget.sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
		}

		private function onUpdateVolume() : void {
			metaSelectAnimation.volume = viewOptionSlider.prct;
			refresh();
			
		}

		private function onTest() : void {
			metaSelectAnimation.modelAlertType.testWidget();
		}
		
		private function onSelect() : void {
			new UI_SelectAnimation(metaSelectAnimation);
		}
		
		override public function refresh() : void {
			super.refresh();
			if(metaSelectAnimation == null) return ; 
			animUsedTxt.text = metaSelectAnimation.getShortDesc();
			viewOptionSlider.prct = metaSelectAnimation.volume;
			viewOptionSlider.refresh();
		}
		
		public function get animUsedTxt() : TextField { return visual.getChildByName("animUsedTxt") as TextField;}
		public function get customBtn() : MovieClip { return visual.getChildByName("customBtn") as MovieClip;}
		public function get testBtn() : MovieClip { return visual.getChildByName("testBtn") as MovieClip;}
		public function get soundSliderMc() : MovieClip { return visual.getChildByName("soundSliderMc") as MovieClip;}
		
	}
}
