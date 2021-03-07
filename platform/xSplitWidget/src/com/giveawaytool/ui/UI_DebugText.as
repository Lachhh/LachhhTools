package com.giveawaytool.ui {
	import com.lachhh.io.SimpleSocket;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_DebugText extends UIBase {
		private var socket : SimpleSocket;
		public var msg:String = "";
		public function UI_DebugText() {
			super(AnimationFactory.ID_UI_DEBUGTEXT);
			//socket = SimpleSocket.getInstance(); 
			//socket.onNewData.addCallback(new Callback(onNewData, this, null));
		}

		private function onNewData() : void {
			/*var d:Dictionary = DataManager.objToDictionary(SimpleSocket.getInstance().data);
			var newCmd:MetaCmd;
			msg += d.type + "\n"; 
			refresh();*/
		}
		
		
		override public function refresh() : void {
			super.refresh();
			msgTxt.text = msg;
			msgTxt.scrollV = 999999;
		}
		
		public function get msgTxt() : TextField { return visual.getChildByName("msgTxt") as TextField;}
	}
}
