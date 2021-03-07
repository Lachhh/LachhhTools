package com.lachhh.lachhhengine.ui {
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class UIOpenClose extends UIBase {
		public var idleFrame:int;
		public var closeStartFrame:int;
		public var callbackOnClose:Callback;
		
		public function UIOpenClose(visualId : int, pIdleFrame:int, pCloseStartFrame:int) {
			super(visualId);
			
			idleFrame = pIdleFrame;
			closeStartFrame = pCloseStartFrame ;
			addOpenCloseCallbacks(); 
		}
		
		protected function addOpenCloseCallbacks():void {
			renderComponent.animView.addCallbackOnFrameRepeat(new Callback(onIdle, this, null), idleFrame, true);
		}

		protected function onIdle() : void {
			renderComponent.animView.stop();
		}
		
		public function close():void {
			enableAllClicks(false);
			renderComponent.animView.gotoAndPlay(closeStartFrame);
		}
		
		public function closeWithCallbackOnEnd(callback:Callback):void {
			close();
			if(callback) renderComponent.animView.addEndCallback(callback);
		}

		override public function update() : void {
			super.update();
			checkOnLastFrame();
		}
		
		public function checkOnLastFrame() :void {
			if(renderComponent.animView.loops >= 1) {
				if(callbackOnClose) callbackOnClose.call();
				destroy();
			}
		}
	}
}
