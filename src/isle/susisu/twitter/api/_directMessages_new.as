package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _directMessages_new(
		tokenSet:TwitterTokenSet,
		text:String,
		userId:String=null,
		screenName:String=null
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["text"]=encodeText(text);
		if(userId!=null)
		{
			parameters["user_id"]=userId;
		}
		if(screenName!=null)
		{
			parameters["screen_name"]=screenName;
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.directMessages_NEW,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}