package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	import isle.susisu.twitter.utils.encodeText;
	
	public function _search_tweets(
		tokenSet:TwitterTokenSet,
		q:String,
		geoCode:String=null,
		lang:String=null,
		locale:String=null,
		resultType:String=null,
		count:int=0,
		until:String=null,
		sinceId:String=null,
		maxId:String=null,
		includeEntities:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["q"]=encodeText(q);
		if(geoCode!=null){
			parameters["geo_code"]=geoCode;
		}
		if(lang!=null){
			parameters["lang"]=lang;
		}
		if(locale!=null){
			parameters["locale"]=locale;
		}
		if(resultType!=null){
			parameters["result_type"]=resultType;
		}
		if(count>0){
			parameters["count"]=count.toString();
		}
		if(until!=null){
			parameters["until"]=until;
		}
		if(sinceId!=null){
			parameters["since_id"]=sinceId;
		}
		if(maxId!=null){
			parameters["max_id"]=maxId;
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.search_TWEETS,URLRequestMethod.GET,parameters);
		
		return request;
	}
	
}