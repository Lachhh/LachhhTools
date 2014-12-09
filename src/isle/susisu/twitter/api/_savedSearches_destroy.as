package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _savedSearches_destroy(
		tokenSet:TwitterTokenSet,
		id:String
	):TwitterRequest
	{
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.savedSearches_destroy__ID.replace(":id",id),URLRequestMethod.POST);
		
		return request;
	}
	
}