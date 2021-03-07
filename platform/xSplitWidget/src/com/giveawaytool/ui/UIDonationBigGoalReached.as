package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UIDonationBigGoalReached extends UIBase {
		private var amount : Number;
		public var callbackOnClose:Callback;
		public function UIDonationBigGoalReached(pAmount:Number) {
			super(AnimationFactory.ID_UI_GOALREACHED);
			amount = pAmount;
			renderComponent.animView.addEndCallback(new Callback(destroy, this, null));
			refresh();
		}

		override public function destroy() : void {
			super.destroy();
			if(callbackOnClose) callbackOnClose.call();
		}
		
		override public function refresh() : void {
			super.refresh();
			txt1.text = "$" + Utils.PutVirgules(amount);
			txt2.text = "$" + Utils.PutVirgules(amount);
		}

		public function get amountMc() : MovieClip { return visual.getChildByName("amountMc") as MovieClip;}
		public function get txt1() : TextField { return amountMc.getChildByName("txt1") as TextField;}
		public function get txt2() : TextField { return amountMc.getChildByName("txt2") as TextField;}

	}
}
