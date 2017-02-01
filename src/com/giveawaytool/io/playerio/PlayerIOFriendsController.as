package com.giveawaytool.io.playerio {
	import playerio.DatabaseObject;

	import com.giveawaytool.io.MetaFriend;
	import com.giveawaytool.io.PlayerIOLachhhRPGController;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.io.Callback;
	import com.lachhh.utils.Utils;

	/**
	 * @author Lachhh
	 */
	public class PlayerIOFriendsController {
		private var _secureSonnection:PlayerIOConnectionSecure;
		private var _metaFriends:Array = new Array();
		private var _dualFriendsTurns:Array = new Array();
		private var _dualScore:Array = new Array();
		private var _friendListNameLoaded:Boolean = false;
		private var _modelExternalAPI:ModelExternalPremiumAPI;
		
		public var mySelf:MetaFriend;
		

		public function PlayerIOFriendsController(secureSonnection:PlayerIOConnectionSecure, modelExternalAPI:ModelExternalPremiumAPI) {
			_secureSonnection = secureSonnection;
			_modelExternalAPI = modelExternalAPI;
		}
		

			
		
		public function AddApproveFriendRequest(metaFriend:MetaFriend, success:Callback, error:Callback):void {
			if(!PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connected) return ;
			if(metaFriend.accountName == GetMyAccountName()) {
				if(error) error.call();	
				return ;
			}
		
			//enregistre sur mon account
			PlayerIOLachhhRPGController.getInstance().mySecuredConnection.client.bigDB.load(
				"FriendsVisited", 
				GetMyAccountName(), 
				function (user:DatabaseObject):void{
					if(user != null) {
						
						AddMyNameToList(user, metaFriend.accountName, "dualTurn");
						//AddMyNameToList(user, metaFriend.accountNameWithScore, "dualScore");
						AddMyNameToList(user, metaFriend.accountName, "friendsApproved");
						user.save();
						//onFriendApproved(user, metaFriend.accountName);
						
						//if(success) success.call();
					} else {
						//if(error) error.call();	
					}
				}, 
				function (e:Error):void{
					//if(error) error.call();	
				});
			
			//enregistre sur son account
			PlayerIOLachhhRPGController.getInstance().mySecuredConnection.client.bigDB.load(
				"FriendsVisited", 
				metaFriend.accountName, 
				function (user:DatabaseObject):void{
					if(user != null) {
						AddMyNameToList(user, GetMyAccountName(), "friendsApproved");
						user.save();
						//onFriendApproved(user, GetMyAccountName());
						if(success) success.call();
					} else {
						if(error) error.call();	
					}
				}, 
				function (e:Error):void{
					if(error) error.call();	
				});
		} 
		
		public function RemoveFriendRequest(metaFriend:MetaFriend, success:Callback, error:Callback):void {
			if(!PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connected) return ;
			if(metaFriend.accountName == GetMyAccountName()) {
				if(error) error.call();	
				return ;
			}
			
			Utils.RemoveFromArray(_metaFriends, metaFriend);
			
			//enregistre sur mon account
			PlayerIOLachhhRPGController.getInstance().mySecuredConnection.client.bigDB.load(
				"FriendsVisited", 
				GetMyAccountName(), 
				function (user:DatabaseObject):void{
					if(user != null) {
						RemoveMyNameFromList(user, metaFriend.accountName, "friendsRequest");
						user.save();
					} else {
						//if(error) error.call();	
					}
				}, 
				function (e:Error):void{
					//if(error) error.call();	
				});
			
		} 
		
		
		public function AddFriendRequest(friendName:String, success:Callback, error:Callback):void {
			if(!PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connected) return ;		
			
			if(friendName == GetMyAccountName()) {
				if(error) error.call();	
				return ;
			}
			
			PlayerIOLachhhRPGController.getInstance().mySecuredConnection.client.bigDB.load(
				"FriendsVisited", 
				friendName, 
				function (user:DatabaseObject):void{
					if(user != null) {
						
						AddMyNameToList(user, GetMyAccountName(), "friendsRequest");
						user.save();
						if(success) success.call();
					} else {
						if(error) error.call();	
					}
				}, 
				function (e:Error):void{
					if(error) error.call();	
				});
	
		} 
		
		
		public function AddFriendRequestOnSpecificAPI(friendName:String, modelExternalAPI:ModelExternalPremiumAPI, success:Callback, error:Callback):void {
			if(!PlayerIOLachhhRPGController.getInstance().mySecuredConnection.connected) return ;		
			friendName = modelExternalAPI.prefixId + friendName;
			
			if(friendName == GetMyAccountName()) {
				if(error) error.call();	
				return ;
			}
			
			PlayerIOLachhhRPGController.getInstance().mySecuredConnection.client.bigDB.load(
				"FriendsVisited", 
				friendName, 
				function (user:DatabaseObject):void{
					if(user != null) {
						
						AddMyNameToList(user, GetMyAccountName(), "friendsRequest");
						user.save();
						if(success) success.call();
					} else {
						if(error) error.call();	
					}
				}, 
				function (e:Error):void{
					if(error) error.call();	
				});
	
		} 
		
		
		
		private function AddMyNameToList(user:DatabaseObject, name:String, key:String):void {
			var value:String = user[key];
			 
			
			if(value == "" || value == null) {
				user[key] = name;
			} else {
				var valueArray:Array = FlashUtils.mySplit(value, "~");
				if(Utils.IsInArray(valueArray, name)) return ;
				if(value == name || value.indexOf(name+"~") != -1 || value.indexOf("~"+name) != -1) return;
				user[key] += "~" + name ;
			}
		} 
		
		private function RemoveMyNameFromList(user:DatabaseObject, name:String, key:String):void {
			var value:String = user[key];
			if(value == "" || value == null) return ;
			if(value == name) {
				user[key] = "";
			} else {
				var array:Array = value.split("~");
				Utils.RemoveFromArray(array, name);
				user[key] = array.join("~");
			}
		} 
				
		private function AppendMetaFriendsFromRawData(rawData:String):Array {
			if(rawData == "" || rawData == null) return _metaFriends;
			 
			var friendsNameList:Array = FlashUtils.mySplit(rawData, "~");
			for (var i : int = 0; i < friendsNameList.length; i++) {
				var friendAccountName:String = friendsNameList[i];
				if(friendAccountName == GetMyAccountName()) continue;
				if(IsFriendExist(friendAccountName)) continue;
				
				var newFriend:MetaFriend = new MetaFriend(friendsNameList[i]);
				_metaFriends.push(newFriend);
				
				
			}
			return _metaFriends;
		}
		
		private function IsFriendExist(accountName:String):Boolean {
			for (var i : int = 0; i < _metaFriends.length; i++) {
				var m:MetaFriend = _metaFriends[i];
				if(m.accountName == accountName) return true;
			}
			return false;
		}
				
		private function onError(e:Error):void {
			TraceMsg(" ERROR " + e.getStackTrace());
		}
			
		public function GetFriendsByAccountName(friendAccountName:String):MetaFriend {
			if(!_secureSonnection.connected) return null;
			for (var i : int = 0; i < _metaFriends.length; i++) {
				var metaFriend:MetaFriend = _metaFriends[i];
				if(metaFriend.accountName == friendAccountName) return metaFriend;
			}
			return null;
		}
		
		public function GetMyAccountName():String {
			if(!_secureSonnection.connected) return "";
			return _secureSonnection.myAccountName;
		}
		
		public function GetMyName():String {
			return GetMyAccountName();
		}

		public function GetMyNameWithoutPlatFormPrefix():String {
			return ModelExternalPremiumAPIEnum.RemovePlatFormPrefixFromString(GetMyName());
		}
		
	
		private function TraceMsg(msg:String):void {
			trace("PlayerIOFriendsController : " + msg);	
		}
		
		public function get metaFriends() : Array {
			return _metaFriends;
		}
	
		
		public function get friendLoaded() : Boolean {
			return _friendListNameLoaded;
		}
		
		public function GetNumFriendsApproved() : int {
			return _metaFriends.length;
		}
	
	}
}
