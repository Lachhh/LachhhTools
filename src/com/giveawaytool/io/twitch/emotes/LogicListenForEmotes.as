package com.giveawaytool.io.twitch.emotes {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_Menu;
	import com.lachhh.ResolutionManager;
	import com.lachhh.lachhhengine.ui.UIEffect;
	import com.giveawaytool.fx.GameEffect;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import flash.display.Bitmap;
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.lachhhengine.camera.CameraFlashContainers;
	import com.giveawaytool.fx.GameEffectPlayOnce;
	import com.lachhh.io.Callback;
	import com.MetaIRCMessage;
	import com.giveawaytool.components.LogicTwitchChat;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	/**
	 * @author Eel
	 */
	public class LogicListenForEmotes extends ActorComponent{
		
		private var logicChat : LogicTwitchChat;
		
		public function LogicListenForEmotes(pLogicChat : LogicTwitchChat){
			super();
			logicChat = pLogicChat;
			logicChat.callbackMsgReceived.addCallback(new Callback(onMsgReceived, this, null));
		}
		
		private function onMsgReceived() : void {
			var lastMsg:MetaIRCMessage = logicChat.lastMsgReceived;
			processIRCMsg(lastMsg);
		}
		
		public function processIRCMsg(ircMsg:MetaIRCMessage):void {
			if(ircMsg == null) return ;
			
			var text:String = Utils.removeTextNewLine(ircMsg.text);
			
			if(text == "!fireworks"){
				if(MetaGameProgress.instance.metaEmoteFireworksSettings.chatCommandEnabled){
					if(shouldToggleFireworks(ircMsg)) MetaGameProgress.instance.metaEmoteFireworksSettings.tempEnableFireworks();
				}
			}
			
			if(!ircMsg.hasEmotes()) return;
			
			var group:MetaEmoteGroup = MetaEmoteGroup.createFromArray(ircMsg.metaEmotes);
			
			if(canAlert()) UI_Menu.instance.logicNotification.logicSendToWidget.sendEmoteFireworks(group);
			
			// handle emotes
		}
		
		private function shouldToggleFireworks(msg:MetaIRCMessage):Boolean{
			if(!MetaGameProgress.instance.metaEmoteFireworksSettings.chatCommandEnabled) return false;
			
			if(msg.name == TwitchConnection.getNameOfAccount()) return true;
			if(msg.moderator && MetaGameProgress.instance.metaEmoteFireworksSettings.modsCanUseCommand) return true;
				
			return false;
		}
		
		public function canAlert():Boolean{
			if(!TwitchConnection.instance == null) return false;
			if(!TwitchConnection.instance.isUserAmemberOfKOTS()) return false;
			return MetaGameProgress.instance.metaEmoteFireworksSettings.canShowFireworks();
		}
		
		public function spawnEmote(metaEmote:MetaTwitchEmote):void{
			var x:Number = ResolutionManager.getGameWidth() * Math.random();
			var y:Number = ResolutionManager.getGameHeight();
			var emote:EmoteFirework = new EmoteFirework(metaEmote);
			emote.px = x;
			emote.py = y;
		}
		
		static public function addToActor(actor: Actor, chat:LogicTwitchChat): LogicListenForEmotes {
			var result: LogicListenForEmotes = new LogicListenForEmotes(chat);
			actor.addComponent(result);
			return result;
		}
	}
}