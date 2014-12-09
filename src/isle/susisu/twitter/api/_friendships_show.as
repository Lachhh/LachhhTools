package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _friendships_show(
		tokenSet:TwitterTokenSet,
		sourceId:String=null,
		sourceScreenName:String=null,
		targetId:String=null,
		targetScreenName:String=null
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(sourceId!=null)
		{
			parameters["source_id"]=sourceId;
		}
		if(sourceScreenName!=null)
		{
			parameters["source_screen_name"]=sourceScreenName;
		}
		if(targetId!=null)
		{
			parameters["target_id"]=targetId;
		}
		if(targetScreenName!=null)
		{
			parameters["target_screen_name"]=targetScreenName;
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.friendships_SHOW,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}