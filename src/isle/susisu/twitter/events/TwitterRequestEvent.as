package isle.susisu.twitter.events{
	
	import flash.events.Event;
	
	public class TwitterRequestEvent extends Event{
		
		public static const COMPLETE:String="complete";
		
		public function TwitterRequestEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false){
			super(type,bubbles,cancelable);
		}
		
		override public function clone():Event{
			return (new TwitterRequestEvent(type,bubbles,cancelable));
		}
		
		override public function toString():String{
			return formatToString("TwitterRequestEvent","type","bubbles","cancelable");
		}
		
	}
	
}