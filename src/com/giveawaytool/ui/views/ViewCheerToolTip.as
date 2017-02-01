package com.giveawaytool.ui.views {
	import com.giveawaytool.ui.LogicOnOffNextFrame;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewCheerToolTip extends ViewBase {
		public var logicOpen : LogicOnOffNextFrame;
		public var metaCheer:MetaCheer = MetaCheer.NULL;
		public var viewCheer : ViewCheerBtn;

		public function ViewCheerToolTip(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			logicOpen = LogicOnOffNextFrame.addToActor(actor, visualMc);
			screen.setNameOfDynamicBtn(btn1, "Alert");
			screen.setNameOfDynamicBtn(btn2, "Set as new");
			screen.setNameOfDynamicBtn(btn3, "Edit");
			screen.setNameOfDynamicBtn(btn4, "Delete");
			btn2.visible = false;
			btn3.visible = false;
			btn4.visible = false;
			screen.registerClick(btn1, onClickAlert);
			//screen.registerClick(btn2, onClickMarkAsNew);
			//screen.registerClick(btn3, onClickEdit);
			//screen.registerClick(btn4, onClickDelete);
			screen.registerClick(screen.visual, closeIfOpen);
		}

		private function onClickAlert() : void {
			if(!UI_Menu.instance.logicNotification.logicVIPAccess.canSendCheersIfNotLive()) return ;
			UI_Menu.instance.logicNotification.logicSendToWidget.sendCheerAlert(MetaCheerAlert.createFromCheer(metaCheer));
		}

		private function closeIfOpen() : void {
			if(logicOpen.isOnLastFrame()) close();
		}
		

		public function onClickCheerView(view:ViewCheerBtn):void {
			if(view == null) return; 
			if(view.getMetaCheer().isNull()) return ;
			if(viewCheer) {
				viewCheer.visualBtn.deselect();
			}
			viewCheer = view;
			view.visualBtn.select();
			openWithFollower(view.getMetaCheer());
			var p:Point = new Point(-visual.parent.x, -visual.parent.y);
			p = view.visual.localToGlobal(p);
			visual.x = p.x;
			visual.y = p.y;
		}
		
		private function openWithFollower(m:MetaCheer):void {
			metaCheer = m;
			refresh();
			logicOpen.gotoFirstFrame();
			logicOpen.isOn = true;
		}
		
		private function close():void {
			if(viewCheer) {
				viewCheer.visualBtn.deselect();
			}
			logicOpen.isOn = false;
		}
	
		override public function refresh() : void {
			super.refresh();
			if(metaCheer.isNull()) return ;
			
			
			
			btn1.deselect();
			btn2.deselect();
			btn4.deselect();
			msgTxt.text = metaCheer.getDescForToolTip();	
		}
		
		
		public function get panel() : MovieClip { return visual.getChildByName("panel") as MovieClip;}
		public function get btn1() : ButtonSelect { return panel.getChildByName("btn1") as ButtonSelect;}
		public function get btn2() : ButtonSelect { return panel.getChildByName("btn2") as ButtonSelect;}
		public function get btn3() : ButtonSelect { return panel.getChildByName("btn3") as ButtonSelect;}
		public function get btn4() : ButtonSelect { return panel.getChildByName("btn4") as ButtonSelect;}
		public function get msgTxt() : TextField { return panel.getChildByName("msgTxt") as TextField;}
	}
}
