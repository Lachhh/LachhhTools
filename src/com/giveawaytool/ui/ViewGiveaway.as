package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewGiveawayAddParticipants;
	import com.giveawaytool.ui.views.ViewGiveawaySettings;
	import com.giveawaytool.ui.views.ViewNameListWithPages;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewGiveaway extends ViewBase {
		public var viewGiveawayConfig : ViewGiveawaySettings;
		public var viewNameList : ViewNameListWithPages;
		public var viewGiveawayAddParticipants : ViewGiveawayAddParticipants;
		
		public function ViewGiveaway(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewGiveawayConfig = new ViewGiveawaySettings(pScreen, settingMc);
			viewNameList = new ViewNameListWithPages(pScreen, listOfNameMc);
			viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			viewGiveawayAddParticipants = new ViewGiveawayAddParticipants(screen, participantsMc);
			
			pScreen.registerClick(viewNameList.cancelBtn, onCancel);
		}
		
		private function onCancel() : void {
			viewGiveawayAddParticipants.cancelLoading();
		}
		
		public function get settingMc() : MovieClip { return visual.getChildByName("settingMc") as MovieClip;}
		public function get participantsMc() : MovieClip { return visual.getChildByName("participantsMc") as MovieClip;}
		public function get listOfNameMc() : MovieClip { return visual.getChildByName("listOfNameMc") as MovieClip;}
		public function get startAnimBtn() : MovieClip { return visual.getChildByName("startAnimBtn") as MovieClip;}
		public function get listenToChatBtn() : MovieClip { return visual.getChildByName("listenToChatBtn") as MovieClip;}
	}
}
