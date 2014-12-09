package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _savedSearches_show(
		tokenSet:TwitterTokenSet,
		id:String
	):TwitterRequest
	{
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.savedSearches_show__ID.replace(":id",id),URLRequestMethod.GET);
		
		return request;
	}
	
}