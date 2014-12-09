package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _savedSearches_create(
		tokenSet:TwitterTokenSet,
		query:String
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["query"]=encodeText(query);
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.savedSearches_CREATE,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}