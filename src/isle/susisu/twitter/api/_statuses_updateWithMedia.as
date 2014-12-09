package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.MultipartFormData;
	
	public function _statuses_updateWithMedia(
		tokenSet:TwitterTokenSet,
		status:String,
		media:ByteArray,
		possiblySensitive:Boolean=false,
		inReplyToStatusId:String=null,
		latitude:String=null,
		longitude:String=null,
		placeId:String=null,
		displayCoordinates:Boolean=false
	):TwitterRequest
	{
		//parameters
		var mfd:MultipartFormData=new MultipartFormData();
		mfd.addData("status",status);
		mfd.addData("media[]",media);
		mfd.addData("possibly_sensitive",possiblySensitive);
		if(inReplyToStatusId!=null)
		{
			mfd.addData("in_reply_to_status_id",inReplyToStatusId);
		}
		if(latitude!=null)
		{
			mfd.addData("lat",latitude);
		}
		if(longitude!=null)
		{
			mfd.addData("long",longitude);
		}
		if(placeId!=null)
		{
			mfd.addData("place_id",placeId);
		}
		mfd.addData("display_coordinates",displayCoordinates?TRUE:FALSE);
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_UPDATE_WITH_MEDIA,URLRequestMethod.POST,mfd);
		
		return request;
	}
	
}