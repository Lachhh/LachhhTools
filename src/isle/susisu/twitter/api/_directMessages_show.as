package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _directMessages_show(
		tokenSet:TwitterTokenSet,
		id:String
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["id"]=id;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.directMessages_SHOW,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}