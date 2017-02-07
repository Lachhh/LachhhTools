package com.giveawaytool.meta {
	import com.SimpleIRCBot;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.flash.FlashUtils;
	import flash.utils.Dictionary;
	/**
	 * @author Eel
	 */
	public class MetaEmoteFireworksSettings {
		
		private const SECOND:int = 1000;
		
		public var forceFireworksEnabled:Boolean = false;
		
		public var chatCommandEnabled:Boolean = true;
		public var modsCanUseCommand:Boolean = true;
		public var autoTriggerOnBigEvent:Boolean = true;
		
		public var autoTriggerOnBigDonation:Boolean = true;
		public var autoTriggerOnSubscription:Boolean = true;
		public var autoTriggerOnBigHost:Boolean = true;
		
		public var lastTimeFireworksEnabled:int = -1;
		
		private var saveData:Dictionary = new Dictionary();
		
		public function MetaEmoteFireworksSettings(){
			
		}
		
		public function autoEnableFireworksIfAllowed():void{
			if(autoTriggerOnBigEvent) tempEnableFireworks();
		}
		
		public function autoTriggerFromDonation():void{
			if(!autoTriggerOnBigDonation) return;
			autoEnableFireworksIfAllowed();
		}
		
		public function autoTriggerFromHost():void{
			if(!autoTriggerOnBigHost) return;
			autoEnableFireworksIfAllowed();
		}
		
		public function autoTriggerFromSubscription():void{
			if(!autoTriggerOnSubscription) return;
			autoEnableFireworksIfAllowed();
		}
		
		public function toggleForceEnabled():void{
			forceFireworksEnabled = !forceFireworksEnabled;
			if(!forceFireworksEnabled) lastTimeFireworksEnabled = -1;
		}
		
		public function tempEnableFireworks():void{
			lastTimeFireworksEnabled = FlashUtils.myGetTime();
			var simpleIRCBot : SimpleIRCBot = UI_Menu.instance.logicNotification.logicListenToChat.getIRCBot(); 
			if(simpleIRCBot) simpleIRCBot.SayToChannel("/me --- emote fireworks enabled for 30 seconds!");
		}
		
		public function canShowFireworks():Boolean{
			if(forceFireworksEnabled) return true;
			if(lastTimeFireworksEnabled == -1) return false;
			return (FlashUtils.myGetTime() - lastTimeFireworksEnabled) < 30*SECOND;
		}
		
		public function getDurationRemaining():Number{
			return Math.round(30 - (FlashUtils.myGetTime() - lastTimeFireworksEnabled) / 1000);
		}
		
		public function encode():Dictionary{
			saveData["chatCommandEnabled"] = chatCommandEnabled;
			saveData["modsCanUseCommand"] = modsCanUseCommand;
			saveData["autoTriggerOnBigEvent"] = autoTriggerOnBigEvent;
			
			saveData["autoTriggerOnBigDonation"] = autoTriggerOnBigDonation;
			saveData["autoTriggerOnSubscription"] = autoTriggerOnSubscription;
			saveData["autoTriggerOnBigHost"] = autoTriggerOnBigHost;
			
			return saveData;
		}
		
		public function decode(data:Dictionary):void{
			if(data == null) return;
			chatCommandEnabled = data["chatCommandEnabled"] as Boolean;
			modsCanUseCommand = data["modsCanUseCommand"] as Boolean;
			autoTriggerOnBigEvent = data["autoTriggerOnBigEvent"] as Boolean;
			
			autoTriggerOnBigDonation = data["autoTriggerOnBigDonation"] as Boolean;
			autoTriggerOnSubscription = data["autoTriggerOnSubscription"] as Boolean;
			autoTriggerOnBigHost = data["autoTriggerOnBigHost"] as Boolean;
		}
		
	}
}