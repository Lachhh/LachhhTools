package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _statuses_update(
		tokenSet:TwitterTokenSet,
		status:String,
		inReplyToStatusId:String=null,
		latitude:String=null,
		longitude:String=null,
		placeId:String=null,
		displayCoordinates:Boolean=false,
		trimUser:Boolean=false
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["status"]=encodeText(status);
		if(inReplyToStatusId!=null)
		{
			parameters["in_reply_to_status_id"]=inReplyToStatusId;
		}
		if(latitude!=null)
		{
			parameters["lat"]=latitude;
		}
		if(longitude!=null)
		{
			parameters["long"]=longitude;
		}
		if(placeId!=null)
		{
			parameters["place_id"]=placeId;
		}
		parameters["display_coordinates"]=displayCoordinates?TRUE:FALSE;
		parameters["trim_user"]=trimUser?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_UPDATE,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}