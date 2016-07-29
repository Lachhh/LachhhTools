package com.giveawaytool.ui {
	import flash.events.MouseEvent;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;

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
	}
}
