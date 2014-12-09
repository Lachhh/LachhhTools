package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _oauth_requestToken(
		tokenSet:TwitterTokenSet
	):TwitterRequest
	{
		var parameters:Object=new Object();
		parameters["oauth_callback"]="oob";
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.oauth_REQUEST_TOKEN,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}