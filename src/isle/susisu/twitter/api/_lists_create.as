package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _lists_create(
		tokenSet:TwitterTokenSet,
		name:String,
		mode:String="public",
		description:String=null
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["name"]=encodeText(name);
		parameters["mode"]=mode;
		if(description!=null)
		{
			parameters["description"]=encodeText(description);
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.lists_CREATE,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}