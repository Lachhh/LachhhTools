package isle.susisu.twitter.utils
{
	
	import flash.net.URLRequestHeader;
	
	public function makeAuthorizationHeader(parameters:Object):URLRequestHeader
	{
		var header:URLRequestHeader=new URLRequestHeader("Authorization");
		var value:String="OAuth ";
		for(var key:String in parameters)
		{
			value+=key+"=\""+parameters[key]+"\",";
		}
		value=value.substr(0,value.length-1);
		header.value=value;
		
		return header;
	}
	
}
		