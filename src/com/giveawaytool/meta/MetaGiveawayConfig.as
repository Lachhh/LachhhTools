package com.giveawaytool.meta {
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.ui.ModelAlertTypeEnum;
	import com.giveawaytool.ui.views.MetaParticipant;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.utils.Utils;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGiveawayConfig {
		public var text1:String = "It's Super Awesome";
		public var text2:String = "Giveaway time!";
		public var channelToLoad:String = VersionInfo.DEFAULT_CHANNEL;
		public var metaAnimation:MetaSelectAnimation = new MetaSelectAnimation( ModelAlertTypeEnum.GIVEAWAY);
		public var autoChatAdd:Boolean = true;
		public var autoChatAddCmd:String = "!here";
		
		public var participants:Vector.<MetaParticipant>;
		public var moderators:Array;
		private var saveData : Dictionary = new Dictionary();

		public function MetaGiveawayConfig() {
			participants = new Vector.<MetaParticipant>();
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
					addSingleParticipant(name);
					continue;
				}
				if(!contains(name)) {
					addSingleParticipant(name);
				}
			}
		}
		
		public function addSingleParticipant(pNane:String):void {
			participants.push(new MetaParticipant(pNane));
		}
		
		public function removeNonSub():Array {
			var result:Array = new Array();
			if(!TwitchConnection.isLoggedIn()) return result;
			for (var i : int = 0; i < participants.length; i++) {
				var metaParticipant:MetaParticipant = participants[i];
				if(!TwitchConnection.instance.listOfSubs.containsName(metaParticipant.name)) {
					result.push(metaParticipant);
					participants.splice(i, 1);
					i--;
				}
			}
			
			return result;
		}
		
		public function removeSub():Array {
			var result:Array = new Array();
			if(!TwitchConnection.isLoggedIn()) return result;
			for (var i : int = 0; i < participants.length; i++) {
				var metaParticipant:MetaParticipant = participants[i];
				if(TwitchConnection.instance.listOfSubs.containsName(metaParticipant.name)) {
					result.push(metaParticipant);
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
				var metaParticipant:MetaParticipant = participants[i];
				if(!TwitchConnection.instance.isModerator(metaParticipant.name)) {
					result.push(metaParticipant);
					participants.splice(i, 1);
					i--;
				}
			}
			
			return result;
		}
		
		public function contains(pName:String):Boolean {
			var lwName:String = pName.toLowerCase(); 
			for (var i : int = 0; i < participants.length; i++) {
				var name:MetaParticipant = participants[i];
				if(lwName == name.nameToLowerCase) return true;
			}
			return false;
		}
				
		public function isModerator(str:String):Boolean {
			if(!TwitchConnection.isLoggedIn()) return (moderators.indexOf(str) != -1);
			 
			return (TwitchConnection.instance.isModerator(str));
		}		
		
	}
}
