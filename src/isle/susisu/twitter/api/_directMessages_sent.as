package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _directMessages_sent(
		tokenSet:TwitterTokenSet,
		count:int=0,
		sinceId:String=null,
		maxId:String=null,
		page:int=0,
		includeEntities:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(sinceId!=null)
		{
			parameters["since_id"]=sinceId;
		}
		if(maxId!=null)
		{
			parameters["max_id"]=maxId;
		}
		if(count>0)
		{
			parameters["count"]=count.toString();
		}
		if(page>0)
		{
			parameters["page"]=page.toString();
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.directMessages_SENT,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}