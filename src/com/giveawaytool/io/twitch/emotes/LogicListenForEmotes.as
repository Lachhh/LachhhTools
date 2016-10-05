package com.giveawaytool.io.twitch.emotes {
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
			
			if(!ircMsg.hasEmotes()) return;
			
			
			
			for each(var emote:MetaTwitchEmote in ircMsg.metaEmotes){
				if(canAlert()) UI_Menu.instance.logicNotification.logicSendToWidget.sendEmoteFirework(emote);
			}
			
			// handle emotes
		}
		
		public function canAlert():Boolean{
			return true;
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