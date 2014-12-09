package isle.susisu.twitter.api
{
	
	import flash.net.URLRequestMethod;
	
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.TwitterTokenSet;
	
	public function _account_updateProfileColors(
		tokenSet:TwitterTokenSet,
		profileBackgroundColor:int=-1,
		profileLinkColor:int=-1,
		profileSidebarBorderColor:int=-1,
		profileSidebarFillColor:int=-1,
		profileTextColor:int=-1,
		includeEntities:Boolean=true,
		skipStatus:Boolean=true
	):TwitterRequest
	{
		//parameters
		var parameters:Object=new Object();
		if(profileBackgroundColor>=0)
		{
			parameters["profile_background_color"]=profileBackgroundColor.toString(16).toUpperCase();
		}
		if(profileLinkColor>=0)
		{
			parameters["profile_link_color"]=profileLinkColor.toString(16).toUpperCase();
		}
		if(profileSidebarBorderColor>=0)
		{
			parameters["profile_sidebar_border_color"]=profileSidebarBorderColor.toString(16).toUpperCase();
		}
		if(profileSidebarFillColor>=0)
		{
			parameters["profile_sidebar_fill_color"]=profileSidebarFillColor.toString(16).toUpperCase();
		}
		if(profileTextColor>=0)
		{
			parameters["profile_text_color"]=profileTextColor.toString(16).toUpperCase();
		}
		parameters["include_entities"]=includeEntities?TRUE:FALSE;
		parameters["skip_status"]=skipStatus?TRUE:FALSE;
		//make request
		var request:TwitterRequest=new TwitterRequest(tokenSet,TwitterURL.account_UPDATE_PROFILE_COLORS,URLRequestMethod.POST,parameters);
		
		return request;
	}
	
}