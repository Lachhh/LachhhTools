package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _followers_ids(
		tokenSet:TwitterTokenSet,
		userId:String=null,
		screenName:String=null,
		cursor:String="-1",
		count:int=0
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["stringify_ids"]=TRUE;
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
		if(count>0)
		{
			parameters["count"]=count.toString();
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.followers_IDS,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}