package isle.susisu.twitter.utils
{
	
	import flash.utils.ByteArray;
	
	import com.hurlant.util.Base64;
	
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function makeOAuthSignature(tokenSet:TwitterTokenSet,base:String):String
	{
		var key:ByteArray=new ByteArray();
		key.writeUTFBytes(tokenSet.consumerKeySecret+"&"+tokenSet.oauthTokenSecret);
		var data:ByteArray=new ByteArray();
		data.writeUTFBytes(base);
		return Base64.encodeByteArray(hmac.compute(key,data));
	}
		
}

import com.hurlant.crypto.hash.HMAC;
import com.hurlant.crypto.hash.SHA1;
var hmac:HMAC=new HMAC(new SHA1());