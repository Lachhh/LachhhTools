package com.lachhh.flash.ui {
	
	/**
	 * @author Simon Lachance
	 */
	public class ButtonSelectGroup {
		private var _btns:Vector.<ButtonSelect> ;
		private var _selectedButton : ButtonSelect ;
		
		public function ButtonSelectGroup() {
			_btns = new Vector.<ButtonSelect>();	
		}
				
		public function clear():void {
			removeAllButton();
		}
		
		public function addButton(b : ButtonSelect) : void {
			var i:int = _btns.indexOf(b) ;
			if(i == -1) _btns.push(b);
		} 
		
		public function removeButton(b : ButtonSelect) : void {
			var i:int = _btns.indexOf(b) ;
			if(i != -1) _btns.splice(i,1);
		}
		
		public function removeAllButton() : void {
			_btns = new Vector.<ButtonSelect>;
		} 
		 
		public function getButton(i : int) : ButtonSelect {
			if(i < 0 || i >= _btns.length) {
				throw new Error("index error : " + i);	
			}
			return _btns[i];
		}

		public function getButtonIndex(b : ButtonSelect) : int {
			for(var i:int = 0 ; i < _btns.length ; i++) {
				if(_btns[i] == b) return i;	
			}	
			return -1;
		}
				
		public function destroy():void {
			while(_btns.length > 0) {
				var b : ButtonSelect = _btns.shift();
				b.destroy();	
			}
			_btns = null;	
		}
		
		public function deselect():void {
			for(var i:int = 0 ; i < _btns.length ; i++) {
				_btns[i].deselect();	
			}	
			_selectedButton = null;
		}
		
		public function contains(b : ButtonSelect):Boolean {
			
			return (_btns.indexOf(b) != -1);
		}
		
		public function selectButtonFromIndex(i:int):void {
			selectButton(getButton(i));
		}
		
		public function selectButton(b:ButtonSelect):void {
			if(!contains(b)) {
				return ;
			}
			
			if(_selectedButton != null) {
				_selectedButton.deselect();	
			}
			_selectedButton = b;
			_selectedButton.select();
		}
		
		public function SelectNext():void {
			if(_selectedButton == null) return ;
			var i:int = (getButtonIndex(_selectedButton)+1);
			if(i >= _btns.length) i = 0;
			selectButton(_btns[(getButtonIndex(_selectedButton)+1)% _btns.length]);
		}
		
		public function selectPrev():void {
			if(_selectedButton == null) return ;
			var i:int = (getButtonIndex(_selectedButton)-1);
			if(i < 0) i = _btns.length-1;
			selectButton(_btns[i]);	
		}
		
		public function get length():int {
			return _btns.length;
		}
		
		public function get selectedButton():ButtonSelect {
			return _selectedButton;
		}
	}
}
