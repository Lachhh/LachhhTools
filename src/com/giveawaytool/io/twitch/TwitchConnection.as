package com.giveawaytool.io.twitch {
	import playerio.Message;

	import com.giveawaytool.components.LogicSendToWidget;
	import com.giveawaytool.components.LogicTwitchChat;
	import com.giveawaytool.components.TwitchRequestMods;
	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.giveawaytool.io.playerio.MetaServerProgress;
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.ui.UI_PopUp;
	import com.giveawaytool.ui.views.MetaFollowerList;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.VersionInfoDONTSTREAMTHIS;
	import com.lachhh.utils.Utils;

	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class TwitchConnection {
		static public var instance:TwitchConnection;
		public var accessToken : String ;
		
		private var htmlLoader : HTMLLoader;
		private var windowOptions : NativeWindowInitOptions;
		public var onConnect:Callback;
		public var onConnectError : Callback;
		public var connectErrorMsg : String = "";
		public var onLogout : Callback;
		public var closeOnNext:Boolean = false;
		public var isAdminConnect:Boolean = false;
		
		
		public var listOfMods:Array = new Array();
		public var listOfModsLowerCase:Array = new Array();
		public var listOfViewers:Array = new Array();
		public var onFetchViewers : Callback;
		
		public var isLoggedIn:Boolean = false;
		private var username:String = "";
		private var userId:String = "";
		
		public var listOfSubs : MetaSubscribersList = new MetaSubscribersList();
		public var followersData : MetaFollowerList = new MetaFollowerList();
		public var channelData : MetaTwitchChannelData = new MetaTwitchChannelData();
		public var isLive : Boolean = false;
		private var authCode : String;

		public function TwitchConnection(pIsAdmin : Boolean) {
			accessToken = "";
			isAdminConnect = pIsAdmin;
		}
		
		public function clear():void {
			accessToken = "";
			listOfSubs = new MetaSubscribersList();
			channelData = new MetaTwitchChannelData();
			followersData = new MetaFollowerList();
			listOfMods = new Array();
			listOfViewers = new Array();
			username = "";
			userId = "";
			isLoggedIn = false;
		}
		
		public function connect():void {
			if(accessToken == "") {
				connectStep1FetchAccessToken();
			} else {
				connectStep2FetchUsername();
			}
		}
		
		public function connectStep1FetchAccessToken():void {
			UI_PopUp.createOkOnly("A webpage will open, please authorize LachhhTools and come back here!", null);
			UI_Menu.instance.logicNotification.logicSendToWidgetAuth.setModelForTwitch();
			Utils.navigateToURLAndRecord(getConnectURL());
		}
		
		public function logout(c:Callback):void {
			windowOptions = new NativeWindowInitOptions();
			windowOptions.type = NativeWindowType.UTILITY;
			windowOptions.systemChrome = NativeWindowSystemChrome.ALTERNATE;
			windowOptions.transparent = false;
			windowOptions.resizable = true;
			windowOptions.minimizable = false;
			
			windowOptions.renderMode = NativeWindowRenderMode.GPU;	
			
			
			htmlLoader = HTMLLoader.createRootWindow(  true, windowOptions, false, new Rectangle( 610, 78, 780, 680) );
			//htmlLoader.paintsDefaultBackground = false;
			
			htmlLoader.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
			//htmlLoader.addEventListener(Event.COMPLETE, onComplete_htmlLoader);
			
			htmlLoader.load(new URLRequest("http://twitch.tv/logout"));
			onLogout = c;
		}
				

	
		
		private function onLocationChange(event : LocationChangeEvent) : void {
			trace("onLocationChange : " + event.location);
			
			var newUrl:String = event.location;
			var str:String = "www.lachhhAndFriends.com";
			var str2:String = "https://passport.twitch.tv/authentications/new";
			var result:String = event.toString();
			
			if((newUrl.indexOf(str) == 0)) {
				if(newUrl.indexOf("#access_token=") != -1) {
					var a:Array = newUrl.split("#access_token=");
					var str1:String = a[1];
					var a2:Array = str1.split("&");
					accessToken = a2[0];
					//trace(accessToken) ;
					onStep1Done();
				} else {
					//if(onConnectError) onConnectError.call();
				}
				
				htmlLoader.stage.nativeWindow.close();
					 
			} else if(newUrl == "http://twitch.tv/logout") {
				closeOnNext = true;
			} else if(closeOnNext) {
				htmlLoader.stage.nativeWindow.close();
				closeOnNext = false;
				
				clear();
				
				if(onLogout) onLogout.call();
				
			}	
		}
		
		public function showCommercial(onSuccess:Callback, onError:Callback):TwitchRequestCommercial {
			var req:TwitchRequestCommercial = new TwitchRequestCommercial(this);
			req.onSuccessCallback = onSuccess;
			req.onErrorCallback = onError;
			req.showCommercial();
			return req;
		}
		
		public function fetchViewers(channelName:String, onFetch:Callback):void {
			listOfViewers = new Array();
			
			
		   var url:String = "https://tmi.twitch.tv/group/user/" + channelName.toLocaleLowerCase() + "/chatters";
		   var request:URLRequest = new URLRequest(url);
		   var loader:URLLoader = new URLLoader();
		   onFetchViewers = onFetch;
		   loader.addEventListener(Event.COMPLETE, onViewersLoaded);
		   connectErrorMsg = "Problem fetching Viewers";
		   loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorConnectOnTwitch);
		   
		   loader.load(request);
		}

		private function onErrorConnectOnTwitch(event : Event) : void {
			trace(event);
			UI_PopUp.closeAllPopups();
			if(onConnectError) {
				onConnectError.call();
			}
		}
	  
	 	 private function onViewersLoaded(event:Event) : void {
		    var loader:URLLoader = URLLoader(event.target);
		    var obj:Object = JSON.parse(loader.data);
		    var arrayOfNames:Array = obj.chatters.viewers as Array;
			
			listOfViewers = arrayOfNames.concat(listOfMods);
			removeNameFromList(listOfViewers, getNameOfAccount());
			if(onFetchViewers) onFetchViewers.call();
	 	 }
		 
		static public function removeNameFromList(list:Array, name:String):void {
			for (var i : int = 0; i < list.length; i++) {
				var crnt:String = list[i];
				if(crnt.toLowerCase() == name.toLowerCase()) {
					list.splice(i, 1);
					return ;
				}
			}
		}
		
		public function isSubscriber(name:String):Boolean {
			var lowerCaseName:String = name.toLowerCase();
			for (var i : int = 0; i < listOfSubs.subscribers.length; i++) {
				var subName:MetaSubscriber = listOfSubs.subscribers[i];
				if(subName.nameInLowerCase == lowerCaseName) return true;
			}
			return false;
		}
		
		public function isModerator(name:String):Boolean {
			var nameInLowerCase:String = name.toLowerCase();
			for (var i : int = 0; i < listOfModsLowerCase.length; i++) {
				var modName:String = listOfModsLowerCase[i];
				if(modName == nameInLowerCase) return true;
			}
			return (listOfMods.indexOf(name) != -1);
		}
		
		public function getNumSub():int {
			return listOfSubs.subscribers.length;
		}
		
		public function getNumViewers():int {
			return listOfViewers.length ;
		}
		
		public function getConnectURL():String {
			var redirect:String = VersionInfoDONTSTREAMTHIS.TWITCH_REDIRECT_URI;
			//var url:String = "https://api.twitch.tv/kraken/oauth2/authorize?response_type=code&api_version=5&client_id=" + VersionInfoDONTSTREAMTHIS.TWITCH_CLIENT_ID + "&redirect_uri=" + redirect + "&force_verify=true&scope=user_read";
			
			//https://id.twitch.tv/oauth2/authorize
    /*?client_id=<your client ID>
    &redirect_uri=<your registered redirect URI>
    &response_type=<type>
    &scope=<space-separated list of scopes>*/
			var url:String = "https://id.twitch.tv/oauth2/authorize?response_type=code&client_id=" + VersionInfoDONTSTREAMTHIS.TWITCH_CLIENT_ID + "&redirect_uri=" + redirect + "&force_verify=true&scope=user_read";
			url = url + "+channel_commercial";
			url = url + "+chat_login";
			url = url + "+user_subscriptions";
			if(isAdminConnect) url = url + "+channel_subscriptions";			 
			return url;
		}
		

		
		protected function onStep1Done():void {
			connectStep2FetchUsername();
		}

		public function setCodeFromWebSocket(authCode : String) : void {
			if(isLoggedIn) return;
			this.authCode = authCode;
			MetaServerProgress.instance.getTwitchAccessToken(authCode, new Callback(onAuthCodeSendSuccess, this, null), new Callback(onAuthCodeSendError, this, null));
		}
		
		private function onAuthCodeSendSuccess() : void {
			//UI_Menu.instance.logicNotification.logicSendToWidgetAuth.sendSuccessMsg();
			var msg : Message = PlayerIOLachhhRPGController.getInstance().myPublicConnection.connectionGameRoom.getTwitchTokenSuccess.msg;
			accessToken = msg.getString(0);
			if(accessToken != null) {
				onStep1Done();
			} else {
				onAuthCodeSendError();
			}
		}
		
		private function onAuthCodeSendError() : void {
			UI_PopUp.closeAllPopups();
			if(onConnectError) onConnectError.call();
		}
		
		
		function httpStatusHandler( e:HTTPStatusEvent ):void {
			trace("httpStatusHandler:" + e.status + "/"+  e.responseURL + "/" + e.type);
		}
		function securityErrorHandler( e:SecurityErrorEvent ):void {
			trace("securityErrorHandler:" + e);
		}
		
		public function isConnected():Boolean {
			return accessToken != ""; 
		}
		
		public function connectStep2FetchUsername():void {
			var url:String = "https://api.twitch.tv/helix/users?scope=user_read";
			var loader:URLLoader = new URLLoader() ;
			var headers :Array = getHeaders();
			 
			var request:URLRequest = new URLRequest(url);
			request.requestHeaders = headers;
			loader.load(request);
			connectErrorMsg = "Problem fetching Twitch username";
			loader.addEventListener(Event.COMPLETE, onFetchUsername);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorConnectOnTwitch);
		}

		private function onFetchUsername(event : Event) : void {
			var rawData:String = event.target.data;
			
			channelData.decode(rawData);
			
			/*var isValid:Boolean = token["valid"];
			if(!isValid) {
				connectErrorMsg = "Looks like there a problem with twitch,  valid=false.";
				onErrorConnectOnTwitch(null);
				return ;
			}*/
			
			username = channelData.name;
			userId = channelData.channedId;
			isLoggedIn = true;
			
			checkIfIsLive();
			
			
			if(isAdminConnect) {
				//checkIfPartnered();
				
				refreshSub(onConnect, onConnect);	
			} else {
				if(onConnect) onConnect.call();
			}
		}
		
		
		public function checkIfIsLive():void  {
			var url:String = "https://api.twitch.tv/helix/streams?user_id=" + getAccountId() ;
			//var url:String = "https://api.twitch.tv/helix/streams?user_login=" ;
			
			var loader:URLLoader = new URLLoader() ;
			var request : URLRequest = new URLRequest(); 
			var headers :Array = getHeaders();
			request.requestHeaders = headers;
			request.method = URLRequestMethod.GET; 
			request.url = url;
			loader.load(request);
			connectErrorMsg = "Problem looking if is live";
			loader.addEventListener(Event.COMPLETE, onCheckIfIsLive);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorConnectOnTwitch);
		}

		private function onCheckIfIsLive(event : Event) : void {
			var rawData:String = event.target.data;
			var d:Dictionary = DataManager.stringToDictionnary(rawData);
			var data = d["data"];
			if(data == null) return;
			isLive = (data[0] != null); 
			
		}
		
		/*private function checkIfPartnered():void  {
			var url:String = "https://api.twitch.tv/helix/channels/" + getAccountId() ;
			var loader:URLLoader = new URLLoader() ;
			var request : URLRequest = new URLRequest(); 
			var headers :Array = getHeaders();
			request.requestHeaders = headers;
			request.method = URLRequestMethod.GET; 
			request.url = url;
			loader.load(request);
			connectErrorMsg = "Problem looking if you're partnered";
			loader.addEventListener(Event.COMPLETE, onCheckIfPartner);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorConnectOnTwitch);
		}*/
		
		public function getHeaders():Array {
			var result :Array = [
			new URLRequestHeader("Authorization",  "Bearer " + accessToken), 
			new URLRequestHeader("Client-ID",  VersionInfoDONTSTREAMTHIS.TWITCH_CLIENT_ID)];
			return result;
		}

		/*private function onCheckIfPartner(event : Event) : void {
			var rawData:String = event.target.data;
			
			channelData.decode(rawData);
			
			if(channelData.isPartner) {
				refreshSub(onConnect, onConnect);
			} else {
				if(onConnect) onConnect.call();
			}
		}*/
		
		
		
		public function refreshSub(onSuccess : Callback, onError : Callback) : void {
			var req:TwitchRequestSub = new TwitchRequestSub(this);
			req.onConnectCallback = new Callback(onSubSuccess, this, [req, onSuccess]);
			req.onErrorCallback = new Callback(onErrorFetchSub, this, [onSuccess, onError]);
			req.fetchListOfSubsAdmin();
		}
		
		private function onErrorFetchSub(cSuccess:Callback, cError:Callback):void {
			//UI_PopUp.createYesNo("We could not fetch your subs, wanna continue anyway?", cSuccess, cError);
			if(cError) cError.call();
		}
		
		public function refreshMods(logicChat:LogicTwitchChat, onSuccess : Callback, onError : Callback) : void {
			if(!TwitchConnection.isLoggedIn()) {
				if(onError) onError.call();
				return;
			}
			
			var req:TwitchRequestMods = new TwitchRequestMods(logicChat);
			req.onSuccessCallback = new Callback(onModSuccess, this, [req, onSuccess]);
			req.onErrorCallback = onError;
			req.fetchListOfMods();
		}
		
		public function refreshFollowers(onSuccess : Callback, onError : Callback) : void {
			var req:TwitchRequestFollower = new TwitchRequestFollower(this);
			req.onSuccessCallback = new Callback(onFollowersSuccess, this, [req, onSuccess]);
			req.onErrorCallback = onError;
			req.fetchLast100Followers();
		}
		
		private function onModSuccess(req:TwitchRequestMods, callback:Callback) : void {
			listOfMods = req.listOfMods;
			listOfModsLowerCase = Utils.copyStringArrayInLowerCase(listOfMods);
			if(callback) callback.call();
		}
		
		private function onSubSuccess(req:TwitchRequestSub, callback:Callback) : void {
			listOfSubs = req.getListOfSub();
			if(callback) callback.call();
		}
		
		private function onFollowersSuccess(req:TwitchRequestFollower, callback:Callback) : void {
			followersData = req.metaDataReceived;
			if(callback) callback.call();
		}
		
		public function isLachhhAndFriends():Boolean {
			if(!TwitchConnection.isLoggedIn()) return false;
			var usernameLowerCase:String = username.toLocaleLowerCase();
            if (usernameLowerCase == "lachhhandfriends") return true;
			if (usernameLowerCase == "lachhh") return true;
            return false;
		}
		
		public function isUserAmemberOfKOTS():Boolean {
			if(!TwitchConnection.isLoggedIn()) return false;
			var usernameLowerCase:String = username.toLocaleLowerCase();
			//if (usernameLowerCase == "twitchplayszombidle") return true;
            if (usernameLowerCase == "lachhhandfriends") return true;
            if (usernameLowerCase == "kojaktsl") return true;
            if (usernameLowerCase == "weallplaycast") return true;
            //if (usernameLowerCase == "slickentertainmentinc") return true;
            //if (usernameLowerCase == "brawlhalla") return true;
			if (usernameLowerCase == "lachhh") return true;
			if (usernameLowerCase == "80pgaming") return true;
			if (usernameLowerCase == "hiimmikegaming") return true;
			if (usernameLowerCase == "jacklifear") return true;
			if (usernameLowerCase == "smokaloke") return true;
			
            return false;
        }
		
		public function removeNonSubFromList(outputName:Array):Array {
			for (var i : int = 0; i < outputName.length; i++) {
				var name:String = outputName[i];
				if(!isSubscriber(name)) {
					outputName.splice(i, 1);
					i--;
				}
			}
			return outputName;
		}
		
		static public function getNameOfAccount():String {
			if(instance == null) return "";
			if(!isLoggedIn()) return "";							
			return instance.username;
		}
		
		static public function getAccountId():String {
			if(instance == null) return "";
			if(!isLoggedIn()) return "";							
			return instance.userId;
		}
		
		static public function getNameOfAccountWithTwitchPrefix():String {
			if(instance == null) return "";
			if(!isLoggedIn()) return "";							
			return "twitch_" + instance.username;
		}

		public function getUserId() : String {
			return "";
		}

		public function getAuthToken() : String {
			return accessToken;
		}

		public function get connected() : Boolean {
			return isLoggedIn;
		}

		public function get loggedIn() : Boolean {
			return isLoggedIn;
		}

		public function get nameOfSystem() : String {
			return "Twitch";
		}

		public static function isLoggedIn() : Boolean {
			if(instance == null) return false;
			return instance.isLoggedIn;
		}
	}
}
