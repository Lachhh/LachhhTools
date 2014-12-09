package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _blocks_list(
		tokenSet:TwitterTokenSet,
		cursor:String="-1",
		includeEntities:Boolean=true,
		skipStatus:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(cursor!="-1")
		{
			parameters["cursor"]=cursor;
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		parameters["skip_status"]=skipStatus?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.blocks_LIST,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}