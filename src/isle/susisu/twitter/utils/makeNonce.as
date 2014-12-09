package isle.susisu.twitter.utils
{
	
	public function makeNonce(length:uint=16):String
	{
		var strLen:int=STRING_SEQUENCE.length;
		var nonce:String="";
		for(var i:int=0;i<length;i++)
		{
			nonce+=STRING_SEQUENCE.charAt(Math.floor(Math.random()*strLen));
		}
		return nonce;
	}
	
}

const STRING_SEQUENCE:String="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";