package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Loading extends UIBase {
		public var msg:String;
		public function UI_Loading(pMsg:String) {
			super(AnimationFactory.ID_UI_LOADING);
			msg = pMsg;
		}

		override public function refresh() : void {
			super.refresh();
			msgTxt.text = msg;
		}

		static public function show(msg : String) : UI_Loading {
			var result:UI_Loading = UIBase.manager.getFirst(UI_Loading) as UI_Loading;
			if(result == null)  {
				result = new UI_Loading(msg);
			}
			result.msg = msg;
			result.refresh();
			return result;
		}
		
		static public function hide():void {
			var result:UI_Loading = UIBase.manager.getFirst(UI_Loading) as UI_Loading;
			if(result == null) return ;
			result.destroy();
		}

		public function get msgTxt() : TextField { return visual.getChildByName("msgTxt") as TextField;}
	}
}
