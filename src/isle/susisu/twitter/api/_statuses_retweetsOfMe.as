package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _statuses_retweetsOfMe(
		tokenSet:TwitterTokenSet,
		count:int=0,
		sinceId:String=null,
		maxId:String=null,
		trimUser:Boolean=false,
		includeEntities:Boolean=true,
		includeUserEntities:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
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
		parameters["trim_user"]=trimUser?TRUE:FALSE;
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		parameters["include_user_entities"]=includeUserEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_RETWEETS_OF_ME,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}