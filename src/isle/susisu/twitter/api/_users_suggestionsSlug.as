package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _users_suggestionsSlug(
		tokenSet:TwitterTokenSet,
		slug:String,
		lang:String=null
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(lang!=null)
		{
			parameters["lang"]=lang;
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.users_suggestions__SLUG.replace(":slug",slug),URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}