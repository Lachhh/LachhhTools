package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _lists_members_show(
		tokenSet:TwitterTokenSet,
		listId:String=null,
		slug:String=null,
		ownerId:String=null,
		ownerScreenName:String=null,
		userId:String=null,
		screenName:String=null,
		includeEntities:Boolean=true,
		skipStatus:Boolean=true
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
		if(userId!=null)
		{
			parameters["user_id"]=userId;
		}
		if(screenName!=null)
		{
			parameters["screen_name"]=screenName;
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		parameters["skip_status"]=skipStatus?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.lists_members_SHOW,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}