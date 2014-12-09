package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _lists_list(
		tokenSet:TwitterTokenSet,
		userId:String=null,
		screenName:String=null
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
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.lists_LIST,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}