package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _followers_list(
		tokenSet:TwitterTokenSet,
		userId:String=null,
		screenName:String=null,
		cursor:String="-1",
		skipStatus:Boolean=true,
		includeUserEntities:Boolean=true
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
		if(cursor!="-1")
		{
			parameters["cursor"]=cursor;
		}
		parameters["skip_status"]=skipStatus?TRUE:FALSE;
		parameters["include_user_entities"]=includeUserEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.followers_LIST,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}