package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _statuses_userTimeline(
		tokenSet:TwitterTokenSet,
		userId:String=null,
		screenName:String=null,
		count:int=0,
		sinceId:String=null,
		maxId:String=null,
		excludeReplies:Boolean=false,
		contributorDetails:Boolean=false,
		includeRTs:Boolean=true
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
		parameters["exclude_replies"]=excludeReplies?TRUE:FALSE;
		parameters["contributor_details"]=contributorDetails?TRUE:FALSE;
		parameters["include_rts"]=includeRTs?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_USER_TIMELINE,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}