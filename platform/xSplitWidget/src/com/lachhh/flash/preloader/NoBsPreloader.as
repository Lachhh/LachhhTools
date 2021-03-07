package com.lachhh.flash.preloader {
	import com.lachhh.flash.IPreloader;
	import com.lachhh.io.Callback;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * @author Lachhh
	 */
	public class NoBsPreloader extends MovieClip implements IPreloader {
		private var _callback:Callback ;
		private var _tf:TextField = new TextField();
		private var _prct:Number =0;
		 
			
		public function init():void {
			
			addEventListener(Event.ENTER_FRAME, update);
			addChild(_tf);
		}
				
		private function update(e:Event):void {
			_prct = (root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal);
			//_prct += 0.01;
			graphics.clear();
			graphics.beginFill(0xFF0000);
			graphics.drawRect(200, 500, 300*_prct, 20);
			graphics.endFill();
			_tf.x = 530;
			_tf.y = 500;
			_tf.textColor = 0;
			_tf.text = Math.floor(_prct*100) + "";
			if(_prct >= 1) {
				EndPreloader();	
			}
		}
		
		private function EndPreloader() : void {
			removeEventListener(Event.ENTER_FRAME, update);
			_callback.call();
			_callback = null;
		}

		public function get visual() : MovieClip {
			return this;
		}
		
		public function get callback() : Callback {
			return _callback;
		}
		
		public function set callback(callback : Callback) : void {
			_callback = callback;
		}
	}
}
