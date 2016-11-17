package com.giveawaytool.ui {
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewMenuAlerts extends ViewBase {
		public var logicOnOffNotConnected:LogicOnOffNextFrame;
		public function ViewMenuAlerts(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			screen.setNameOfDynamicBtn(applyAndSaveBtn, "Apply & Save");
			screen.setNameOfDynamicBtn(stopAllAnimBtn, "Stop All Anims");
			screen.registerClick(applyAndSaveBtn, onApplySave);
			screen.registerClick(stopAllAnimBtn, onStopAllAnims);
			screen.registerClick(tutorialBtn, onTutorialBtn);

			logicOnOffNotConnected = (screen.addComponent(new LogicOnOffNextFrame(widgetNotConnectedMc)) as LogicOnOffNextFrame);
			logicOnOffNotConnected.isOn = false;
			UI_Menu.instance.logicNotification.logicSendToWidget.onWidgetChanged.addCallback(new Callback(refresh, this, null));
			UI_Menu.instance.logicNotification.logicSendToWidget.onSendFailed.addCallback(new Callback(shakeNoWidget, this, null));
			
		}

		private function onTutorialBtn() : void {
			new UI_TutorialWidget();
		}

		

		private function onApplySave() : void {
			UI_Menu.instance.logicNotification.logicSendToWidget.sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
			MetaGameProgress.instance.metaDonationsConfig.isDirty = false;
			screen.doBtnPressAnim(applyAndSaveBtn);
			MetaGameProgress.instance.saveToLocal();
			refresh();
		}

		private function onStopAllAnims() : void {
			UI_Menu.instance.logicNotification.logicSendToWidget.sendForceStopAnim();
		}

		override public function refresh() : void {
			super.refresh();
			dirtyNoticeMc.visible = MetaGameProgress.instance.metaDonationsConfig.isDirty;
			if(UI_Menu.instance.logicNotification.logicSendToWidget.hasAWidgetConnected()) {
				connectedToWidgetTxt.text = "Connected to Widget";
				connectedToWidgetTxt.textColor = 0x00CC00;
				//infoBtn.visible = false;
				stopAllAnimBtn.deselect();
			} else {
				connectedToWidgetTxt.text = "Not Connected";
				connectedToWidgetTxt.textColor = 0xCC0000;
				//infoBtn.visible = true;
				stopAllAnimBtn.select();
			}
			
			logicOnOffNotConnected.isOn = shouldShowNotConnectInfo();
		}

		private function shouldShowNotConnectInfo() : Boolean {
			if(UI_Menu.instance.logicNotification.logicSendToWidget.hasAWidgetConnected()) return false;
			if(!UI_Menu.instance.viewMenuUISelect.isUIneedsWidget()) return false;
			return true;
		}
		
		public function shakeNoWidget():void {
			screen.doBtnPressAnim(widgetNotConnectedMc);
		}
		
		public function get connectedToWidgetTxt() : TextField { return visual.getChildByName("connectedToWidgetTxt") as TextField;}
		public function get dirtyNoticeMc() : MovieClip {return visual.getChildByName("dirtyNoticeMc") as MovieClip;}
		public function get applyAndSaveBtn() : MovieClip { return visual.getChildByName("applyAndSaveBtn") as MovieClip;}
		public function get stopAllAnimBtn() : ButtonSelect { return visual.getChildByName("stopAllAnimBtn") as ButtonSelect;}
		//public function get infoBtn() : MovieClip { return visual.getChildByName("infoBtn") as MovieClip;}
		public function get widgetNotConnectedMc() : MovieClip { return visual.getChildByName("widgetNotConnectedMc") as MovieClip;}
		public function get tutorialBtn() : MovieClip { return widgetNotConnectedMc.getChildByName("tutorialBtn") as MovieClip;}
						
	}
}
