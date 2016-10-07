package com.giveawaytool.ui {
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
			var playSound:Boolean = true;
			for each(var metaEmote:MetaTwitchEmote in metaEmotes.emotes){
				var model:ModelTwitchEmote = metaEmote.modelEmote;
				if(model.isBitmapDataLoaded()){
					spawnEmote(metaEmote, delay, playSound);
				} else {
					model.loadBitmapData(new Callback(spawnEmote, this, [metaEmote, delay, playSound]), null);
				}
				delay += 3;
				playSound = !playSound;
			}
			endCmd();
		}
		
		public function spawnEmote(metaEmote:MetaTwitchEmote, delay:int, playSound:Boolean):void{
			var x:Number = ResolutionManager.getGameWidth() * Math.random();
			var y:Number = ResolutionManager.getGameHeight();
			var emote:EmoteFirework = new EmoteFirework(metaEmote);
			emote.px = x;
			emote.py = y;
			emote.wait = delay;
			emote.shouldPlayLaunchSound = playSound;
		}
		
		private function onAnimEnded():void {
			endCmd();
		}
	}
}