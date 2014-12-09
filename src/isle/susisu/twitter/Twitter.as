package isle.susisu.twitter
{
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import isle.susisu.twitter.api.*;
	import isle.susisu.twitter.events.TwitterErrorEvent;
	import isle.susisu.twitter.events.TwitterRequestEvent;
	
	public class Twitter extends Object
	{
		
		private var _consumerKey:String;
		private var _consumerKeySecret:String;
		private var _requestToken:String;
		private var _requestTokenSecret:String;
		private var _accessToken:String;
		private var _accessTokenSecret:String;
		private var _proxy:String;
		
		private var _defaultTokenSet:TwitterTokenSet;
		private var _requestTokenSet:TwitterTokenSet;
		private var _accessTokenSet:TwitterTokenSet;
		
		public function Twitter(consumerKey:String, consumerKeySecret:String, accessToken:String = "", accessTokenSecret:String = "", proxy:String = null)
		{
			_consumerKey = consumerKey;
			_consumerKeySecret = consumerKeySecret;
			_requestToken = "";
			_requestTokenSecret = "";
			_accessToken = accessToken;
			_accessTokenSecret = accessTokenSecret;
			_proxy = proxy;
			
			_defaultTokenSet = new TwitterTokenSet(_consumerKey, _consumerKeySecret, "", "");
			_requestTokenSet = null;
			if(_accessToken != "" || _accessTokenSecret != "")
			{
				_accessTokenSet = new TwitterTokenSet(_consumerKey, _consumerKeySecret, _accessToken, _accessTokenSecret);
			}
			else
			{
				_accessTokenSet = null;
			}
		}
		
		public function get consumerKey():String
		{
			return _consumerKey;
		}
		
		public function get consumerKeySecret():String
		{
			return _consumerKeySecret;
		}
		
		public function get requestToken():String
		{
			return _requestToken;
		}
		
		public function get requestTokenSecret():String
		{
			return _requestTokenSecret;
		}
		
		public function get accessToken():String
		{
			return _accessToken;
		}
		
		public function get accessTokenSecret():String
		{
			return _accessTokenSecret;
		}
		
		public function get proxy():String
		{
			return _proxy;
		}
		public function set proxy(value:String):void
		{
			_proxy = value;
		}
		
		public function get defaultTokenSet():TwitterTokenSet
		{
			return _defaultTokenSet;
		}
		
		public function get requestTokenSet():TwitterTokenSet
		{
			return _requestTokenSet;
		}
		
		public function get accessTokenSet():TwitterTokenSet
		{
			return _accessTokenSet;
		}
		
		public function getOAuthAuthorizeURL():String
		{
			return TwitterURL.oauth_AUTHORIZE + "?oauth_token=" + _requestToken;
		}
		
		public function account_getSettings(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_getSettings(_accessTokenSet);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_removeProfileBanner(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_removeProfileBanner(_accessTokenSet);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_settings(trendLocationWoeid:int = -1, sleepTimeEnabled:Boolean = false, startSleepTime:int = -1, endSleepTime:int = -1, timeZone:String = null, lang:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_settings(_accessTokenSet,
				trendLocationWoeid, sleepTimeEnabled, startSleepTime, endSleepTime, timeZone, lang);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_updateDeliveryDevice(device:String,includeEntities:Boolean=true,sendImmediate:Boolean=true):TwitterRequest
		{
			var request:TwitterRequest = _account_updateDeliveryDevice(_accessTokenSet,
				device,includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_updateProfile(name:String = null, url:String = null, location:String = null, description:String = null, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_updateProfile(_accessTokenSet,
				name, url, location, description, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_updateProfileBackgroundImage(image:ByteArray = null, tile:Boolean = true, useBackgroundImage:Boolean = true, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_updateProfileBackgroundImage(_accessTokenSet,
				image, tile, useBackgroundImage, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_updateProfileBanner(banner:ByteArray, width:int = -1, height:int = -1, offsetLeft:int = -1, offsetTop:int = -1, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_updateProfileBanner(_accessTokenSet,
				banner, width, height, offsetLeft, offsetTop);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_updateProfileColors(profileBackgroundColor:int = -1, profileLinkColor:int = -1, profileSidebarBorderColor:int = -1, profileSidebarFillColor:int = -1, profileTextColor:int = -1, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_updateProfileColors(_accessTokenSet,
				profileBackgroundColor, profileLinkColor, profileSidebarBorderColor, profileSidebarFillColor, profileTextColor, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_updateProfileImage(image:ByteArray, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_updateProfileImage(_accessTokenSet,
				image, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function account_verifyCredentials(includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _account_verifyCredentials(_accessTokenSet,
				includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function application_rateLimitStatus(resources:Array, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _application_rateLimitStatus(_accessTokenSet,
				resources);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function blocks_create(userId:String = null, screenName:String = null, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _blocks_create(_accessTokenSet,
				userId, screenName, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function blocks_destroy(userId:String = null, screenName:String = null, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _blocks_destroy(_accessTokenSet,
				userId, screenName, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function blocks_ids(cursor:String = "-1", sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _blocks_ids(_accessTokenSet,
				cursor);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function blocks_list(cursor:String = "-1", includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _blocks_list(_accessTokenSet,
				cursor,includeEntities,skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function directMessages(count:int = 0, sinceId:String = null, maxId:String = null, page:int = 0, includeEntities:Boolean = true, skipStatus:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest=_directMessages(_accessTokenSet,
				count, sinceId, maxId, page, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function directMessages_destroy(id:String, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _directMessages_destroy(_accessTokenSet,
				id, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function directMessages_new(text:String, userId:String = null, screenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _directMessages_new(_accessTokenSet,
				text, userId, screenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function directMessages_sent(count:int = 0, sinceId:String = null, maxId:String = null, page:int = 0, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _directMessages_sent(_accessTokenSet, 
				count, sinceId, maxId, page, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function directMessages_show(id:String,sendImmediate:Boolean=true):TwitterRequest
		{
			var request:TwitterRequest=_directMessages_show(_accessTokenSet,
				id);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function favorites_create(id:String, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest=_favorites_create(_accessTokenSet,
				id, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function favorites_destroy(id:String, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _favorites_destroy(_accessTokenSet,
				id, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function favorites_list(userId:String = null, screenName:String = null, count:int = 0, sinceId:String = null, maxId:String = null, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _favorites_list(_accessTokenSet,
				userId, screenName, count, sinceId, maxId, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function followers_ids(userId:String = null, screenName:String = null, cursor:String = "-1", sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _followers_ids(_accessTokenSet,
				userId, screenName, cursor);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function followers_list(userId:String = null, screenName:String = null, cursor:String = "-1", skipStatus:Boolean = true, includeUserEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _followers_list(_accessTokenSet,
				userId,  screenName,  cursor,  skipStatus,  includeUserEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friends_ids(userId:String = null, screenName:String = null, cursor:String = "-1", sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friends_ids(_accessTokenSet,
				userId, screenName, cursor);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friends_list(userId:String = null, screenName:String = null, cursor:String = "-1", skipStatus:Boolean = true, includeUserEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friends_list(_accessTokenSet,
				userId, screenName, cursor, skipStatus, includeUserEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friendships_create(userId:String = null, screenName:String = null, follow:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friendships_create(_accessTokenSet,
				userId, screenName, follow);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friendships_destroy(userId:String = null, screenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friendships_destroy(_accessTokenSet,
				userId, screenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friendships_incoming(cursor:String = "-1", sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friendships_incoming(_accessTokenSet,
				cursor);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friendships_lookup(userId:String = null, screenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friendships_lookup(_accessTokenSet,
				userId, screenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friendships_outgoing(cursor:String = "-1", sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friendships_outgoing(_accessTokenSet,
				cursor);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friendships_show(sourceId:String = null, sourceScreenName:String = null, targetId:String = null, targetScreenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friendships_show(_accessTokenSet,
				sourceId, sourceScreenName, targetId, targetScreenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function friendships_update(userId:String = null, screenName:String = null, device:Boolean = false, retweets:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _friendships_update(_accessTokenSet,
				userId, screenName, device, retweets);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function geo_id(placeId:String, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _geo_id(_accessTokenSet,
				placeId);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function geo_place(name:String, containedWithin:String, token:String, latitude:String, longitude:String, streetAddress:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _geo_place(_accessTokenSet,
				name, containedWithin, token, latitude, longitude, streetAddress);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function geo_reverseGeocode(latitude:String, longitude:String, accuracy:String = null, granularity:String = null, maxResults:int = 0, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _geo_reverseGeocode(_accessTokenSet,
				latitude, longitude, accuracy, granularity, maxResults);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function geo_search(latitude:String = null, longitude:String = null, query:String = null, ip:String = null, accuracy:String = null, granularity:String = null, containedWithin:String = null, streetAddress:String = null, maxResults:int = 0, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _geo_search(_accessTokenSet,
				latitude, longitude, query, ip, accuracy, granularity, containedWithin, streetAddress, maxResults);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function geo_similarPlaces(latitude:String, longitude:String, name:String, containedWithin:String = null, streetAddress:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _geo_similarPlaces(_accessTokenSet,
				latitude, longitude, name, containedWithin, streetAddress);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function help_configuration(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _help_configuration(_accessTokenSet);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function help_languages(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _help_languages(_accessTokenSet);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function help_privacy(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _help_privacy(_accessTokenSet);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function help_tos(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _help_tos(_accessTokenSet);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_create(name:String, mode:String = "public", description:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_create(_accessTokenSet,
				name, mode, description);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_destroy(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_destroy(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_list(userId:String = null, screenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_list(_accessTokenSet,
				userId, screenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_members(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, cursor:String = "-1", includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_members(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, cursor, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_members_create(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, userId:String = null, screenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_members_create(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, userId, screenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_members_createAll(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, userIds:Array = null, screenNames:Array = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_members_createAll(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, userIds, screenNames);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_members_destroy(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, userId:String = null, screenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_members_destroy(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, userId, screenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_members_destroyAll(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, userIds:Array = null, screenNames:Array = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_members_destroyAll(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, userIds, screenNames);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_members_show(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, userId:String = null, screenName:String = null, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_members_show(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, userId, screenName, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_memberships(userId:String = null, screenName:String = null, cursor:String = "-1", filterToOwnedLists:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_memberships(_accessTokenSet,
				userId, screenName, cursor, filterToOwnedLists);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_show(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_show(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_statuses(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, count:int = 0, sinceId:String = null, maxId:String = null, includeEntities:Boolean = true, includeRTs:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_statuses(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, count, sinceId, maxId, includeEntities, includeRTs);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_subscribers(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, cursor:String = "-1", includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_subscribers(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, cursor, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_subscribers_create(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_subscribers_create(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_subscribers_destroy(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_subscribers_destroy(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_subscribers_show(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, userId:String = null, screenName:String = null, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_subscribers_show(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, userId, screenName, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_subscriptions(userId:String = null, screenName:String = null, count:int = 0, cursor:String = "-1", sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_subscriptions(_accessTokenSet,
				userId, screenName, count, cursor);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function lists_update(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null, name:String = null, mode:String = "public", description:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _lists_update(_accessTokenSet,
				listId, slug, ownerId, ownerScreenName, name, mode, description);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function oauth_accessToken(verifier:String, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _oauth_accessToken(_requestTokenSet,
				verifier);
			request.proxy = _proxy;
			
			function onComplete(e:TwitterRequestEvent):void
			{
				request.removeEventListener(TwitterRequestEvent.COMPLETE, onComplete);
				request.removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onError);
				request.removeEventListener(TwitterErrorEvent.SERVER_ERROR, onError);
				request.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				request.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
				//get oauth_token and oauth_token_secret
				var res:URLVariables = new URLVariables(request.response);
				_accessToken = res.oauth_token.toString();
				_accessTokenSecret = res.oauth_token_secret.toString();
				_accessTokenSet = new TwitterTokenSet(_consumerKey, _consumerKeySecret, _accessToken, _accessTokenSecret);
			}
			function onError(e:Event):void
			{
				request.removeEventListener(TwitterRequestEvent.COMPLETE, onComplete);
				request.removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onError);
				request.removeEventListener(TwitterErrorEvent.SERVER_ERROR, onError);
				request.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				request.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			}
			request.addEventListener(TwitterRequestEvent.COMPLETE, onComplete);
			request.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onError);
			request.addEventListener(TwitterErrorEvent.SERVER_ERROR, onError);
			request.addEventListener(IOErrorEvent.IO_ERROR, onError);
			request.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function oauth_requestToken(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _oauth_requestToken(_defaultTokenSet);
			request.proxy = _proxy;
			
			function onComplete(e:TwitterRequestEvent):void
			{
				request.removeEventListener(TwitterRequestEvent.COMPLETE, onComplete);
				request.removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onError);
				request.removeEventListener(TwitterErrorEvent.SERVER_ERROR, onError);
				request.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				request.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
				//get oauth_token and oauth_token_secret
				var res:URLVariables = new URLVariables(request.response);
				_requestToken = res.oauth_token.toString();
				_requestTokenSecret = res.oauth_token_secret.toString();
				_requestTokenSet = new TwitterTokenSet(_consumerKey, _consumerKeySecret, _requestToken, _requestTokenSecret);
			}
			function onError(e:Event):void
			{
				request.removeEventListener(TwitterRequestEvent.COMPLETE, onComplete);
				request.removeEventListener(TwitterErrorEvent.CLIENT_ERROR, onError);
				request.removeEventListener(TwitterErrorEvent.SERVER_ERROR, onError);
				request.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				request.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			}
			request.addEventListener(TwitterRequestEvent.COMPLETE, onComplete);
			request.addEventListener(TwitterErrorEvent.CLIENT_ERROR, onError);
			request.addEventListener(TwitterErrorEvent.SERVER_ERROR, onError);
			request.addEventListener(IOErrorEvent.IO_ERROR, onError);
			request.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function savedSearches_create(query:String, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _savedSearches_create(_accessTokenSet,
				query);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function savedSearches_destroy(id:String, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _savedSearches_destroy(_accessTokenSet,
				id);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function savedSearches_list(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _savedSearches_list(_accessTokenSet);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function savedSearches_show(id:String, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _savedSearches_show(_accessTokenSet,
				id);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function search_tweets(q:String, geoCode:String = null, lang:String = null, locale:String = null, resultType:String = null, count:int = 0, until:String = null, sinceId:String = null, maxId:String = null, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _search_tweets(_accessTokenSet,
				q, geoCode, lang, locale, resultType, count, until, sinceId, maxId, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_destroy(id:String, trimUser:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_destroy(_accessTokenSet,
				id, trimUser);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_homeTimeline(count:int = 0, sinceId:String = null, maxId:String = null, trimUser:Boolean = false, excludeReplies:Boolean = false, contributorDetails:Boolean = false, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_homeTimeline(_accessTokenSet,
				count, sinceId, maxId, trimUser, excludeReplies, contributorDetails, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_mentionsTimeline(count:int = 0, sinceId:String = null, maxId:String = null, trimUser:Boolean = false, contributorDetails:Boolean = false, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_mentionsTimeline(_accessTokenSet,
				count, sinceId, maxId, trimUser, contributorDetails, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_oembed(id:String = null, url:String = null, related:Array = null, maxwidth:uint = 0, align:String = null, lang:String = null, hideMedia:Boolean = false, hideThread:Boolean = false, omitScript:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_oembed(_accessTokenSet,
				id, url, related, maxwidth, align, lang, hideMedia, hideThread, omitScript);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_retweet(id:String, trimUser:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_retweet(_accessTokenSet,
				id, trimUser);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_retweets(id:String, count:int = 0, trimUser:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_retweets(_accessTokenSet,
				id, count, trimUser);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_retweetsOfMe(count:int = 0, sinceId:String = null, maxId:String = null, trimUser:Boolean = false, includeEntities:Boolean = true, includeUserEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_retweetsOfMe(_accessTokenSet,
				count, sinceId, maxId, trimUser, includeEntities, includeUserEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_show(id:String, trimUser:Boolean = false, includeMyRetweet:Boolean = false, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_show(_accessTokenSet,
				id, trimUser, includeMyRetweet, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_update(status:String, inReplyToStatusId:String = null, latitude:String = null, longitude:String = null, placeId:String = null, displayCoordinates:Boolean = false, trimUser:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_update(_accessTokenSet,
				status, inReplyToStatusId, latitude, longitude, placeId, displayCoordinates, trimUser);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_updateWithMedia(status:String, media:ByteArray, possiblySensitive:Boolean = false, inReplyToStatusId:String = null, latitude:String = null, longitude:String = null, placeId:String = null, displayCoordinates:Boolean = false, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_updateWithMedia(_accessTokenSet,
				status, media, possiblySensitive, inReplyToStatusId, latitude, longitude, placeId, displayCoordinates);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function statuses_userTimeline(userId:String = null, screenName:String = null, count:int = 0, sinceId:String = null, maxId:String = null, excludeReplies:Boolean = false, contributorDetails:Boolean = false, includeRTs:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _statuses_userTimeline(_accessTokenSet,
				userId, screenName, count, sinceId, maxId, excludeReplies, contributorDetails, includeRTs);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function trends_available(sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _trends_available(_accessTokenSet);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function trends_closest(latitude:String, longitude:String, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _trends_closest(_accessTokenSet,
				latitude, longitude);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function trends_place(id:String, exclude:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _trends_place(_accessTokenSet,
				id, exclude);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function user(stallWarnings:Boolean = false, withParam:String = "user", replies:String = null, track:String = null, locations:String = null):TwitterStream
		{
			var stream:TwitterStream = _user(_accessTokenSet,
				stallWarnings, withParam, replies, track, locations);
			return stream;
		}
		
		public function users_contributees(userId:String = null, screenName:String = null, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_contributees(_accessTokenSet,
				userId, screenName, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_contributors(userId:String = null, screenName:String = null, includeEntities:Boolean = true, skipStatus:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_contributors(_accessTokenSet,
				userId, screenName, includeEntities, skipStatus);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_lookup(userIds:Array = null, screenNames:Array = null, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_lookup(_accessTokenSet,
				userIds, screenNames, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_profileBanner(userId:String = null, screenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_profileBanner(_accessTokenSet,
				userId, screenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_reportSpam(userId:String = null, screenName:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_reportSpam(_accessTokenSet,
				userId, screenName);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_search(q:String, count:int = 0, page:int = 0, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_search(_accessTokenSet,
				q, count, page, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_show(userId:String = null, screenName:String = null, includeEntities:Boolean = true, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_show(_accessTokenSet,
				userId, screenName, includeEntities);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_suggestions(lang:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_suggestions(_accessTokenSet,
				lang);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_suggestions_members(slug:String, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_suggestions_members(_accessTokenSet,
				slug);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
		public function users_suggestionsSlug(slug:String, lang:String = null, sendImmediate:Boolean = true):TwitterRequest
		{
			var request:TwitterRequest = _users_suggestionsSlug(_accessTokenSet,
				slug, lang);
			request.proxy = _proxy;
			if(sendImmediate)
			{
				request.send();
			}
			return request;
		}
		
	}
	
}