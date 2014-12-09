package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _oauth_accessToken(
		tokenSet:TwitterTokenSet,
		verifier:String
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["oauth_verifier"]=verifier;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.oauth_ACCESS_TOKEN,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}