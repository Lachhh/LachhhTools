package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _statuses_oembed(
		tokenSet:TwitterTokenSet,
		id:String=null,
		url:String=null,
		related:Array=null,
		maxwidth:uint=0,
		align:String=null,
		lang:String=null,
		hideMedia:Boolean=false,
		hideThread:Boolean=false,
		omitScript:Boolean=false
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(id!=null)
		{
			parameters["id"]=id;
		}
		if(url!=null)
		{
			parameters["url"]=encodeText(url);
		}
		if(related!=null)
		{
			parameters["related"]=encodeText(related.join(","));
		}
		if(maxwidth>0)
		{
			parameters["maxwidth"]=maxwidth.toString();
		}
		if(align!=null)
		{
			parameters["align"]=align;
		}
		if(lang!=null)
		{
			parameters["lang"]=lang;
		}
		parameters["hide_media"]=hideMedia?TRUE:FALSE;
		parameters["hide_thread"]=hideThread?TRUE:FALSE;
		parameters["omit_script"]=omitScript?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.statuses_OEMBED,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}