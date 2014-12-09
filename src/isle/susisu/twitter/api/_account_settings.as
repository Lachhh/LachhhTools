package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _account_settings(
		tokenSet:TwitterTokenSet,
		trendLocationWoeid:int=-1,
		sleepTimeEnabled:Boolean=false,
		startSleepTime:int=-1,
		endSleepTime:int=-1,
		timeZone:String=null,
		lang:String=null
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(trendLocationWoeid>=0){
			parameters["trend_location_woeid"]=trendLocationWoeid.toString();
		}
		parameters["sleep_time_enabled"]=sleepTimeEnabled?TRUE:FALSE;
		if(startSleepTime>=0){
			parameters["start_sleep_time"]=startSleepTime.toString();
		}
		if(endSleepTime>=0){
			parameters["end_sleep_time"]=endSleepTime.toString();
		}
		if(timeZone!=null){
			parameters["time_zone"]=timeZone;
		}
		if(lang!=null){
			parameters["lang"]=lang;
		}
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.account_SETTINGS,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}