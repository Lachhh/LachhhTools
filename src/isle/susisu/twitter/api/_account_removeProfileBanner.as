package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _account_removeProfileBanner(
		tokenSet:TwitterTokenSet
	):TwitterRequest
	{
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.account_REMOVE_PROFILE_BANNER,URLRequestMethod.POST);
		
		return request;
	}
	
}