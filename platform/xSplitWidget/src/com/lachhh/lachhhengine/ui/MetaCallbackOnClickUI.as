package com.lachhh.lachhhengine.ui {
	import com.lachhh.io.Callback;

	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCallbackOnClickUI {
		static public var callbackOnClickForAllInstance:Callback ;
		public var callback:Callback ;
		public var visual:DisplayObject;
		public var isEnabled : Boolean;
		private var eventType : String;
	
		public function MetaCallbackOnClickUI(pVisual : DisplayObject, pEventType:String, pCallback : Callback) {
			if(pVisual == null) throw new Error("Visual is null");
			visual = pVisual;
			callback = pCallback;
			eventType = pEventType;
			register();
		}
		
		public function enable(b:Boolean):void {
			if(b) {
				register();
			} else {
				unregister();
			}
		}
		
		public function register():void {
			if(isEnabled) return ;
			visual.addEventListener(eventType, onEvent);
			isEnabled = true;
		}
		
		public function unregister():void {
			if(!isEnabled) return ;
			visual.removeEventListener(eventType, onEvent);
			isEnabled = false;
		}
		
		private function onEvent(e:Event):void {
			callback.call();
			if(callbackOnClickForAllInstance) callbackOnClickForAllInstance.call();
		}
	}

}
