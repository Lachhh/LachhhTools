package com.giveawaytool.ui {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaFollowConfig;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewFollowersGoal extends ViewBase {
		public function ViewFollowersGoal(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			pScreen.registerEvent(totalTxt, FocusEvent.FOCUS_OUT, onEdit);			
		}

		private function onEdit() : void {
			var crntAmount:int = FlashUtils.myParseFloat(totalTxt.text);
			var m:MetaFollowConfig= MetaGameProgress.instance.metaFollowConfig;
			if(!isNaN(crntAmount)) m.goalFollowers = crntAmount;
			
			MetaGameProgress.instance.saveToLocal();
			MetaGameProgress.instance.metaDonationsConfig.isDirty = true;
			UIBase.manager.refresh(); 
		}
		

		override public function refresh() : void {
			super.refresh();
			if(TwitchConnection.instance == null) return ;
			crntTxt.text = TwitchConnection.instance.channelData.numFollowers +"";
			totalTxt.text = MetaGameProgress.instance.metaFollowConfig.goalFollowers+"";
		}

		public function get crntTxt() : TextField {return visual.getChildByName("crntTxt") as TextField;}
		public function get totalTxt() : TextField { return visual.getChildByName("totalTxt") as TextField;}
	}
}
