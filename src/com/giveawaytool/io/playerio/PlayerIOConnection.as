package com.giveawaytool.io.playerio {
	import playerio.Client;
	import playerio.DatabaseObject;

	import com.giveawaytool.io.MetaFriend;
	import com.lachhh.io.Callback;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author Lachhh
	 */
	public class PlayerIOConnection {
		private var _debugName:String;
		private var _debugMode:Boolean = false;
		
		private var _client:Client;
		private var _gameId:String;
		public var partner:String;
		
		private var _success:Callback;
		private var _error:Callback;
		
		private var _root : DisplayObject;
		private var _connected : Boolean;
		private var _lastError:String;
		 
		private var _connectPending:Boolean;
		
		private var _myPlayerObject:DatabaseObject;
		private var _myPlayerObjectLoaded:Boolean;

		private var _dataLoadedCallback:Callback;
		
		//public var onErrorSaveCallback:Callback;
		public var errorMsg:Object;
		public var errorCount:int = 0;
		
		public function PlayerIOConnection(gameId:String, root:DisplayObject, debugMode:Boolean, debugName:String) {
			_debugName = debugName;
			_myPlayerObjectLoaded = false;
			_gameId = gameId;
			_root = root;
			_connected = false;
			_debugMode = debugMode;
			
			_lastError = "";
			
			_connectPending = false;
		}
				
		protected function SetCallbacks(success:Callback, error:Callback):void {
			_success = success;
			_error = error;
		}

		protected function DeclarePending():void {
			_connected = false;
			_connectPending = true;
		}
		
		protected function DeclareSuccess(client:Client, autoLoadData:Boolean):void {
			_client = client;
			_connected = true;
			_connectPending = false;
			if(autoLoadData) {
				LoadMyData(_success, _error);
			} else {
				if(_success) _success.call();
			}
		}
		
		protected function DeclareError():void {
			_connected = false;
			_connectPending = false; 
			TraceMsg(_lastError);
			if(_error) _error.call();
		}
		
		protected function onConnectError(e:Error):void {	
			_lastError = e.getStackTrace();
			DeclareError();
		}
		
		public function LoadMyData(success:Callback, errorCall:Callback):void {
			if(!connected) return; 
			
			//DEBUG_LoadSomebodyElse("twitch_roxamos", success, errorCall);
			 
			_client.bigDB.loadMyPlayerObject(
				function(ob:DatabaseObject):void {
					onBigDBLoaded(ob);
					if(success) success.call();	
				}, 
				function():void {
					onBigDBLoadedError();
					if(errorCall) errorCall.call();	
				}
			);
			TraceMsg("Loading Data...");
		}
		
		private function DEBUG_LoadSomebodyElse(twitchName:String, success:Callback, error:Callback):void {
			 _client.bigDB.load("playerObjects",twitchName, 
				function(ob:DatabaseObject):void {
					onBigDBLoaded(ob);
					if(success) success.call();	
				}, 
				function():void {
					onBigDBLoadedError();
					if(error) error.call();	
				}
			);
		}
		
		public function LoadCharacterData(m:MetaFriend, success:Callback, errorCall:Callback):void {
			if(!connected) return; 
			_client.bigDB.load("playerObjects",m.accountName, 
				function(ob:DatabaseObject):void {
					m.setMetaPlayerFromRawData(ob);
					if(success) success.call();	
				}, 
				function(error:Object):void {
					onBigDBLoadedError();
					if(errorCall) errorCall.call();	
				}
			);
			TraceMsg("Loading Data...");
		}
		
		public function LoadAllGameWispDub(m:MetaGameWispSubGroup, success:Callback, errorCall:Callback):void {
			if(!connected) return; 
			var offset:int = 0;
			_client.bigDB.loadRange("GamewispData","ByName", null, null, null, 1000,   
				function(ob:Array):void {
					m.setSubs(ob);
					
					if(success) success.call();	
				}, 
				function(error:Object):void {
					onBigDBLoadedError();
					if(errorCall) errorCall.call();	
				}
			);
			TraceMsg("Loading Data...");
		}
		
		public function LoadMySub(name:String, success:Callback, errorCall:Callback):void {
			if(!connected) return; 
			_client.bigDB.load("GamewispData",name,    
				function(db:DatabaseObject):void {
					if(success) success.callWithParams([db]);	
				}, 
				function(error:Object):void {
					onBigDBLoadedError();
					if(errorCall) errorCall.call();	
				}
			);
			TraceMsg("Loading Data...");
		}
		
		private function onBigDBLoaded(ob:DatabaseObject) : void {
			_myPlayerObject = ob;
			_myPlayerObjectLoaded = true;
			if(_dataLoadedCallback) _dataLoadedCallback.call();
			TraceMsg("Data Loaded SUCCESS!");
		}
		
		private function onBigDBLoadedError() : void {
			
		}
		
		public function get client() : Client {return _client;}	
		public function get connectPending() : Boolean {return _connectPending;}		
		public function get connected() : Boolean {return _connected;}		
		public function get myPlayerObject() : DatabaseObject {return _myPlayerObject;	}		
		public function get myPlayerObjectLoaded() : Boolean {return _myPlayerObjectLoaded;}		
		public function TraceMsg(str:String):void {
			trace("PlayerIOConnection (" + _debugName + ") : " + str);
		}
		
		public function get debugMode() : Boolean {
			return _debugMode;
		}
		
		public function get root() : DisplayObject {
			return _root;
		}
		
		public function get gameId() : String {
			return _gameId;
		}
		
		
		public function ClearData() : void {
			//SaveData(), null);
		}
		
		public function SaveData(m : MetaFriend, onDone : Callback) : void {
			
			
			/*DataManager.dictToObjectOutput(m.encode(), myPlayerObject);
			myPlayerObject.save(false, false, function():void {if(onDone) onDone.call();}, function(error:Object):void {
				errorMsg = error;
				errorCount++;
				if(onErrorSaveCallback) onErrorSaveCallback.call();}
				);*/
		}
		
		public function get savedData() : String {
			return myPlayerObject.data ;
		}
		
		public function get isEmpty() : Boolean {
			return myPlayerObject.data == null || myPlayerObject.data == "";
		}
		
		public function get dataLoaded() : Boolean {
			return myPlayerObjectLoaded;
		}
		
		public function set onDataLoadedCallback(c : Callback) : void {
			_dataLoadedCallback = c;
		}
		
		public function Connect(root : MovieClip, success : Callback = null, error : Callback = null) : void {}
		
		public function get nameOfSystem() : String {
			return "playerio";
		}
		
		public function get loggedIn() : Boolean {
			return connected;
		}
	}
}
