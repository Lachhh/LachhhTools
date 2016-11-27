package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaHostConfig;
	import com.giveawaytool.ui.views.ViewCustomAnimBtn;
	import com.giveawaytool.ui.views.ViewHostToolTip;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewHostSettings extends ViewBase {
		public var viewHostList:ViewHostList;
		public var viewHostTooltip:ViewHostToolTip;
		public var viewCustomBtn:ViewCustomAnimBtn;
		
		public function ViewHostSettings(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
						
			viewHostList = new ViewHostList(pScreen, lastHostMc);
			viewHostTooltip = new ViewHostToolTip(pScreen, toolTipHostMc);
			viewHostList.toolTip = viewHostTooltip;
			
			viewCustomBtn = new ViewCustomAnimBtn(pScreen, customAnimBtn, MetaGameProgress.instance.metaDonationsConfig.metaCustomAnim.metaCustomAnimNewHost);
			viewCustomBtn.callbackOnTest = new Callback(UI_Menu.instance.logicNotification.logicSendToWidget.sendTestHost, this, null);
			screen.registerClick(newHostBtn, onNewHost);
			pScreen.registerEvent(bigHostNumTxt, FocusEvent.FOCUS_OUT, onEdit);
		}

		private function onEdit() : void {
			var crntAmount:int = FlashUtils.myParseFloat(bigHostNumTxt.text);
			var m:MetaHostConfig = MetaGameProgress.instance.metaHostAlertConfig;
			if(!isNaN(crntAmount)) m.bigHostNum = crntAmount;
			
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refresh(); 
		}
		
		private function onNewHost() : void {
			MetaGameProgress.instance.metaHostAlertConfig.alertOnNewHost = !MetaGameProgress.instance.metaHostAlertConfig.alertOnNewHost;
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			viewHostList.setData(MetaGameProgress.instance.metaHostAlertConfig.metaHosts.hosts);
			viewHostList.refresh();
			
			setCheckBox(MetaGameProgress.instance.metaHostAlertConfig.alertOnNewHost, newHostBtn);
			bigHostNumTxt.text = MetaGameProgress.instance.metaHostAlertConfig.bigHostNum + "";
			 
		}
		
		public function setCheckBox(value : Boolean, btn : MovieClip) : void {
			var checkedMc : MovieClip = btn.getChildByName("checkedMc") as MovieClip;
			if(checkedMc) checkedMc.visible = value;
		}
		
		public function get hostAlertsMc() : MovieClip { return visual.getChildByName("hostAlertsMc") as MovieClip;}
		public function get newHostBtn() : MovieClip { return hostAlertsMc.getChildByName("newHostBtn") as MovieClip;}
		public function get bigHostNumTxt() : TextField { return hostAlertsMc.getChildByName("bigHostNumTxt") as TextField;}
		public function get lastHostMc() : MovieClip { return visual.getChildByName("lastHostMc") as MovieClip;}
		public function get toolTipHostMc() : MovieClip { return visual.getChildByName("toolTipHostMc") as MovieClip;}
		public function get customAnimBtn() : MovieClip { return visual.getChildByName("customAnimBtn") as MovieClip;}
	}
}
