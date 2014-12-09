package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _lists_statuses(
		tokenSet:TwitterTokenSet,
		listId:String=null,
		slug:String=null,
		ownerId:String=null,
		ownerScreenName:String=null,
		count:int=0,
		sinceId:String=null,
		maxId:String=null,
		includeEntities:Boolean=true,
		includeRTs:Boolean=false
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(listId!=null)
		{
			parameters["list_id"]=listId;
		}
		if(slug!=null)
		{
			parameters["slug"]=encodeText(slug);
		}
		if(ownerId!=null)
		{
			parameters["owner_id"]=ownerId;
		}
		if(ownerScreenName!=null)
		{
			parameters["owner_screen_name"]=ownerScreenName;
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
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		parameters["include_rts"]=includeRTs?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.lists_STATUSES,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}