package isle.susisu.twitter.utils
{
	
	public function objectToSortedQueryString(obj:Object):String
	{
		var query:String="";
		var arr:Array=new Array();
		for(var key:String in obj)
		{
			arr.push(key);
		}
		arr.sort();
		var len:int=arr.length;
		for(var i:int=0;i<len;i++)
		{
			query+=arr[i]+"="+obj[arr[i]];
			if(i<len-1)
			{
				query+="&";
			}
		}
		return query;
	}
	
}