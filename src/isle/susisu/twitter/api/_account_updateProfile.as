package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _account_updateProfile(
		tokenSet:TwitterTokenSet,
		name:String=null,
		url:String=null,
		location:String=null,
		description:String=null,
		includeEntities:Boolean=true,
		skipStatus:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(name!=null)
		{
			parameters["name"]=encodeText(name);
		}
		if(url!=null)
		{
			parameters["url"]=encodeText(url);
		}
		if(location!=null)
		{
			parameters["location"]=encodeText(location);
		}
		if(description!=null)
		{
			parameters["description"]=encodeText(description);
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		parameters["skip_status"]=skipStatus?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.account_UPDATE_PROFILE,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}