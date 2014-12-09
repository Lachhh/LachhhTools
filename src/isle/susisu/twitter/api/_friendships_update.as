package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _friendships_update(
		tokenSet:TwitterTokenSet,
		userId:String=null,
		screenName:String=null,
		device:Boolean=false,
		retweets:Boolean=true
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
		parameters["device"]=device?TRUE:FALSE;
		parameters["retweets"]=retweets?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.friendships_UPDATE,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}