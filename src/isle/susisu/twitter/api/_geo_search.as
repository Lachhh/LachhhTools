package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _geo_search(
		tokenSet:TwitterTokenSet,
		latitude:String=null,
		longitude:String=null,
		query:String=null,
		ip:String=null,
		accuracy:String=null,
		granularity:String=null,
		containedWithin:String=null,
		streetAddress:String=null,
		maxResults:int=0
	):TwitterRequest
	{
		var parameters:Object=new Object();
		if(latitude!=null)
		{
			parameters["lat"]=latitude;
		}
		if(longitude!=null)
		{
			parameters["long"]=longitude;
		}
		if(query!=null)
		{
			parameters["query"]=encodeText(query);
		}
		if(ip!=null)
		{
			parameters["ip"]=ip;
		}
		if(accuracy!=null)
		{
			parameters["accuracy"]=accuracy;
		}
		if(granularity!=null)
		{
			parameters["granularity"]=granularity;
		}
		if(containedWithin!=null)
		{
			parameters["contained_within"]=containedWithin;
		}
		if(streetAddress!=null)
		{
			parameters["attribute:street_address"]=streetAddress;
		}
		if(maxResults>0)
		{
			parameters["max_results"]=maxResults.toString();
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.geo_SEARCH,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}