package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _trends_place(
		tokenSet:TwitterTokenSet,
		id:String,
		exclude:String=null
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["id"]=id;
		if(exclude!=null)
		{
			parameters["exclude"]=exclude;
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.trends_PLACE,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}