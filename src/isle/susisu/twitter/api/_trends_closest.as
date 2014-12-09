package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _trends_closest(
		tokenSet:TwitterTokenSet,
		latitude:String,
		longitude:String
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["lat"]=latitude;
		parameters["long"]=longitude;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.trends_CLOSEST,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}