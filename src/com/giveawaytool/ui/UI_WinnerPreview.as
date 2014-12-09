package com.giveawaytool.ui {
	import com.giveawaytool.ui.views.ViewWinnerPng;
	import com.lachhh.ResolutionManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_WinnerPreview extends UIBase {
		public var viewPng : ViewWinnerPng;

		public function UI_WinnerPreview() {
			super(AnimationFactory.ID_UI_PNGTHUMBNAIL);
			
			viewPng = new ViewWinnerPng(this, contentMc);
			renderComponent.xVisualOffset = ResolutionManager.getGameWidth()*0.5;
			renderComponent.yVisualOffset = ResolutionManager.getGameHeight()*0.5;
			
			UI_Overlay.hide();
			registerClick(visual, destroy);
			refresh();
		}	
		
		override public function destroy() : void {
			super.destroy();
			UI_Overlay.show();
		}
		
		override public function refresh() : void {
			super.refresh();
		}
		
		public function get contentMc() : MovieClip { return visual.getChildByName("contentMc") as MovieClip;}
	}
}
