package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Overlay extends UIBase {
		private static var instance : UI_Overlay;
		public function UI_Overlay() {
			super(AnimationFactory.ID_UI_OVERLAY);
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE_NO_CLICK);
			
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			 
		}


		static public function show():void {
			if(instance == null) {
				instance = new UI_Overlay();
			}
		}
		
		static public function hide():void {
			if(instance != null) {
				instance.destroy();
				instance = null;
			}
		}
	}
}
