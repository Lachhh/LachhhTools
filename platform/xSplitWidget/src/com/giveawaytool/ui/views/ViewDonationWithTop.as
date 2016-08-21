package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.ModelDonationAwardEnum;
	import com.giveawaytool.meta.MetaNewDonation;
	import com.giveawaytool.meta.ModelDonationAward;
	import com.giveawaytool.components.LogicOnOffNextFrame;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.meta.MetaDonation;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationWithTop extends ViewBase {
		static public var TOP_DAILY:String = "TOP DONATOR\nOF THE DAY";
		static public var TOP_MONTH:String = "[x]'s\nTOP DONATOR";
		static public var TOP_ALL_TIME:String = "TOP DONATOR\nOF ALL TIME";
		static public var FIRST_OF_THE_DAY:String = "FIRST DONATION\nOF THE DAY";
		public var logicOnOff:LogicOnOffNextFrame;
		public var viewDonationNormal:ViewDonation;
		public var viewDonationTop : ViewDonation;
		public var metaDonation : MetaNewDonation;
		public var amount:Number = 0;
		public var viewNewAward:ViewDonationAwardGroup ;
		
		
		public function ViewDonationWithTop(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			logicOnOff = LogicOnOffNextFrame.addToActor(screen, visualMc);
			viewDonationNormal = new ViewDonation(pScreen, normalDonationMc);
			viewDonationTop = new ViewDonation(pScreen, topDonationMc);
			viewNewAward = new ViewDonationAwardGroup(pScreen, newMedalAnimMc);
		}
				
		public function flashAmount():void {
			screen.doBtnPressAnim(viewDonationNormal.amountMc);
			screen.doBtnPressAnim(viewDonationTop.amountMc);
		}
		
		
		override public function refresh() : void {
			super.refresh();
			viewDonationNormal.metaDonation = metaDonation;
			viewDonationTop.metaDonation = metaDonation;
			viewDonationNormal.amount = amount;
			viewDonationTop.amount = amount;
			viewDonationNormal.refresh();
			viewDonationTop.refresh();
			viewNewAward.modelAwards = metaDonation.modelCurrentAwards.slice();
			
			viewNewAward.refresh();
			if(metaDonation.hasCurrentAward()) {
				visualMc.gotoAndStop(visualMc.totalFrames);
				logicOnOff.isOn = true;
			}
		}
		
		public function isOnTopDonationAnim():Boolean {
			return logicOnOff.isOn;
		}
		
		public function playNewAwards(c:Callback):void {
			viewNewAward.playAllAwards(metaDonation.modelNewAwards, c);
			
			if(!metaDonation.hasCurrentAward() && metaDonation.hasNewAward()) {
				logicOnOff.isOn = true;
				CallbackWaitEffect.addWaitCallbackToActor(screen, new Callback(JukeBox.playSound, JukeBox, [SfxFactory.ID_SFX_CROWD]), 20);
			}
		}
		
		
		public function get normalDonationMc() : MovieClip { return visual.getChildByName("normalDonationMc") as MovieClip;}
		public function get topDonationMc() : MovieClip { return visual.getChildByName("topDonationMc") as MovieClip;}
		public function get newMedalAnimMc() : MovieClip { return visual.getChildByName("newMedalAnimMc") as MovieClip;}
	}
}
