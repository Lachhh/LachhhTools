package com.giveawaytool.ui {
	import isle.susisu.twitter.Twitter;
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.events.TwitterRequestEvent;

	import com.animation.exported.FX_WINNERSNAPSHOT1;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaTwitterAccount;
	import com.giveawaytool.ui.views.ViewWinnerPng;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;

	/**
	 * @author LachhhSSD
	 */
	public class UI_NewTwitterAccount extends UIBase {
		private var uiPopup:UIPopupInsert;
		private var twitter : Twitter ;
		private var windowOptions : NativeWindowInitOptions;
		private var htmlLoader : HTMLLoader;
		public var onCompleteCallback:Callback; 
		
		public function UI_NewTwitterAccount() {
			super(AnimationFactory.EMPTY);
			
			
			twitter = new Twitter(VersionInfo.TWITTER_CONSUMER_KEY, VersionInfo.TWITTER_CONSUMER_KEY_SECRET);
			
			var rtRequest : TwitterRequest = twitter.oauth_requestToken();
			rtRequest.addEventListener(TwitterRequestEvent.COMPLETE, onComplete_rtRequest);
			
			windowOptions = new NativeWindowInitOptions();
			windowOptions.type = NativeWindowType.UTILITY;
			windowOptions.systemChrome = NativeWindowSystemChrome.STANDARD;
			windowOptions.transparent = false;
			windowOptions.resizable   = true;
			windowOptions.minimizable = false;
			windowOptions.renderMode = NativeWindowRenderMode.GPU;	
			
			htmlLoader = HTMLLoader.createRootWindow(  true, windowOptions, false, new Rectangle( 610, 78, 780, 480) );
			//htmlLoader.paintsDefaultBackground = false;
			htmlLoader.stage.nativeWindow.alwaysInFront = false;
			htmlLoader.addEventListener(Event.LOCATION_CHANGE, onLocationChange);
			
			uiPopup = UIPopupInsert.createInsertOne("Enter PIN CODE", new Callback(onPinCode, this, null), null);
			uiPopup.setNameOfDynamicBtn(uiPopup.btn1, "Enter");
			uiPopup.setNameOfDynamicBtn(uiPopup.btn3, "Cancel");
			uiPopup.inputTxt.text = "<Pin Code>";
		}

		private function onLocationChange(event : Event) : void {
			
		}
		
		private function onComplete_rtRequest(event : TwitterRequestEvent) : void {
			htmlLoader.addEventListener(Event.COMPLETE, onComplete_htmlLoader);
            htmlLoader.load(new URLRequest(twitter.getOAuthAuthorizeURL()));
		}

		private function onComplete_htmlLoader(event : Event) : void {
			
		}
		
		private function onPinCode():void {
			var atRequest : TwitterRequest = twitter.oauth_accessToken(uiPopup.inputTxt.text);
			atRequest.addEventListener(TwitterRequestEvent.COMPLETE, onComplete);
		}

		private function onComplete(event : TwitterRequestEvent) : void {
			var newAccount:MetaTwitterAccount = new MetaTwitterAccount();
			newAccount.twitter = twitter;
			newAccount.accessToken = twitter.accessToken;
			newAccount.accessTokenSecret = twitter.accessTokenSecret;
			newAccount.fetchInfo();
			MetaGameProgress.instance.metaShareOnTwitter.twitterAccounts.addAccount(newAccount);
			
			htmlLoader.stage.nativeWindow.close();
			
			if(onCompleteCallback) onCompleteCallback.call();
			
		}
	}
}
