package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _users_suggestions_members(
		tokenSet:TwitterTokenSet,
		slug:String
	):TwitterRequest
	{
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.users_suggestions__slug_MEMBERS.replace(":slug",slug),URLRequestMethod.GET);
		
		return request;
	}
	
}