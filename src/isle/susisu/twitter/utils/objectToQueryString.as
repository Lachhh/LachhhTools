package isle.susisu.twitter.utils
{
	
	public function objectToQueryString(obj:Object):String
	{
		var query:String="";
		for(var key:String in obj)
		{
			query+=key+"="+obj[key]+"&";
		}
		query=query.substr(0,query.length-1);
		return query;
	}
	
}