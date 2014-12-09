package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _users_search(
		tokenSet:TwitterTokenSet,
		q:String,
		count:int=0,
		page:int=0,
		includeEntities:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["q"]=encodeText(q);
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
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.users_SEARCH,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}