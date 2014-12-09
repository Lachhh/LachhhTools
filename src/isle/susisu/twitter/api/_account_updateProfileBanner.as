package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import com.hurlant.util.Base64;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.MultipartFormData;
	
	public function _account_updateProfileBanner(
		tokenSet:TwitterTokenSet,
		banner:ByteArray,
		width:int=-1,
		height:int=-1,
		offsetLeft:int=-1,
		offsetTop:int=-1
	):TwitterRequest
	{
		//parameters
		var mfd:MultipartFormData=new MultipartFormData();
		mfd.addData("banner",Base64.encodeByteArray(banner));
		if(width>=0)
		{
			mfd.addData("width",width.toString());
		}
		if(height>=0)
		{
			mfd.addData("height",height.toString());
		}
		if(offsetLeft>=0)
		{
			mfd.addData("offset_left",offsetLeft.toString());
		}
		if(offsetTop>=0)
		{
			mfd.addData("offset_top",offsetTop.toString());
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.account_UPDATE_PROFILE_BANNER,URLRequestMethod.POST,mfd);
		
		return request;
	}
	
}