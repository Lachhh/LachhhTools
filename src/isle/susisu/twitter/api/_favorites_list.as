package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _favorites_list(
		tokenSet:TwitterTokenSet,
		userId:String=null,
		screenName:String=null,
		count:int=0,
		sinceId:String=null,
		maxId:String=null,
		includeEntities:Boolean=true
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
		if(count>0)
		{
			parameters["count"]=count.toString();
		}
		if(sinceId!=null)
		{
			parameters["since_id"]=sinceId;
		}
		if(maxId!=null)
		{
			parameters["max_id"]=maxId;
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.favorites_LIST,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}