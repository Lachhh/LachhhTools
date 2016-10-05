package com.giveawaytool.meta.twitch {
	import flash.utils.Dictionary;
	/**
	 * @author Eel
	 */
	public class MetaTwitchEmote {
		
		public var modelEmote:ModelTwitchEmote = ModelTwitchEmoteEnum.NULL;
		
		public function MetaTwitchEmote(pModelEmote:ModelTwitchEmote){
			modelEmote = pModelEmote;
		}
		
		public static function createFromRawData(d:Dictionary):MetaTwitchEmote{
			var modelEmote:ModelTwitchEmote = ModelTwitchEmoteEnum.getOrCreateEmote(d["modelEmote"]);
			return new MetaTwitchEmote(modelEmote);
		}
		
	}
}