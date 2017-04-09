package com.giveawaytool.ui {
	import com.TwitchLachhhIsLiveSimpleCheckUp;
	import air.update.utils.VersionUtils;

	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCredits extends ViewBase {
		public var logicOnOff:LogicOnOffNextFrame;
		public function ViewCredits(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			screen.registerClick(visual, onClick);
			screen.registerEvent(visual, MouseEvent.ROLL_OVER, onOver);
			screen.registerEvent(visual, MouseEvent.ROLL_OUT, onOut);
			visualMc.buttonMode = true;
			logicOnOff = LogicOnOffNextFrame.addToActor(actor, visualMc);
			logicOnOff.isOn = false;
			logicOnOff.invisibleOnFirstFrame = false;
		}

		private function onOut() : void {
			logicOnOff.isOn = false;
		}

		private function onOver() : void {
			logicOnOff.isOn = true;
		}

		private function onClick() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);
		}

		override public function refresh() : void {
			super.refresh();
			versionTxt.text = "v" + VersionUtils.getApplicationVersion();
			liveMc.visible = TwitchLachhhIsLiveSimpleCheckUp.isLachhLive;
		}

		public function get versionTxt() : TextField {return visual.getChildByName("versionTxt") as TextField;}
		public function get liveMc() : MovieClip { return visual.getChildByName("liveMc") as MovieClip;}
	}
}
