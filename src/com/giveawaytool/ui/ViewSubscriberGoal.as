package com.giveawaytool.ui {
	import com.giveawaytool.effect.EffectKickBackUI;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaSubsConfig;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubscriberGoal extends ViewBase {
		public function ViewSubscriberGoal(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			screen.setNameOfDynamicBtn(autoSetNextGoalBtn, "Auto Set\nto Next");
			screen.registerClick(autoSetNextGoalBtn, onClickAuto);
			pScreen.registerEvent(totalTxt, FocusEvent.FOCUS_OUT, onEdit);			
		}

		private function onEdit() : void {
			var crntAmount:int = FlashUtils.myParseFloat(totalTxt.text);
			var m:MetaSubsConfig = MetaGameProgress.instance.metaSubsConfig;
			if(!isNaN(crntAmount)) m.goalSub = crntAmount;
			
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refresh(); 
		}

		private function onClickAuto() : void {
			if(TwitchConnection.instance == null) return;
			MetaGameProgress.instance.metaSubsConfig.setAutoNext(TwitchConnection.instance.listOfSubs.subscribers.length);
			EffectKickBackUI.addToActor(actor, totalTxt, 0, -5);
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			if(TwitchConnection.instance == null) return;
			var crnt:int = TwitchConnection.instance.listOfSubs.subscribers.length;
			var total:int = MetaGameProgress.instance.metaSubsConfig.goalSub;
			if(total == 0) {
				MetaGameProgress.instance.metaSubsConfig.setAutoNext(crnt);
			}
			crntTxt.text = crnt +" / ";
			totalTxt.text = MetaGameProgress.instance.metaSubsConfig.goalSub+"";
			
			
		}

		public function get crntTxt() : TextField {return visual.getChildByName("crntTxt") as TextField;}
		public function get totalTxt() : TextField { return visual.getChildByName("totalTxt") as TextField;};
		public function get autoSetNextGoalBtn() : MovieClip { return visual.getChildByName("autoSetNextGoalBtn") as MovieClip;}
	}
}
