package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _users_lookup(
		tokenSet:TwitterTokenSet,
		userIds:Array=null,
		screenNames:Array=null,
		includeEntities:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(userIds!=null)
		{
			parameters["user_id"]=encodeText(userIds.join(","));
		}
		if(screenNames!=null)
		{
			parameters["screen_name"]=encodeText(screenNames.join(","));
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.users_LOOKUP,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}