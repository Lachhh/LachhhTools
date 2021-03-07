package com.lachhh.flash.ui {
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Simon Lachance
	 */
	public class Button extends MovieClip{
		private var _canGoto:Boolean = true;
		public var gotoFrameAfterDownAnim:int = -1;
		public function Button() {
			super();
			buttonMode = true;
			useHandCursor = true;
			gotoFrameAfterDownAnim = -1;
			init();
		}

		protected function init():void {
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true); 
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			addEventListener(Event.ENTER_FRAME, onUpdate);
			mouseChildren = false;  
			if(frameSelected != -1) {
				gotoAndStop(frameSelected-1);
			} else {
				gotoAndStop(totalFrames);
			}
			
			
			gotoUp();
		}

		private function onUpdate(event : Event) : void {
			if(gotoFrameAfterDownAnim != -1) {
				if(currentFrame >= (frameOver -1)) {
					gotoAndStop(gotoFrameAfterDownAnim);
					gotoFrameAfterDownAnim = -1;
				}
			}
		}
		
		public function gotoUp():void {
			gotoAndPlay("up");
		}
		
		public function gotoDown():void {
			gotoAndPlay("down");
			gotoFrameAfterDownAnim = frameUp;
		}
		
		public function destroy():void {
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver); 
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(Event.ENTER_FRAME, onUpdate);
			mouseChildren = false;
			buttonMode = false;    
		}
		
		private function onMouseOver(e:MouseEvent):void{
			if(!canGoto) return;
			if(!canDoOverAnim) return ;
		    gotoAndPlay("over");
			//trace("over");
			
		}
		private function onMouseOut(e:MouseEvent):void{
			if(!canGoto) return;
			if(!canDoOverAnim) return ;
		    gotoAndPlay("out");
			//trace("out");
		}

		public function onMouseDown(e:MouseEvent):void{
			if(!canGoto) return;
			
			gotoAndPlay("down");
			gotoFrameAfterDownAnim = frameUp;
			//trace("down");
		}	
		
		private function onMouseUp(e:MouseEvent):void{
			if(!canGoto) return;
			if(!canDoOverAnim) return ;
			//trace("up");
		}	
		
		public function get canGoto():Boolean {
			return _canGoto;
		}
		
		public function set canGoto(b:Boolean):void {
			_canGoto = b;
			buttonMode = b;
			useHandCursor = b;
		}
		
		private function findFrame(frame:String):int {
			var labels:Array = currentLabels;
		
			for (var i:uint = 0; i < labels.length; i++) {
			    var label:FrameLabel = labels[i];
			    if(label.name == frame) {
			    	return label.frame; 
			    }
			}
			return -1;			
		}
		
		
		public function get canDoOverAnim():Boolean {
			return gotoFrameAfterDownAnim == -1;
		}
		


		public function get frameUp():int {return findFrame("up");}
		public function get frameDown():int {return findFrame("down");}
		public function get frameOver():int {return findFrame("over");}
		public function get frameOut():int {return findFrame("out");}
		public function get frameSelected():int {return findFrame("selected");}
	}
}
