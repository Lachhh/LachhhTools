package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _lists_update(
		tokenSet:TwitterTokenSet,
		listId:String=null,
		slug:String=null,
		ownerId:String=null,
		ownerScreenName:String=null,
		name:String=null,
		mode:String="public",
		description:String=null
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
		if(name!=null)
		{
			parameters["name"]=encodeText(name);
		}
		parameters["mode"]=mode;
		if(description!=null)
		{
			parameters["description"]=encodeText(description);
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.lists_UPDATE,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}