package com.lachhh.flash.ui {
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Simon Lachance
	 */
	public class ButtonSelect extends Button{
		private var _isSelected:Boolean = false;
		private var _toggleButtonMode:Boolean = false;
		public function ButtonSelect() {
			super();
			//this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseUp, false, 0, true);
		}

		override public function destroy():void {
			super.destroy();
			//removeEventListener(MouseEvent.MOUSE_DOWN, onMouseUp);
		}
		
		public function downToSelected():void {
			_isSelected = true;
			canGoto = false;
			gotoAndPlay("down");
			gotoFrameAfterDownAnim = frameSelected;
		}
		
		public function select():void {
			_isSelected = true;
			canGoto = false;
			gotoAndPlay("selected");
			gotoFrameAfterDownAnim = -1;
		}
		
		public function deselect():void {
			_isSelected = false;
			canGoto = true;
			gotoUp();
		}
		
		public function get isSelected():Boolean {
			return _isSelected;
		}
		
		public function get toggleButtonMode():Boolean {
			return _toggleButtonMode;
		}
		
		public function toggle():void {
			if(_isSelected) {
				deselect();
			} else {
				select();	
			}
		}
		
		public function selectIfBoolean(b:Boolean):void {
			if(b) {
				select();
			} else {
				deselect();
			}
		}
		
		private function onToggleDown(e:MouseEvent):void {
			toggle();
		}
		
		public function set toggleButtonMode(toggleButtonMode:Boolean):void {
			_toggleButtonMode = toggleButtonMode;
			if(_toggleButtonMode) {
				addEventListener(MouseEvent.MOUSE_DOWN, onToggleDown, false, 0, true);
			} else {
				removeEventListener(MouseEvent.MOUSE_DOWN, onToggleDown);
			}
		}
	}
}
