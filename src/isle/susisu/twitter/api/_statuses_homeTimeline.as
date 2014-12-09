package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _statuses_homeTimeline(
		tokenSet:TwitterTokenSet,
		count:int=0,
		sinceId:String=null,
		maxId:String=null,
		trimUser:Boolean=false,
		excludeReplies:Boolean=false,
		contributorDetails:Boolean=false,
		includeEntities:Boolean=true
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
		parameters["exclude_replies"]=excludeReplies?TRUE:FALSE;
		parameters["contributor_details"]=contributorDetails?TRUE:FALSE;
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_HOME_TIMELINE,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}