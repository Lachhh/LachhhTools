package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _geo_similarPlaces(
		tokenSet:TwitterTokenSet,
		latitude:String,
		longitude:String,
		name:String,
		containedWithin:String=null,
		streetAddress:String=null
	):TwitterRequest
	{
		var parameters:Object=new Object();
		parameters["lat"]=latitude;
		parameters["long"]=longitude;
		parameters["name"]=encodeText(name);
		if(containedWithin!=null)
		{
			parameters["contained_within"]=containedWithin;
		}
		if(streetAddress!=null)
		{
			parameters["attribute:street_address"]=streetAddress;
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.geo_SIMILAR_PLACES,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}