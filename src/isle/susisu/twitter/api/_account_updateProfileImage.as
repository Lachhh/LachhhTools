package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import com.hurlant.util.Base64;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.MultipartFormData;
	
	public function _account_updateProfileImage(
		tokenSet:TwitterTokenSet,
		image:ByteArray,
		includeEntities:Boolean=true,
		skipStatus:Boolean=true
	):TwitterRequest
	{
		//parameters
		var mfd:MultipartFormData=new MultipartFormData();
		mfd.addData("image",Base64.encodeByteArray(image));
		mfd.addData("include_entities",includeEntities?TRUE:FALSE);
		mfd.addData("skip_status",skipStatus?TRUE:FALSE);
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.account_UPDATE_PROFILE_IMAGE,URLRequestMethod.POST,mfd);
		
		return request;
	}
	
}