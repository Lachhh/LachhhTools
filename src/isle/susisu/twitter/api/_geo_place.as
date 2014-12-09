package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _geo_place(
		tokenSet:TwitterTokenSet,
		name:String,
		containedWithin:String,
		token:String,
		latitude:String,
		longitude:String,
		streetAddress:String=null
	):TwitterRequest
	{
		var parameters:Object=new Object();
		parameters["name"]=encodeText(name);
		parameters["contained_within"]=containedWithin;
		parameters["token"]=token;
		parameters["lat"]=latitude;
		parameters["long"]=longitude;
		if(streetAddress!=null)
		{
			parameters["attribute:street_address"]=streetAddress;
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.geo_PLACE,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}