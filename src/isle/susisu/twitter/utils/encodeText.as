package isle.susisu.twitter.utils
{
	
	public function encodeText(text:String):String
	{
		var encodedText:String=encodeURIComponent(text)
			.replace(/\!/g,"%21")
			.replace(/\'/g,"%27")
			.replace(/\(/g,"%28")
			.replace(/\)/g,"%29")
			.replace(/\*/g,"%2A");
		return encodedText;
	}
	
}
		