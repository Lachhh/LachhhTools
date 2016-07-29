package com.giveawaytool.io.twitch {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;

	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaTwitchChannelData {
		public var rawData : String ;
		public var urlLogo : String ;
		public var isPartner : Boolean ;
		public var name : String;
		public var logoBmpData : BitmapData;
		public var logoSubBadge : BitmapData;
		public var numFollowers:int = 0;

		public function decode(data : String) : void {
			rawData = data;
			var d:Dictionary = DataManager.stringToDictionnary(data);
			urlLogo = d["logo"];
			isPartner = d["partner"];
			name = d["name"];
			numFollowers = d["followers"];
			/*_id		
			_links		
			broadcaster_language		
			created_at		
			display_name		
			followers	
			game		
			language	
			logo		
			mature		
			name		
			partner		
			profile_banner		
			profile_banner_background_color		
			status		
			updated_at		
			url		
			video_banner		
			views		
						*/
		}
		
		public function refreshLogo(onSuccess : Callback, onError : Callback) : void {
			logoBmpData = null;
			if(urlLogo == null) return;
			var req : TwitchRequestLogo = new TwitchRequestLogo(TwitchConnection.instance);
			req.onSuccessCallback = new Callback(onLogoSuccess, this, [req, onSuccess]);
			req.onErrorCallback = onError;
			req.fetchLogo(urlLogo);
			
			
			
		}	
		
		private function onLogoSuccess(req:TwitchRequestLogo, callback:Callback) : void {
			logoBmpData = req.logoBmpData;
			
			var reqSub : TwitchRequestSubBadge = new TwitchRequestSubBadge(TwitchConnection.instance);
			reqSub.onSuccessCallback = new Callback(onLogoSubBadgeSuccess, this, [reqSub, callback]);
			reqSub.onErrorCallback = req.onErrorCallback;
			reqSub.fetchLogo();
			
		}
		
		private function onLogoSubBadgeSuccess(req:TwitchRequestSubBadge, callback:Callback) : void {
			logoSubBadge = req.logoBmpData;
			if(callback) callback.call();
		}
	}
}
