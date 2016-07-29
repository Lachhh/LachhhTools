package com.giveawaytool.meta {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.lachhh.utils.Utils;
	import com.lachhh.lachhhengine.VersionInfo;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGiveawayConfig {
		public var text1:String = "It's Super Awesome";
		public var text2:String = "Giveaway time!";
		public var channelToLoad:String = VersionInfo.DEFAULT_CHANNEL;
		public var metaAnimation:MetaSelectAnimation = new MetaSelectAnimation();
		public var autoChatAdd:Boolean = true;
		public var autoChatAddCmd:String = "!here";
		
		public var participants:Array;
		public var moderators:Array;
		private var saveData : Dictionary = new Dictionary();

		public function MetaGiveawayConfig() {
			participants = [];
			moderators = [];
		}

		public function encode() : Dictionary {
			saveData["text1"] = text1;
			saveData["text2"] = text2;
			saveData["channelToLoad"] = channelToLoad;
			saveData["metaAnimation"] = metaAnimation.encode();
			saveData["autoChatAdd"] = autoChatAdd;
			saveData["autoChatAddCmd"] = autoChatAddCmd;
		
			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			text1 = obj["text1"];
			text2 = obj["text2"];
			channelToLoad = obj["channelToLoad"];
			if(obj["autoChatAdd"]) autoChatAdd = obj["autoChatAdd"];
			if(obj["autoChatAddCmd"]) autoChatAddCmd = obj["autoChatAddCmd"];
			
			metaAnimation.decode(obj["metaAnimation"]);
			
			if(channelToLoad == null) channelToLoad = VersionInfo.DEFAULT_CHANNEL;
		}

		public function isEqualToCmd(pCmd : String) : Boolean {
			if(autoChatAddCmd == "") return true;
			if(autoChatAddCmd == null) return true;
			pCmd = Utils.removeTextNewLine(pCmd);
			return (autoChatAddCmd.toLowerCase() == pCmd.toLowerCase());
		}
		
		public function addListInParticipants(list:Array, bAllowDuplicate:Boolean):void {
			for (var i : int = 0; i < list.length; i++) {
				var name:String = list[i];
				if(bAllowDuplicate) {
					participants.push(name);
					continue;
				}
				if(!contains(name)) {
					participants.push(name); 
				}
			}
		}
		
		public function removeNonSub():Array {
			var result:Array = new Array();
			if(!TwitchConnection.isLoggedIn()) return result;
			for (var i : int = 0; i < participants.length; i++) {
				var name:String = participants[i];
				if(!TwitchConnection.instance.listOfSubs.containsName(name)) {
					result.push(name);
					participants.splice(i, 1);
					i--;
				}
			}
			return result;
		}
		
		public function removeNonMod():Array {
			var result:Array = new Array();
			if(!TwitchConnection.isLoggedIn()) return result;
			for (var i : int = 0; i < participants.length; i++) {
				var name:String = participants[i];
				if(!TwitchConnection.instance.isModerator(name)) {
					result.push(name);
					participants.splice(i, 1);
					i--;
				}
			}
			return result;
		}
		
		public function contains(pName:String):Boolean {
			for (var i : int = 0; i < participants.length; i++) {
				var name:String = participants[i];
				if(pName.toLowerCase() == name.toLowerCase()) return true;
			}
			return false;
		}
		
		public function isModerator(str:String):Boolean {
			if(!TwitchConnection.isLoggedIn()) return (moderators.indexOf(str) != -1);
			 
			return (TwitchConnection.instance.isModerator(str));
		}		
		
	}
}
