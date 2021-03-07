package com.lachhh.flash.debug {
	import com.lachhh.io.Callback;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;


	/**
	 * @author Lachhh
	 */
	public class DebugTree implements IDebugTreeChild {
		private var _childs:Array;
		private var _name:String;
		private var _txt:TextField;
		private var _visual:MovieClip;
		private var _txtContainer:MovieClip;
		private var _isOpen:Boolean = false;
		private var _parent:DebugTree ;
		private var _updateCallBack:Callback;

		public function DebugTree() {
			
			_childs = new Array();
			_txt = new TextField();
			_txt.textColor = 0xFFFFFF;
			_txt.x = 20;
			_txt.selectable = false;
			_txt.autoSize = TextFieldAutoSize.LEFT;
			
			_txtContainer = new MovieClip();
			_txtContainer.addChild(_txt);
			_txtContainer.buttonMode = true;
			_txtContainer.useHandCursor = true;
			
			_visual = new MovieClip();
			_visual.addChild(_txtContainer);
			
			DrawSwitch();
			_txtContainer.addEventListener(MouseEvent.MOUSE_DOWN, onClick, false, 0, true);
		}
		
		public function update():void {
			//Update Children
			for (var i:int = 0 ; i < _childs.length ; i++) {
				var child:DebugTree = _childs[i];
				child.update();	
			}
			if(_updateCallBack != null){
				_updateCallBack.call();	
			} 
		}
		
		private function DrawSwitch():void {
			_visual.graphics.clear();
			if(_childs.length > 0) {
				if(_isOpen) {
					_visual.graphics.lineStyle(2,0xAAAAFF);
					_visual.graphics.moveTo(5, 10);
					_visual.graphics.lineTo(15, 10);
				} else {
					_visual.graphics.beginFill(0xAAAAFF);
					_visual.graphics.drawCircle(10, 10, 5);
					_visual.graphics.endFill();
				}
			}
		}
		
		private function onClick(e:MouseEvent):void {
			(_isOpen ? Close() : Open());
		}
		
		private function RenderChildren():void {
			var i:int;
			var child:DebugTree;
			if(_isOpen) {
				var y:int = 15;
				for (i = 0 ; i < _childs.length ; i++) {
					child = _childs[i];
					child.visual.visible = true;
					child.visual.x = 15;
					child.visual.y = y;
					
					y += child.GetChildHeight();
				}
			} else {
				for (i = 0 ; i < _childs.length ; i++) {
					child = _childs[i];
					child.visual.visible = false;
				}
			}
			
		}
		
		
		private function RecurRender():void {
			DrawSwitch();
			RenderChildren();
			if(parent != null) {
				parent.RecurRender();
			}
		}
		
		public function AddChild(child:DebugTree):void {
			if(Utils.IsInArray(_childs, child)){
				return;	
			}
			_childs.push(child);
			_visual.addChild(child.visual);
			child.parent = this;
			RecurRender();
		}
		
		public function AddChildAt(child:DebugTree, i:int):void {
			if(Utils.IsInArray(_childs, child)){
				return;	
			}
			_childs.splice(i, 0, child);
			_visual.addChild(child.visual);
			child.parent = this;
			RecurRender();	
		}
		
		public function RemoveChild(child:DebugTree):void {
			if(!Utils.IsInArray(_childs, child)){
				return;	
			}
			Utils.RemoveFromArray(_childs, child);	
			_visual.removeChild(child.visual);
			child.parent = null;
			RecurRender();		
		}
		
		public function RemoveAllChild():void {
			while(_childs.length > 0) RemoveChild(_childs[0]);
		}
		
		public function GetChildAt(i:int):DebugTree {
			return _childs[i];
		}
		
		public function get numChild():int {
			return _childs.length;	
		}

		public function Open():void {
			_isOpen = true;
			DrawSwitch();
			RecurRender();
		}
		
		public function Close():void {
			_isOpen = false;
			DrawSwitch();
			RecurRender();
		}
		
		public function Destroy():void {
			_txtContainer.removeEventListener(MouseEvent.MOUSE_DOWN, onClick)	;
		}
		
		public function GetChildHeight():int {
			if(!_isOpen) return 15;
			var y:int = 15;
			for (var i:int = 0 ; i <  _childs.length ; i++) {
				var child:DebugTree = _childs[i];
				if(child.isOpen) {
					y+= child.GetChildHeight(); 
				} else {
					y+= 15;	
				}
			}
			return y;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function set name(name:String):void {
			_name = name;
			_txt.text = name;
		}
		
		public function get visual():DisplayObject {
			return _visual;
		}
		
		public function get height():Number {
			return (_isOpen ? _childs.length*15+15 : 15);
		}
		
		public function get parent():DebugTree {
			return _parent;
		}
		
		public function set parent(parent:DebugTree):void {
			_parent = parent;
		}
		
		public function get updateCallBack():Callback {
			return _updateCallBack;
		}
		
		public function set updateCallBack(updateCallBack:Callback):void {
			_updateCallBack = updateCallBack;
		}
		
		public function get isOpen():Boolean {
			return _isOpen;
		}  
	}
}
