package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _help_privacy(
		tokenSet:TwitterTokenSet
	):TwitterRequest
	{
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.help_PRIVACY,URLRequestMethod.GET);
		
		return request;
	}
	
}