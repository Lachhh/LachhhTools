package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _application_rateLimitStatus(
		tokenSet:TwitterTokenSet,
		resources:Array
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["resources"]=encodeText(resources.join(","));
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.application_RATE_LIMIT_STATUS,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}