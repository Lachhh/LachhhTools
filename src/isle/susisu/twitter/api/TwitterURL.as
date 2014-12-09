package isle.susisu.twitter.api
{
	
	public class TwitterURL extends Object
	{
		
		public static const account_REMOVE_PROFILE_BANNER:String="https://api.twitter.com/1.1/account/remove_profile_banner.json";
		public static const account_SETTINGS:String="https://api.twitter.com/1.1/account/settings.json";
		public static const account_UPDATE_DELIVERY_DEVICE:String="https://api.twitter.com/1.1/account/update_delivery_device.json";
		public static const account_UPDATE_PROFILE:String="https://api.twitter.com/1.1/account/update_profile.json";
		public static const account_UPDATE_PROFILE_BACKGROUND_IMAGE:String="https://api.twitter.com/1.1/account/update_profile_background_image.json";
		public static const account_UPDATE_PROFILE_BANNER:String="https://api.twitter.com/1.1/account/update_profile_banner.json";
		public static const account_UPDATE_PROFILE_COLORS:String="https://api.twitter.com/1.1/account/update_profile_colors.json";
		public static const account_UPDATE_PROFILE_IMAGE:String="https://api.twitter.com/1.1/account/update_profile_image.json";
		public static const account_VERIFY_CREDENTIALS:String="https://api.twitter.com/1.1/account/verify_credentials.json";
		public static const application_RATE_LIMIT_STATUS:String="https://api.twitter.com/1.1/application/rate_limit_status.json";
		public static const blocks_CREATE:String="https://api.twitter.com/1.1/blocks/create.json";
		public static const blocks_DESTROY:String="https://api.twitter.com/1.1/blocks/destroy.json";
		public static const blocks_IDS:String="https://api.twitter.com/1.1/blocks/ids.json";
		public static const blocks_LIST:String="https://api.twitter.com/1.1/blocks/list.json";
		public static const DIRECT_MESSAGES:String="https://api.twitter.com/1.1/direct_messages.json";
		public static const directMessages_DESTROY:String="https://api.twitter.com/1.1/direct_messages/destroy.json";
		public static const directMessages_NEW:String="https://api.twitter.com/1.1/direct_messages/new.json";
		public static const directMessages_SENT:String="https://api.twitter.com/1.1/direct_messages/sent.json";
		public static const directMessages_SHOW:String="https://api.twitter.com/1.1/direct_messages/show.json";
		public static const favorites_CREATE:String="https://api.twitter.com/1.1/favorites/create.json";
		public static const favorites_DESTROY:String="https://api.twitter.com/1.1/favorites/destroy.json";
		public static const favorites_LIST:String="https://api.twitter.com/1.1/favorites/list.json";
		public static const followers_IDS:String="https://api.twitter.com/1.1/followers/ids.json";
		public static const followers_LIST:String="https://api.twitter.com/1.1/followers/list.json";
		public static const friends_IDS:String="https://api.twitter.com/1.1/friends/ids.json";
		public static const friends_LIST:String="https://api.twitter.com/1.1/friends/list.json";
		public static const friendships_CREATE:String="https://api.twitter.com/1.1/friendships/create.json";
		public static const friendships_DESTROY:String="https://api.twitter.com/1.1/friendships/destroy.json";
		public static const friendships_INCOMING:String="https://api.twitter.com/1.1/friendships/incoming.json";
		public static const friendships_LOOKUP:String="https://api.twitter.com/1.1/friendships/lookup.json";
		public static const friendships_OUTGOING:String="https://api.twitter.com/1.1/friendships/outgoing.json";
		public static const friendships_SHOW:String="https://api.twitter.com/1.1/friendships/show.json";
		public static const friendships_UPDATE:String="https://api.twitter.com/1.1/friendships/update.json";
		public static const geo_id__PLACE_ID:String="https://api.twitter.com/1.1/geo/id/:place_id.json";
		public static const geo_PLACE:String="https://api.twitter.com/1.1/geo/place.json";
		public static const geo_REVERSE_GEOCODE:String="http://api.twitter.com/1.1/geo/reverse_geocode.json";
		public static const geo_SEARCH:String="https://api.twitter.com/1.1/geo/search.json";
		public static const geo_SIMILAR_PLACES:String="https://api.twitter.com/1.1/geo/similar_places.json";
		public static const help_CONFIGURATION:String="https://api.twitter.com/1.1/help/configuration.json";
		public static const help_LANGUAGES:String="https://api.twitter.com/1.1/help/languages.json";
		public static const help_PRIVACY:String="https://api.twitter.com/1.1/help/privacy.json";
		public static const help_TOS:String="https://api.twitter.com/1.1/help/tos.json";
		public static const lists_CREATE:String="https://api.twitter.com/1.1/lists/create.json";
		public static const lists_DESTROY:String="https://api.twitter.com/1.1/lists/destroy.json";
		public static const lists_LIST:String="http://api.twitter.com/1.1/lists/list.json";
		public static const lists_MEMBERS:String="https://api.twitter.com/1.1/lists/members.json";
		public static const lists_members_CREATE:String="https://api.twitter.com/1.1/lists/members/create.json";
		public static const lists_members_CREATE_ALL:String="https://api.twitter.com/1.1/lists/members/create_all.json";
		public static const lists_members_DESTROY:String="https://api.twitter.com/1.1/lists/members/destroy.json";
		public static const lists_members_DESTROY_ALL:String="https://api.twitter.com/1.1/lists/members/destroy_all.json";
		public static const lists_members_SHOW:String="https://api.twitter.com/1.1/lists/members/show.json";
		public static const lists_MEMBERSHIPS:String="https://api.twitter.com/1.1/lists/memberships.json";
		public static const lists_SHOW:String="https://api.twitter.com/1.1/lists/show.json";
		public static const lists_STATUSES:String="https://api.twitter.com/1.1/lists/statuses.json";
		public static const lists_SUBSCRIBERS:String="https://api.twitter.com/1.1/lists/subscribers.json";
		public static const lists_subscribers_CREATE:String="https://api.twitter.com/1.1/lists/subscribers/create.json";
		public static const lists_subscribers_DESTROY:String="https://api.twitter.com/1.1/lists/subscribers/destroy.json";
		public static const lists_subscribers_SHOW:String="https://api.twitter.com/1.1/lists/subscribers/show.json";
		public static const lists_SUBSCRIPTIONS:String="https://api.twitter.com/1.1/lists/subscriptions.json";
		public static const lists_UPDATE:String="https://api.twitter.com/1.1/lists/update.json";
		public static const oauth_ACCESS_TOKEN:String="https://api.twitter.com/oauth/access_token";
		//public static const oauth_AUTHENTICATE:String="https://api.twitter.com/oauth/authenticate";
		public static const oauth_AUTHORIZE:String="https://api.twitter.com/oauth/authorize";
		public static const oauth_REQUEST_TOKEN:String="https://api.twitter.com/oauth/request_token";
		public static const savedSearches_CREATE:String="https://api.twitter.com/1.1/saved_searches/create.json";
		public static const savedSearches_destroy__ID:String="https://api.twitter.com/1.1/saved_searches/destroy/:id.json";
		public static const savedSearches_LIST:String="https://api.twitter.com/1.1/saved_searches/list.json";
		public static const savedSearches_show__ID:String="https://api.twitter.com/1.1/saved_searches/show/:id.json";
		public static const search_TWEETS:String="https://api.twitter.com/1.1/search/tweets.json";
		//public static const SITE:String="https://sitestream.twitter.com/1.1/site.json";
		public static const statuses_destroy__ID:String="https://api.twitter.com/1.1/statuses/destroy/:id.json";
		//public static const statuses_FILTER:String="https://stream.twitter.com/1.1/statuses/filter.json";
		//public static const statuses_FIREHOSE:String="https://stream.twitter.com/1.1/statuses/firehose.json";
		public static const statuses_HOME_TIMELINE:String="https://api.twitter.com/1.1/statuses/home_timeline.json";
		public static const statuses_MENTIONS_TIMELINE:String="https://api.twitter.com/1.1/statuses/mentions_timeline.json";
		public static const statuses_OEMBED:String="https://api.twitter.com/1.1/statuses/oembed.json";
		public static const statuses_retweet__ID:String="https://api.twitter.com/1.1/statuses/retweet/:id.json";
		public static const statuses_retweets__ID:String="https://api.twitter.com/1.1/statuses/retweets/:id.json";
		public static const statuses_RETWEETS_OF_ME:String="https://api.twitter.com/1.1/statuses/retweets_of_me.json";
		//public static const statuses_SAMPLE:String="https://stream.twitter.com/1.1/statuses/sample.json";
		public static const statuses_SHOW:String="https://api.twitter.com/1.1/statuses/show.json";
		public static const statuses_UPDATE:String="https://api.twitter.com/1.1/statuses/update.json";
		public static const statuses_UPDATE_WITH_MEDIA:String="https://api.twitter.com/1.1/statuses/update_with_media.json";
		public static const statuses_USER_TIMELINE:String="https://api.twitter.com/1.1/statuses/user_timeline.json";
		public static const trends_AVAILABLE:String="https://api.twitter.com/1.1/trends/available.json";
		public static const trends_CLOSEST:String="https://api.twitter.com/1.1/trends/closest.json";
		public static const trends_PLACE:String="https://api.twitter.com/1.1/trends/place.json";
		public static const USER:String="https://userstream.twitter.com/1.1/user.json";
		public static const users_CONTRIBUTEES:String="https://api.twitter.com/1.1/users/contributees.json";
		public static const users_CONTRIBUTORS:String="https://api.twitter.com/1.1/users/contributors.json";
		public static const users_LOOKUP:String="https://api.twitter.com/1.1/users/lookup.json";
		public static const users_PROFILE_BANNER:String="https://api.twitter.com/1.1/users/profile_banner.json";
		public static const users_REPORT_SPAM:String="https://api.twitter.com/1.1/users/report_spam.json";
		public static const users_SEARCH:String="https://api.twitter.com/1.1/users/search.json";
		public static const users_SHOW:String="https://api.twitter.com/1.1/users/show.json";
		public static const users_SUGGESTIONS:String="http://api.twitter.com/1.1/users/suggestions.json";
		public static const users_suggestions__SLUG:String="http://api.twitter.com/1.1/users/suggestions/:slug.json";
		public static const users_suggestions__slug_MEMBERS:String="http://api.twitter.com/1.1/users/suggestions/:slug/members.json";
		
		public function TwitterURL()
		{
			
		}
		
	}
	
}