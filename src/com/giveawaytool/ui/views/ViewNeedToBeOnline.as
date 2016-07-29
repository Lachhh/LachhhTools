package com.giveawaytool.ui.views {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.lachhh.io.Callback;
	import flash.events.MouseEvent;
	import com.giveawaytool.ui.LogicOnOffNextFrame;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class ViewNeedToBeOnline extends ViewBase {
		public var logicOnOff:LogicOnOffNextFrame;
		public function ViewNeedToBeOnline(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			logicOnOff = screen.addComponent(new LogicOnOffNextFrame(visualMc)) as LogicOnOffNextFrame;
			logicOnOff.invisibleOnFirstFrame = false;
			screen.registerEventWithCallback(visual, MouseEvent.ROLL_OVER, new Callback(onOver, this, null));
			screen.registerEventWithCallback(visual, MouseEvent.ROLL_OUT, new Callback(onOut, this, null));
			
		}

		override public function refresh() : void {
			super.refresh();
			visual.visible = !TwitchConnection.isLoggedIn();
		}

		private function onOut() : void {logicOnOff.isOn = false;}
		private function onOver() : void {logicOnOff.isOn = true;}
	}
}
