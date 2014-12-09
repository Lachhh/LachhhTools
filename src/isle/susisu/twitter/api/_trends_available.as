package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _trends_available(
		tokenSet:TwitterTokenSet
	):TwitterRequest
	{
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.trends_AVAILABLE,URLRequestMethod.GET);
		
		return request;
	}
	
}