package com.giveawaytool.io.playerio {
	import playerio.Client;
	import playerio.Connection;
	import playerio.Message;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;

	import com.lachhh.flash.FlashUtils;
	import com.lachhh.io.Callback;

	import flash.display.DisplayObject;

	/**
	 * @author Lachhh
	 */
	public class PlayerIOConnectionSecure extends PlayerIOConnection  {
		public var myAccountName:String = "";
		public var myAccountNameWithoutPrefix:String = "";
		public var userId:String;
		public var authToken:String;
		public var msgAuthType:String;
		public var myDate:Date;
		
		private var _connection:Connection;
		public var connectionGameRoom:PlayerIOGameRoomConnection;
		
		
		public function PlayerIOConnectionSecure(gameId : String, root : DisplayObject,  debugMode : Boolean, debugName : String) {
			super(gameId, root, debugMode, debugName);
			partner = "";
			msgAuthType = "";
		}
		
		public function SecureConnectKongregate(pUserId:String, pAuthToken:String, success : Callback = null, error : Callback = null):void {
			partner = "kongregate";
			msgAuthType = "";
			userId = pUserId;
			authToken = pAuthToken;
			myAccountName = ModelExternalPremiumAPIEnum.KONGREGATE.prefixId ;
			if(connectPending) return;

			DeclarePending();
			SetCallbacks(success, error);
			
			PlayerIO.quickConnect.kongregateConnect(
				root.stage, 
				gameId, 
				pUserId, 
				pAuthToken, 
				function(client:Client):void {
					DeclareSuccess(client, true);
					TraceMsg("Secure Connect SUCCESS!");
				},
				onConnectError);
			
			TraceMsg("Attempting Connect With Kongregate with " + myAccountName);
		}
		
		
		public function SecureConnectArmorGames(pUserId:String, pAuthToken:String, success : Callback = null, error : Callback = null):void {			
			partner = "armorgames";
			msgAuthType = "authArmorGames";
			userId = pUserId;//armorGamesController.userId;
			authToken = pAuthToken;//armorGamesController.authToken;
			
			SecureConnect(success, error);		
			TraceMsg("Attempting Connect With ArmorGames");
		}
		
		public function SecureConnectGamerSafe(pUserId:String, pAuthToken:String, success : Callback, error : Callback):void {
			partner = "gamersafe";
			msgAuthType = "authGamerSafe";
			userId = pUserId;//GamerSafe.api.account.id ;
			authToken = pAuthToken;//GamerSafe.api.userAuthKey;
			
			SecureConnect(success, error);
		}
		
		public function SecureConnectKongregateManually(pUserId:String, pAuthToken:String, success : Callback, error : Callback):void {
			partner = "kongregate";
			msgAuthType = "authKongregate";
			userId = pUserId;//GamerSafe.api.account.id ; //kongregate.services.getUserId();
			authToken = pAuthToken;//GamerSafe.api.userAuthKey;  kongregate.services.getGameAuthToken();
			
			SecureConnect(success, error);
			
			//TraceMsg("Attempting Connect With " + partner + "/" + authToken);
		}
		
		public function SecureConnectTwitch(pAuthToken:String, success : Callback, error : Callback):void {
			partner = "twitch";
			msgAuthType = "authTwitch";
			userId = "twitchUser";
			authToken = pAuthToken;
			
			SecureConnect(success, error);
			
			//TraceMsg("Attempting Connect With " + partner + "/" + authToken);
		}
		
		//1066831/22b139565e254f5e4e04ff5752bd9f3349f61c8a67000f49a3f9aad09f9d8325
		
		
		public function SecureConnect(success : Callback, error : Callback):void {
			if(connectPending) return;

			DeclarePending();
			SetCallbacks(success, error);
			var authArg:Object = new Object() ;
			authArg.userId = "testUser";
			
			PlayerIO.authenticate(root.stage, gameId, "public", authArg, null, onConnectTemp, onConnectError);
			
			TraceMsg("Attempting Connect With " + partner);
		}
		
		private function onConnectTemp(client:Client):void {
			if(debugMode) {
				client.multiplayer.developmentServer = "localhost:8184";
			}
			client.multiplayer.createJoinRoom(null, "AuthRoom", false, {}, {}, onRoomConnected, onConnectError);
			TraceMsg("Connected on 'public' connection.");
			TraceMsg("Joining AuthRoom...");
		}
		
		private function onRoomConnected(con:Connection):void {
			_connection = con;
			
			con.addMessageHandler("auth", onAuthaurizationMsg);
			con.addMessageHandler("authError", onAuthaurizationMsgError);
			con.send(msgAuthType, userId, authToken);
			TraceMsg("AuthRoom Joined.");
			TraceMsg("Sending Auth...");
		}
		
		private function onAuthaurizationMsg(m:Message):void{
					
			if(m.length == 0){
				onConnectError(new PlayerIOError("Secured authorizatioon failed",27667));
				_connection.disconnect();
				_connection = null;
			}else{
				TraceMsg("Received Auth Info From Server.");
				myAccountName = m.getString(0);
				
				var auAuth:String = m.getString(1);
				var dateInString:String = m.getString(2);
				var dateInStringArray:Array  = dateInString.split(".");
				
				var day:int = FlashUtils.myParseFloat(dateInStringArray[0]);
				var month:int = FlashUtils.myParseFloat(dateInStringArray[1]);
				var year:int = FlashUtils.myParseFloat(dateInStringArray[2]);
				
				myDate = new Date(year, month-1, day);
				//myDate.setDate()
				//myDate.setTime(ticks);
				TraceMsg("My Date : " + day + "/" + month + "/" + year + "/" + myDate.toString());
				TraceMsg("Connectiong securely with aut infos...");
				var authArg:Object = new Object() ;
				authArg.userId = myAccountName;
				authArg.auth = auAuth;
				
			    //    { "userId", "MyUserName" },
			     
				PlayerIO.authenticate(root.stage, gameId, "secure", authArg, null, onSecuredConnectSuccess, function(e:PlayerIOError):void{
					
					onConnectError(e);
					_connection.disconnect();
					_connection = null;
				});
				
				/*PlayerIO.connect(root.stage, gameId, "secure", myAccountName, auAuth, partner, onSecuredConnectSuccess, function(e:PlayerIOError):void{
					
					onConnectError(e);
					_connection.disconnect();
					_connection = null;
				});*/
			}
		}
		
		
		
		private function onAuthaurizationMsgError(m:Message):void{
			onConnectError(new PlayerIOError("Secured authorizatioon failed",27667));
			_connection.disconnect();
			_connection = null;
		}
		
		private function onSecuredConnectSuccess(client:Client):void {
			_connection.disconnect();
			_connection = null;
			
			
			DeclareSuccess(client, false);
			
			TraceMsg("Secure Connect SUCCESS!");
		}
		
		public function connectToGameRoom(success:Callback):void {
			connectionGameRoom = new PlayerIOGameRoomConnection(client, debugMode);
			connectionGameRoom.onSuccess = success;
			connectionGameRoom.connectToRoom("GameRoom");

		}
	}
}
