package isle.susisu.twitter.utils
{
	
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function getOAuthParameters(tokenSet:TwitterTokenSet):Object
	{
		//parameters
		var parameters:Object=new Object();
		parameters["oauth_version"]="1.0";
		//timestamp should be seconds, not milliseconds!
		parameters["oauth_timestamp"]=Math.floor((new Date()).time/1000).toString();
		//random string
		parameters["oauth_nonce"]=makeNonce();
		//for Twitter, HMAC-SHA1
		parameters["oauth_signature_method"]="HMAC-SHA1";
		parameters["oauth_consumer_key"]=tokenSet.consumerKey;
		if(tokenSet.oauthToken!="")
		{
			parameters["oauth_token"]=tokenSet.oauthToken;
		}
		return parameters;
	}
	
}