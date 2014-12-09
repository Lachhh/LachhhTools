package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _statuses_show(
		tokenSet:TwitterTokenSet,
		id:String,
		trimUser:Boolean=false,
		includeMyRetweet:Boolean=false,
		includeEntities:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["id"]=id;
		parameters["trim_user"]=trimUser?TRUE:FALSE;
		parameters["include_my_retweet"]=includeMyRetweet?TRUE:FALSE;
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_SHOW,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}