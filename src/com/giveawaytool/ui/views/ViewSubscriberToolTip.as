package com.giveawaytool.ui.views {
	import com.giveawaytool.ui.MetaSubcriberAlert;
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.components.MetaFollowAlert;
	import com.giveawaytool.meta.MetaGameProgress;
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
	public class ViewSubscriberToolTip extends ViewBase {
		public var logicOpen : LogicOnOffNextFrame;
		public var metaSubscriber:MetaSubscriber = MetaSubscriber.NULL;
		public var viewSubscriber : ViewSubscriberBtn;

		public function ViewSubscriberToolTip(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			logicOpen = LogicOnOffNextFrame.addToActor(actor, visualMc);
			screen.setNameOfDynamicBtn(btn1, "Alert");
			screen.setNameOfDynamicBtn(btn2, "Set as new");
			screen.setNameOfDynamicBtn(btn3, "Edit");
			screen.setNameOfDynamicBtn(btn4, "Delete");
			btn3.visible = false;
			btn4.visible = false;
			screen.registerClick(btn1, onClickAlert);
			screen.registerClick(btn2, onClickMarkAsNew);
			//screen.registerClick(btn3, onClickEdit);
			//screen.registerClick(btn4, onClickDelete);
			screen.registerClick(screen.visual, closeIfOpen);
		}

		private function onClickAlert() : void {
			UI_Menu.instance.logicNotification.logicSendToWidget.sendSubscriberAlert(MetaSubcriberAlert.createFromSub(metaSubscriber));
		}

		private function closeIfOpen() : void {
			if(logicOpen.isOnLastFrame()) close();
		}
		
		public function registerDonationViewList(vList:Array):void  {
			for (var i : int = 0; i < vList.length; i++) {
				var v:ViewFollowerBtn = vList[i];
				registerFollowerView(v);
			}
		}
		
		public function registerFollowerView(v:ViewFollowerBtn):void  {
			screen.registerEventWithCallback(v.visual, MouseEvent.MOUSE_UP, new Callback(onClickSubscriberView, this, [v]));
		}
		
		public function onClickSubscriberView(view:ViewSubscriberBtn):void {
			if(view == null) return; 
			if(view.getMetaSubscriber().isNull()) return ;
			if(viewSubscriber) {
				viewSubscriber.visualBtn.deselect();
			}
			viewSubscriber = view;
			view.visualBtn.select();
			openWithFollower(view.getMetaSubscriber());
			var p:Point = new Point(-visual.parent.x, -visual.parent.y);
			p = view.visual.localToGlobal(p);
			visual.x = p.x;
			visual.y = p.y;
		}
		
		private function openWithFollower(m:MetaSubscriber):void {
			metaSubscriber = m;
			refresh();
			logicOpen.gotoFirstFrame();
			logicOpen.isOn = true;
		}
		
		private function close():void {
			if(viewSubscriber) {
				viewSubscriber.visualBtn.deselect();
			}
			logicOpen.isOn = false;
		}
		
		private function onClickMarkAsNew() : void {
			metaSubscriber.isNew = !metaSubscriber.isNew;
			viewSubscriber.refresh();
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			if(metaSubscriber.isNull()) return ;
			
			screen.setNameOfDynamicBtn(btn2, metaSubscriber.isNew ? "Mark as read" : "Mark as new");
			
			btn1.deselect();
			btn2.deselect();
			btn4.deselect();
			msgTxt.text = metaSubscriber.getDescForToolTip();	
		}
		
		
		public function get panel() : MovieClip { return visual.getChildByName("panel") as MovieClip;}
		public function get btn1() : ButtonSelect { return panel.getChildByName("btn1") as ButtonSelect;}
		public function get btn2() : ButtonSelect { return panel.getChildByName("btn2") as ButtonSelect;}
		public function get btn3() : ButtonSelect { return panel.getChildByName("btn3") as ButtonSelect;}
		public function get btn4() : ButtonSelect { return panel.getChildByName("btn4") as ButtonSelect;}
		public function get msgTxt() : TextField { return panel.getChildByName("msgTxt") as TextField;}
	}
}
