package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _users_suggestions(
		tokenSet:TwitterTokenSet,
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
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.users_SUGGESTIONS,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}