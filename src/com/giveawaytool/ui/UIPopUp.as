package com.giveawaytool.ui {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.DefaultMainGame;
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.ui.EffectShakeRotateUI;
	import com.giveawaytool.effect.ui.EffectSquashUI;
	import com.lachhh.ResolutionManager;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIOpenClose;

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.ui.Keyboard;

 
/**
 * @author Lachhh
 */
	public class UIPopUp extends UIOpenClose {
		public var btn1Callback:Callback;
		public var btn2Callback:Callback;
		public var btn3Callback:Callback;

		public var msg:String;
		public var btnOnEnter:MovieClip;

		public function UIPopUp(pMsg : String) {
			super(AnimationFactory.ID_UI_POPUP, 20, 35);
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			registerClicks();
			btn1.visible = true;
			btn2.visible = true;
			btn3.visible = true;
			msg = pMsg;
			px = ResolutionManager.getGameWidth()*0.5;
			py = ResolutionManager.getGameHeight()*0.5;
			btnOnEnter = null;
			refresh();
		}
		
		protected function registerClicks():void  {
			registerClick(btn1, onBtn1);
			registerClick(btn2, onBtn2);
			registerClick(btn3, onBtn3);
		}
		
		protected function setAnim(animId:int):void {
			renderComponent.setAnim(animId);
			visual = renderComponent.animView.anim;
			addOpenCloseCallbacks();
			registerClicks();
		}
		
		private function onBtn1() : void {
			closeWithCallbackOnEnd(btn1Callback);
			SfxFactory.onClickSound();
			doBtnPressAnim(btn1);
		}

		private function onBtn2() : void {
			closeWithCallbackOnEnd(btn2Callback);
			SfxFactory.onClickSound();
			doBtnPressAnim(btn2);
		}

		private function onBtn3() : void {
			closeWithCallbackOnEnd(btn3Callback);
			SfxFactory.onClickSound();
			doBtnPressAnim(btn3);
		}

		override public function refresh() : void {
			super.refresh();
			descTxt.text = msg;
			Utils.SetMaxSizeOfTxtField(descTxt, 24);
		}
		
		
		override public function update() : void {
			super.update();
			if(KeyManager.IsKeyPressed(Keyboard.ENTER)) {
				switch(btnOnEnter) {
					case btn1 : onBtn1(); break;
					case btn2 : onBtn2(); break;
					case btn3 : onBtn3(); break;
				}
			}
		}
		
		public function get btn1():MovieClip { return (panel.getChildByName("btn1")) as MovieClip;}
		public function get btn2():MovieClip { return (panel.getChildByName("btn2")) as MovieClip;}
		public function get btn3():MovieClip { return (panel.getChildByName("btn3")) as MovieClip;}
		public function get panel():MovieClip { return (visual.getChildByName("panel")) as MovieClip;}
		
		public function get descTxt() : TextField { return panel.getChildByName("descTxt") as TextField;}
		
		static public function createOkOnlySimple(msg:String):UIPopUp {
			return createOkOnly(msg, null);
		}
		
		static public function createOkOnly(msg:String, callback:Callback):UIPopUp {
			var result:UIPopUp = new UIPopUp(msg);
			result.btn3.visible = false;
			result.btn1.visible = false;
			result.btn2Callback = callback;
			result.btnOnEnter = result.btn2;
			result.setNameOfDynamicBtn(result.btn1, "Yes");
			result.setNameOfDynamicBtn(result.btn2, "Ok");
			result.setNameOfDynamicBtn(result.btn3, "No");
			return result; 
		}
		
		static public function createYesNo(msg:String, yes:Callback, no:Callback):UIPopUp {
			var result:UIPopUp = new UIPopUp(msg);
			result.btn2.visible = false;
			result.btn1Callback = yes;
			result.btn3Callback = no;
			result.btnOnEnter = result.btn1;
			result.setNameOfDynamicBtn(result.btn1, "Yes");
			result.setNameOfDynamicBtn(result.btn2, "Ok");
			result.setNameOfDynamicBtn(result.btn3, "No");
			return result; 
		}
		
		static public function createLoading(msg:String):UIPopUp {
			var result:UIPopUp = new UIPopUp(msg);
			result.btn1.visible = false;
			result.btn2.visible = false;
			result.btn3.visible = false;
			
			return result; 
		}
	}
}