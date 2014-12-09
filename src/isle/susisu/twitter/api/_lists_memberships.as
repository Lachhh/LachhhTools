package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _lists_memberships(
		tokenSet:TwitterTokenSet,
		userId:String=null,
		screenName:String=null,
		cursor:String="-1",
		filterToOwnedLists:Boolean=false
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
		if(cursor!="-1")
		{
			parameters["cursor"]=cursor;
		}
		parameters["filter_to_owned_lists"]=filterToOwnedLists?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.lists_MEMBERSHIPS,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}