package com.giveawaytool.io {
	import com.google.analytics.GATracker;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author LachhhSSD
	 */
	public class GoogleAnalyticController {
		public var tracker : GATracker;

		public function GoogleAnalyticController(root:DisplayObjectContainer, id:String) {
			tracker = new GATracker(root, id, "AS3", false);
		}

		public function trackView(arg0 : String) : void {
			tracker.trackPageview();
		}

		public function trackEvent(arg0 : String, arg1 : String) : void {
			tracker.trackEvent(arg0, arg1);
		}

		public function trackEventWithValue(nameEvent : String, nameValue : String, value : int) : void {
			tracker.trackEvent(nameEvent, nameValue, value+"");
		}
	}
}
