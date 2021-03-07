package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.giveawaytool.MainGame;
	import com.giveawaytool.constants.GameConstants;
	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.ui.views.ViewXpBar;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_DonationWidget extends UIBase {
		public var viewScrollableTextRecentDonations : ViewScrollText;
		public var viewScrollableTextTopDonators : ViewScrollText;
		public var viewGoal:ViewXpBar;
		public var viewSubProgress:ViewXpBar;
		public function UI_DonationWidget() {
			super(AnimationFactory.ID_UI_DONATIONWIDGET);
			
			viewScrollableTextRecentDonations = new ViewScrollText(this, scrollTxtMc1);
			viewScrollableTextTopDonators = new ViewScrollText(this, scrollTxtMc2);
			viewScrollableTextTopDonators.viewWidth = 220;
			viewGoal = new ViewXpBar(this, progressMc);
			viewSubProgress = new ViewXpBar(this, progressSubMc);
			viewScrollableTextRecentDonations.icons.gotoAndStop(2);
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_BELOW);
			
			refresh();
		}

		public function flashTopDonator():void {
			doBtnPressAnim(viewScrollableTextTopDonators.visualMc);
		}
		
		public function flashFuel():void {
			doBtnPressAnim(viewGoal.visualMc);
		}
		
		public function flashAllForRefresh():void {
			//doBtnPressAnim(viewGoal.visualMc);
			EffectBlinking.addToActor(this, 20, 0xFFFFFF);
		}
		
		override public function refresh() : void {
			super.refresh();
			var metaDonationConfig:MetaDonationsConfig = MainGame.logicListenToMain.metaDonationConfig;
			if(metaDonationConfig == null) {
				Utils.PutBlackAndWhite(visual);
				return ;
			}
			
			Utils.PutBlackAndWhite(visual, false);
			viewGoal.crnt = metaDonationConfig.metaRecurrentGoal.crntAmount;
			viewGoal.target = metaDonationConfig.metaRecurrentGoal.targetAmount;
			viewScrollableTextRecentDonations.msg = metaDonationConfig.lastDonators.getLastDonatorsMsg();
			viewScrollableTextTopDonators.msg = metaDonationConfig.getTopDonatorsMsg();
			viewScrollableTextRecentDonations.refresh();
			viewScrollableTextTopDonators.refresh();
			viewSubProgress.crnt = metaDonationConfig.numSubs;
			viewSubProgress.target = metaDonationConfig.numSubsGoal;
			viewSubProgress.refresh();
			viewGoal.refresh();
			
		}
		
		public function get progressMc() : MovieClip { return visual.getChildByName("progressMc") as MovieClip;}
		public function get progressSubMc() : MovieClip { return visual.getChildByName("progressSubMc") as MovieClip;}
		public function get scrollTxtMc1() : MovieClip { return visual.getChildByName("scrollTxtMc1") as MovieClip;}
		public function get scrollTxtMc2() : MovieClip { return visual.getChildByName("scrollTxtMc2") as MovieClip;}
		
		
		
	}
}
