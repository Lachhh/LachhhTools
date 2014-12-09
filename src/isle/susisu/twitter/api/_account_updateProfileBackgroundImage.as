package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import com.hurlant.util.Base64;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.MultipartFormData;
	
	public function _account_updateProfileBackgroundImage(
		tokenSet:TwitterTokenSet,
		image:ByteArray=null,
		tile:Boolean=true,
		useBackgroundImage:Boolean=true,
		includeEntities:Boolean=true,
		skipStatus:Boolean=true
	):TwitterRequest
	{
		//parameters
		var mfd:MultipartFormData=new MultipartFormData();
		if(image!=null)
		{
			mfd.addData("image",Base64.encodeByteArray(image));
		}
		mfd.addData("tile",tile?TRUE:FALSE);
		mfd.addData("use",useBackgroundImage?TRUE:FALSE);
		mfd.addData("include_entities",includeEntities?TRUE:FALSE);
		mfd.addData("skip_status",skipStatus?TRUE:FALSE);
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.account_UPDATE_PROFILE_BACKGROUND_IMAGE,URLRequestMethod.POST,mfd);
		
		return request;
	}
	
}