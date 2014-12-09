package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _statuses_retweet(
		tokenSet:TwitterTokenSet,
		id:String,
		trimUser:Boolean=false
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["trim_user"]=trimUser?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_retweet__ID.replace(":id",id),URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}