package com.lachhh.lachhhengine.animation {
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class FlashAnimationViewCallback {
		public var frame:int ;
		public var callback:Callback ;
		public var repeat:Boolean;		
		
		public function FlashAnimationViewCallback(pCallback:Callback, pFrame:int, pRepeat:Boolean) {
			callback = pCallback;
			frame = pFrame;
			repeat = pRepeat;
		}
	}
}
