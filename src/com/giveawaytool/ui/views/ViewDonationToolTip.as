package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.giveawaytool.ui.LogicOnOffNextFrame;
	import com.giveawaytool.ui.UI_PopUp;
	import com.giveawaytool.ui.UIPopupEditDonations;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewDonationToolTip extends ViewBase {
		public var logicOpen : LogicOnOffNextFrame;
		public var metaDonation:MetaDonation = MetaDonation.NULL;
		public var viewDonation:ViewFollowerBtn;
		public function ViewDonationToolTip(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			logicOpen = LogicOnOffNextFrame.addToActor(actor, visualMc);
			screen.setNameOfDynamicBtn(btn1, "Collect");
			screen.setNameOfDynamicBtn(btn2, "Set as new");
			screen.setNameOfDynamicBtn(btn3, "Edit");
			screen.setNameOfDynamicBtn(btn4, "Delete");
			
			screen.registerClick(btn1, onClickCollect);
			screen.registerClick(btn2, onClickMarkAsNew);
			screen.registerClick(btn3, onClickEdit);
			screen.registerClick(btn4, onClickDelete);
			screen.registerClick(screen.visual, closeIfOpen);
		}

		private function closeIfOpen() : void {
			if(logicOpen.isOnLastFrame()) close();
		}
		
		public function registerDonationViewList(vList:Array):void  {
			for (var i : int = 0; i < vList.length; i++) {
				var v:ViewFollowerBtn = vList[i];
				registerDonationView(v);
			}
		}
		
		public function registerDonationView(v:ViewFollowerBtn):void  {
			screen.registerEventWithCallback(v.visual, MouseEvent.MOUSE_UP, new Callback(onClickDonationView, this, [v]));
		}
		
		public function onClickDonationView(view:ViewFollowerBtn):void {
			if(view.getMetaDonation().isNull()) return ;
			viewDonation = view;
			view.visualBtn.select();
			openWithDonation(view.getMetaDonation());
			var p:Point = new Point(-visual.parent.x, -visual.parent.y);
			p = view.visual.localToGlobal(p);
			visual.x = p.x;
			visual.y = p.y;
		}
		
		private function openWithDonation(m:MetaDonation):void {
			metaDonation = m;
			refresh();
			logicOpen.gotoFirstFrame();
			logicOpen.isOn = true;
		}
		
		private function close():void {
			if(viewDonation) {
				viewDonation.visualBtn.deselect();
			}
			logicOpen.isOn = false;
		}
		

		private function onClickCollect() : void {
			if(metaDonation.modelSource.isCalculated()) return ;

			UI_Menu.instance.logicNotification.logicSendToWidget.sendAddDonation(metaDonation);
			if(metaDonation.isNew) MetaGameProgress.instance.metaDonationsConfig.addDonationToGoalsAndCharity(metaDonation);
			metaDonation.isNew = false;
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refresh();
		}

		private function onClickMarkAsNew() : void {
			if(metaDonation.modelSource.isCalculated()) return ;
			metaDonation.isNew = !metaDonation.isNew;
			viewDonation.refresh();
			refresh();
		}
		
		private function onClickEdit() : void {
			UIPopupEditDonations.createEditDonation(metaDonation, new Callback(onEditApply, this, null));
		}

		private function onEditApply() : void {
			if(viewDonation) {
				viewDonation.refresh();
				screen.doBtnPressAnim(viewDonation.visualMc);
			}
			MetaGameProgress.instance.saveToLocal();
		}

		private function onClickDelete() : void {
			if(metaDonation.modelSource.isCalculated()) return ;
			UI_PopUp.createYesNo("Delete this donation? (If this donation is still on the server, it will appear again as new)", new Callback(onYesDelete, this, null), null);
		}
		
		private function onYesDelete():void {
			MetaGameProgress.instance.metaDonationsConfig.allDonations.remove(metaDonation);
			MetaGameProgress.instance.metaDonationsConfig.clearTopDonators();
			MetaGameProgress.instance.metaDonationsConfig.updateTopDonatorsIfBetter();
			screen.refresh();
		}
		
		override public function refresh() : void {
			super.refresh();
			if(metaDonation.isNull()) return ;
			
			screen.setNameOfDynamicBtn(btn2, metaDonation.isNew ? "Mark as read" : "Mark as new");
			
			if(metaDonation.modelSource.isCalculated()) {
				btn1.select();
				btn2.select();
				btn4.select();
				msgTxt.text = "Top donator";
			} else {
				btn1.deselect();
				btn2.deselect();
				btn4.deselect();
				msgTxt.text = metaDonation.getMsg();
			}
		}
		
		
		public function get panel() : MovieClip { return visual.getChildByName("panel") as MovieClip;}
		public function get btn1() : ButtonSelect { return panel.getChildByName("btn1") as ButtonSelect;}
		public function get btn2() : ButtonSelect { return panel.getChildByName("btn2") as ButtonSelect;}
		public function get btn3() : ButtonSelect { return panel.getChildByName("btn3") as ButtonSelect;}
		public function get btn4() : ButtonSelect { return panel.getChildByName("btn4") as ButtonSelect;}
		public function get msgTxt() : TextField { return panel.getChildByName("msgTxt") as TextField;}
	}
}
