package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _users_contributors(
		tokenSet:TwitterTokenSet,
		userId:String=null,
		screenName:String=null,
		includeEntities:Boolean=true,
		skipStatus:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(userId!=null)
		{
			parameters["user_id"]=userId;
		}
		if(screenName!=null)
		{
			parameters["screen_name"]=screenName;
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		parameters["skip_status"]=skipStatus?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.users_CONTRIBUTORS,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}