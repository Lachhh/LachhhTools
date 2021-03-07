package com.giveawaytool.ui.views {
	import com.giveawaytool.components.LogicOnOffNextFrame;
	import com.giveawaytool.meta.ModelDonationAward;
	import com.giveawaytool.meta.ModelDonationAwardEnum;
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
	public class ViewDonationAwardGroup extends ViewBase {
		private var months:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		
		public var modelAwards : Array = new Array();
		private var modelNewAwards : Array = new Array();
		public var newMedalView : ViewDonationAward;
		public var medal0View : ViewDonationAward;
		public var medal1View : ViewDonationAward;
		public var medal2View : ViewDonationAward;
		public var medal3View : ViewDonationAward;
		public var logicOnOff:LogicOnOffNextFrame;
		public var modelNewMedal:ModelDonationAward = ModelDonationAwardEnum.NULL;
		
		public function ViewDonationAwardGroup(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			newMedalView = new ViewDonationAward(pScreen, newMedal);
			medal0View = new ViewDonationAward(pScreen, medal0);
			medal1View = new ViewDonationAward(pScreen, medal1);
			medal2View = new ViewDonationAward(pScreen, medal2);
			medal3View = new ViewDonationAward(pScreen, medal3);
			logicOnOff = pScreen.addComponent(new LogicOnOffNextFrame()) as LogicOnOffNextFrame;
			logicOnOff.isOn = false;
			logicOnOff.visualToToggle = visualMc;
			visualMc.gotoAndStop(1);
		}

		public function playAllAwards(m : Array, c:Callback) : void {
			modelNewAwards = m.slice();
			if(modelNewAwards.length <= 0) {
				c.call();
			} else {
				var newAwards:ModelDonationAward = modelNewAwards.shift();
				playAnimForNewMedal(newAwards, new Callback(playAllAwards, this, [modelNewAwards, c]));
				JukeBox.playSound(SfxFactory.ID_SFX_UI_MEDAL_MINIGAME);
			}
		}
		
		
		public function playAnimForNewMedal(m : ModelDonationAward, c:Callback) : void {
			visualMc.gotoAndStop(1);
			logicOnOff.isOn = true;
			logicOnOff.callbackOnEnd = c;
			if(!modelNewMedal.isNull) {
				modelAwards.unshift(modelNewMedal);
			}
			modelNewMedal = m;
			
			refresh();
		}
		
		public function getAwardOfMedal(i:int):ModelDonationAward {
			if(i < 0) return ModelDonationAwardEnum.NULL;
			if(i >= modelAwards.length) return ModelDonationAwardEnum.NULL;
			return modelAwards[i];
		}
		
		
		override public function update() : void {
			super.update();
			if(visualMc.currentFrame == 175) JukeBox.playSound(SfxFactory.ID_SFX_TRANSITION_WOOSH_04);
			if(visualMc.currentFrame == 200) JukeBox.playSound(SfxFactory.ID_SFX_UI_REWARD_SMALL);
			
		}
		
		override public function refresh() : void {
			super.refresh();
			
			newMedalView.modelDonation = modelNewMedal;
			medal0View.modelDonation = getAwardOfMedal(0);
			medal1View.modelDonation = getAwardOfMedal(1);
			medal2View.modelDonation = getAwardOfMedal(2);
			medal3View.modelDonation = getAwardOfMedal(3);
			newMedalView.refresh();
			medal0View.refresh();
			medal1View.refresh();
			medal2View.refresh();
			medal3View.refresh();
			txt.text = newMedalView.modelDonation.title.toUpperCase();
		}
		
		public function get newMedal() : MovieClip { return visual.getChildByName("newMedal") as MovieClip;}
		public function get medal0() : MovieClip { return visual.getChildByName("medal0") as MovieClip;}
		public function get medal1() : MovieClip { return visual.getChildByName("medal1") as MovieClip;}
		public function get medal2() : MovieClip { return visual.getChildByName("medal2") as MovieClip;}
		public function get medal3() : MovieClip { return visual.getChildByName("medal3") as MovieClip;}
		public function get donationAwardMc() : MovieClip { return visual.getChildByName("donationAwardMc") as MovieClip;}
		public function get txt() : TextField { return donationAwardMc.getChildByName("txt") as TextField;}
	}
}
