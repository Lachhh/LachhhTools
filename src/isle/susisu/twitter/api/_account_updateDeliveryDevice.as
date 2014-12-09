package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _account_updateDeliveryDevice(
		tokenSet:TwitterTokenSet,
		device:String,
		includeEntities:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		parameters["device"]=device;
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.account_UPDATE_DELIVERY_DEVICE,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}