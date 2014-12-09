package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _statuses_retweets(
		tokenSet:TwitterTokenSet,
		id:String,
		count:int=0,
		trimUser:Boolean=false
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(count>0)
		{
			parameters["count"]=count.toString();
		}
		parameters["trim_user"]=trimUser?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_retweets__ID.replace(":id",id),URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}