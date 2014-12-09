package com.giveawaytool.ui {
	import com.giveawaytool.ui.views.ViewLoteryWinner;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_LoteryWinner extends UIBase {
		public var vioewLoteryWinner:ViewLoteryWinner;
		public var callbackEnd:Callback;
		public function UI_LoteryWinner(winnersName:String) {
			super(AnimationFactory.ID_UI_TODAYWINNER);
			vioewLoteryWinner = new ViewLoteryWinner(this, visual);
			vioewLoteryWinner.name = winnersName;
			renderComponent.animView.addEndCallback(new Callback(destroy, this, null));
			JukeBox.playSound(SfxFactory.ID_SFX_CROWD);
			JukeBox.playSound(SfxFactory.ID_SFX_UI_MEDAL_MINIGAME);
			refresh();
		}
		
		
		override public function destroy() : void {
			super.destroy();
			if(callbackEnd) callbackEnd.call();
		}
		


		override public function update() : void {
			super.update();
			
		}
		

	}
}
