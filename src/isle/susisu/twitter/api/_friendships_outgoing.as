package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _friendships_outgoing(
		tokenSet:TwitterTokenSet,
		cursor:String="-1"
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["stringify_ids"]=TRUE;
		if(cursor!="-1")
		{
			parameters["cursor"]=cursor;
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.friendships_OUTGOING,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}