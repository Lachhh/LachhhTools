package com.giveawaytool.ui {
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
		
		public var metaEmote:MetaTwitchEmote;
		
		public function MetaCmdEmoteFirework(pMetaEmote:MetaTwitchEmote) {
			metaEmote = pMetaEmote;
		}
		
		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			var model:ModelTwitchEmote = metaEmote.modelEmote;
			if(model.isBitmapDataLoaded()){
				spawnEmote(metaEmote);
			} else {
				model.loadBitmapData(new Callback(spawnEmote, this, [metaEmote]), null);
			}
			endCmd();
		}
		
		public function spawnEmote(metaEmote:MetaTwitchEmote):void{
			var x:Number = ResolutionManager.getGameWidth() * Math.random();
			var y:Number = ResolutionManager.getGameHeight();
			var emote:EmoteFirework = new EmoteFirework(metaEmote);
			emote.px = x;
			emote.py = y;
		}
		
		private function onAnimEnded():void {
			endCmd();
		}
	}
}