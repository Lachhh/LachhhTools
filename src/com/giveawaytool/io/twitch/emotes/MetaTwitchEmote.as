package com.giveawaytool.io.twitch.emotes {
	import flash.utils.Dictionary;
	/**
	 * @author Eel
	 */
	public class MetaTwitchEmote {
		
		public var modelEmote:ModelTwitchEmote = ModelTwitchEmoteEnum.NULL;
		
		public function MetaTwitchEmote(pModelEmote:ModelTwitchEmote){
			modelEmote = pModelEmote;
		}
		
		public function encode():int{
			return modelEmote.id;
		}
		
		public function decode(data:int):void{
			modelEmote = ModelTwitchEmoteEnum.getOrCreateEmote(data);
		}
		
		public static function createFromRawData(d:Dictionary):MetaTwitchEmote{
			var modelEmote:ModelTwitchEmote = ModelTwitchEmoteEnum.getOrCreateEmote(d["modelEmote"]);
			return new MetaTwitchEmote(modelEmote);
		}
		
	}
}