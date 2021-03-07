package com.lachhh.flash.debug {
	import com.giveawaytool.MainGameTools;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.animation.AnimationManager;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;

	/**
	 * @author Lachhh
	 */
	public class DebugScreen extends UIBase {
		private var _height:int = -1;
		private var _txtDebug:TextField ;

		//static private var _Instance:FPSCounter;
		//static private var m_FPS_txt:TextField;
		
		
		public function DebugScreen() {
			super(0);
			_txtDebug = new TextField();
			_txtDebug.type = TextFieldType.INPUT;
			_txtDebug.multiline = false;
			_txtDebug.height = 20;
			_txtDebug.width = 350;
			_txtDebug.background = true;
			_txtDebug.backgroundColor = 0x666666;
			_txtDebug.textColor = 0xFFFFFF;
			visual.addChild(_txtDebug);
			SetHeight();
			ShowTree();
		}
		
		override public function destroy():void {
			super.destroy();
			var debugTree:DebugTree = GameTree.GetTree();
			visual.graphics.clear(); 
			if(visual.contains(debugTree.visual)) {
				visual.removeChild(debugTree.visual);
			}
			visual.removeChild(_txtDebug);
		}
					 
		private function ShowTree():void {
			var debugTree:DebugTree = GameTree.GetTree(); 
			if(!visual.contains(debugTree.visual)) {
				visual.addChild(debugTree.visual);
			}	
		}

		override public function update() : void {
			super.update();
			GameTree.update();
			
			if(KeyManager.IsKeyPressed(Keyboard.ENTER)) {
				GameTree.DoCallback(_txtDebug.text);
				_txtDebug.text = "";
			}
		}
						
		private function SetHeight():void {
			if(visual.stage != null && _height != visual.stage.stageHeight) {
				visual.graphics.clear();
				visual.graphics.beginFill(0, 0.5);
				visual.graphics.drawRect(0, 0, 350, visual.stage.height);
				visual.graphics.endFill();
			}
			_txtDebug.y = visual.stage.stageHeight - _txtDebug.height;
		}
	}
}
