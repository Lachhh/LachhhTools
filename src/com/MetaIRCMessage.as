package com {
	import com.lachhh.flash.FlashUtils;
	/**
	 * @author LachhhSSD
	 */
	public class MetaIRCMessage {
		public var name:String;
		public var text:String;
		
		public function MetaIRCMessage() {
		}
		
		public function isNotificationFromTwitch():Boolean {
			return (name == "twitchnotify") || (name == "jtv");
		}
		
		public function isMoobot():Boolean {
			return name == "moobot";
		}
		
		public function isHostAlert():Boolean {
			if(!isNotificationFromTwitch()) return false;
			return text.indexOf("is now hosting you") >= 0;
		}
		
		public function isNewSubAlert():Boolean {
			if(!isNotificationFromTwitch()) return false;
			return text.indexOf("just subscribed!") >= 0;
		}
		
		public function isReSubAlert():Boolean {
			if(!isNotificationFromTwitch()) return false;
			return text.indexOf("subscribed for") >= 0;
		}
		
		public function getHostName():String {
			if(!isHostAlert()) return "";
			var data:Array = text.split(" ");
			return data[0];
		}
		
		public function getHostViewerCount():int {
			if(!isHostAlert()) return 0;
			var data:Array = text.split(" ");
			return FlashUtils.myParseFloat(data[6]);
		}
		
		public function getSubName():String {
			if(!isReSubAlert() && !isNewSubAlert()) return "";
			var data:Array = text.split(" ");
			return data[0];
		}
		
		public function getResubMonth():int {
			if(!isReSubAlert()) return 0;
			var data:Array = text.split(" ");
			return FlashUtils.myParseFloat(data[3]);
		}
		
		static public function isPing(msg:String):Boolean {
			return (msg.indexOf("PING :tmi.twitch.tv") == 0);
		}
		
		static public function createDummyHost():MetaIRCMessage {
			var result:MetaIRCMessage = new MetaIRCMessage();
			result.name = "twitchnotify";
			result.text = "TheDude is now hosting you.";
			return result;
		}
		
		static public function createFromRawData(msg:String):MetaIRCMessage {
			var result:MetaIRCMessage = new MetaIRCMessage();
			var nameLength:int = msg.indexOf("!");
			var messageStartIndex:int = msg.indexOf(":", nameLength);
			result.name = msg.substring(1, nameLength); // trim the initial ':'
			result.text = msg.substring(messageStartIndex + 1, msg.length);
			
			return result;
		}
	}
}
