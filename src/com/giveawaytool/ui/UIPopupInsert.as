package com.giveawaytool.ui {
	import flash.display.MovieClip;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;

	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UIPopupInsert extends UI_PopUp {
		
		public function UIPopupInsert(pMsg : String) {
			super(pMsg);
		}
		
		
		override public function refresh() : void {
			super.refresh();
		}
		
		public function get inputTxt() : TextField { return panel.getChildByName("inputTxt") as TextField;}
		
		static public function createInsertReplaceAppendCancel(msg:String, replace:Callback, append:Callback, cancel:Callback):UIPopupInsert {
			var result:UIPopupInsert = new UIPopupInsert(msg);
			result.setAnim(AnimationFactory.ID_UI_POPUPINSERTBIG);
			result.inputTxt.text = "";
			result.btn1Callback = replace;
			result.btn2Callback = append;
			result.btn3Callback = cancel;
			result.setNameOfBtnByIndex(1, "Replace");
			result.setNameOfBtnByIndex(2, "Append");
			result.setNameOfBtnByIndex(3, "Cancel");
			result.btnOnEnter = result.btn1;
			return result;
		}
		
		
		static public function createInsertOne(msg:String, onBtn1:Callback, onBtn3:Callback):UIPopupInsert {
			var result:UIPopupInsert = new UIPopupInsert(msg);
			result.setAnim(AnimationFactory.ID_UI_POPUPINSERTONE);
			result.btn2.visible = false;
			result.btn1Callback = onBtn1;
			result.btn3Callback = onBtn3;
			result.btnOnEnter = result.btn1;
			result.setNameOfBtnByIndex(1, "Load");
			result.setNameOfBtnByIndex(2, "");
			result.setNameOfBtnByIndex(3, "Cancel");
			return result;
		}
		
		
		static public function createInsertBig(msg:String, onBtn1:Callback, onBtn3:Callback):UIPopupInsert {
			var result:UIPopupInsert = new UIPopupInsert(msg);
			result.setAnim(AnimationFactory.ID_UI_POPUPINSERTBIG);
			result.btn2.visible = false;
			result.btn1Callback = onBtn1;
			result.btn3Callback = onBtn3;
			
			return result;
		}
		
		public function setNameOfBtnByIndex(i:int, name:String):void {
			switch(i) {
				case 1 : setNameOfDynamicBtn(btn1, name); break;
				case 2 : setNameOfDynamicBtn(btn2, name); break;
				case 3 : setNameOfDynamicBtn(btn3, name); break; 
			}
		}
	}
}
