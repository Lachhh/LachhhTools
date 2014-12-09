package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _directMessages(
		tokenSet:TwitterTokenSet,
		count:int=0,
		sinceId:String=null,
		maxId:String=null,
		page:int=0,
		includeEntities:Boolean=true,
		skipStatus:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object
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
		if(page>0)
		{
			parameters["page"]=page.toString();
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		parameters["skip_status"]=skipStatus?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.DIRECT_MESSAGES,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}