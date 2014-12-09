package isle.susisu.twitter.events{
	
	import flash.events.Event;
	
	public class TwitterErrorEvent extends Event{
		
		public static const CLIENT_ERROR:String="clientError";
		public static const SERVER_ERROR:String="serverError";
		
		public var statusCode:int;
		public var message:String;
		
		public function TwitterErrorEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false,statusCode:int=0,message:String=""){
			super(type,bubbles,cancelable);
			this.statusCode=statusCode;
			this.message=message;
		}
		
		override public function clone():Event{
			return (new TwitterErrorEvent(type,bubbles,cancelable,statusCode,message));
		}
		
		override public function toString():String{
			return formatToString("TwitterErrorEvent","type","bubbles","cancelable","statusCode","message");
		}
		
	}
	
}