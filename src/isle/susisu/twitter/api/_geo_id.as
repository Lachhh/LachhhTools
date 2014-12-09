package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _geo_id(
		tokenSet:TwitterTokenSet,
		placeId:String
	):TwitterRequest
	{
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.geo_id__PLACE_ID.replace(":place_id",placeId),URLRequestMethod.GET);
		
		return request;
	}
	
}