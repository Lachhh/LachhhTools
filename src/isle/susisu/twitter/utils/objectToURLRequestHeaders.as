package isle.susisu.twitter.utils
{
	
	import flash.net.URLRequestHeader;
	
	public function objectToURLRequestHeaders(obj:Object):Array
	{
		var headers:Array=new Array();
		for(var key:String in obj)
		{
			headers.push(new URLRequestHeader(key,obj[key].toString()));
		}
		return headers;
	}
	
}