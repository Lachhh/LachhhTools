package isle.susisu.twitter.utils
{
	
	public function mergeObjects(...args):Object
	{
		var clone:Object=new Object();
		var len:int=args.length;
		for(var i:int=0;i<len;i++)
		{
			var obj:Object=args[i];
			for(var key:String in obj)
			{
				clone[key]=obj[key];
			}
		}
		return clone;
	}
	
}