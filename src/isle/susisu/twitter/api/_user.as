package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterStream;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _user(
		tokenSet:TwitterTokenSet,
		stallWarnings:Boolean=false,
		withParam:String="user",
		replies:String=null,
		track:String=null,
		locations:String=null
	):TwitterStream
	{
		//parameters
		var parameters:Object=new Object();
		parameters["stall_warnings"]=stallWarnings?TRUE:FALSE;
		parameters["with"]=withParam;
		if(replies!=null)
		{
			parameters["replies"]=replies;
		}
		if(track!=null)
		{
			parameters["track"]=track;
		}
		if(locations!=null)
		{
			parameters["locations"]=locations;
		}
		//make stream
		var stream:TwitterStream=new TwitterStream(tokenSet,TwitterURL.USER,URLRequestMethod.GET,parameters);
		
		return stream;
	}
	
}