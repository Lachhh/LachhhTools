package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _geo_reverseGeocode(
		tokenSet:TwitterTokenSet,
		latitude:String,
		longitude:String,
		accuracy:String=null,
		granularity:String=null,
		maxResults:int=0
	):TwitterRequest
	{
		var parameters:Object=new Object();
		parameters["lat"]=latitude;
		parameters["long"]=longitude;
		if(accuracy!=null)
		{
			parameters["accuracy"]=accuracy;
		}
		if(granularity!=null)
		{
			parameters["granularity"]=granularity;
		}
		if(maxResults>0)
		{
			parameters["max_results"]=maxResults.toString();
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.geo_REVERSE_GEOCODE,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}