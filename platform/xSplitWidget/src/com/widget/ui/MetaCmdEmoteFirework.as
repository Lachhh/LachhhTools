package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.meta.twitch.MetaEmoteGroup;
	import com.lachhh.io.Callback;
	import com.giveawaytool.meta.twitch.EmoteFirework;
	import com.lachhh.ResolutionManager;
	import com.giveawaytool.meta.twitch.ModelTwitchEmote;
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.twitch.MetaTwitchEmote;
	import com.giveawaytool.ui.MetaCmd;

	/**
	 * @author Eel
	 */
	public class MetaCmdEmoteFirework extends MetaCmd {
		
		public var metaEmotes:MetaEmoteGroup;
		
		public function MetaCmdEmoteFirework(pMetaEmotes:MetaEmoteGroup) {
			metaEmotes = pMetaEmotes;
		}
		
		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			var delay:int = 0;
			
			for each(var metaEmote:MetaTwitchEmote in metaEmotes.emotes){
				loadAndSpawnEmoteWithDelay(metaEmote, delay);
				delay += 5;
			}
			
			//endCmd();
			
			CallbackWaitEffect.addWaitCallFctToActor(MainGame.dummyActor, endCmd, delay);
		}
		
		static public function loadAndSpawnEmoteWithDelay(metaEmote:MetaTwitchEmote, delay:int):void{
			var model:ModelTwitchEmote = metaEmote.modelEmote;
			if(model.isBitmapDataLoaded()){
				spawnEmoteWithDelay(metaEmote, delay);
			} else {
				model.loadBitmapData(new Callback(spawnEmoteWithDelay, MetaCmdEmoteFirework, [metaEmote, delay]), null);
			}
		}
		
		static private function spawnEmoteWithDelay(metaEmote:MetaTwitchEmote, delay:int):void{
			CallbackWaitEffect.addWaitCallbackToActor(MainGame.dummyActor, new Callback(spawnEmote, MetaCmdEmoteFirework, [metaEmote]), delay);
		}
		
		static private function spawnEmote(metaEmote:MetaTwitchEmote):void{
			var x:Number = ResolutionManager.getGameWidth() * Math.random();
			var y:Number = ResolutionManager.getGameHeight();
			var emote:EmoteFirework = new EmoteFirework(metaEmote);
			emote.px = x;
			emote.py = y;			
		}
		
		/*private function onAnimEnded():void {
			endCmd();
		}*/
	}
}