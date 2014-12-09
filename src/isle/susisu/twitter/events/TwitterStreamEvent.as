package isle.susisu.twitter.events{
	
	import flash.events.Event;
	
	public class TwitterStreamEvent extends Event{
		
		public static const CONNECTED:String="connected";
		public static const DISCONNECTED:String="disconnected";
		public static const MESSAGE_RECEIVED:String="messageReceived";
		
		public var message:String;
		
		public function TwitterStreamEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false,message:String=""){
			super(type,bubbles,cancelable);
			this.message=message;
		}
		
		override public function clone():Event{
			return (new TwitterStreamEvent(type,bubbles,cancelable,message));
		}
		
		override public function toString():String{
			return formatToString("TwitterStreamEvent","type","bubbles","cancelable","message");
		}
		
	}
	
}