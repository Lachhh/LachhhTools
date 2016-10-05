package com.giveawaytool.io.twitch.emotes {
	import flash.utils.Dictionary;
	/**
	 * @author Eel
	 */
	public class MetaTwitchEmote {
		
		private var saveData:Dictionary = new Dictionary();
		
		public var modelEmote:ModelTwitchEmote = ModelTwitchEmoteEnum.NULL;
		
		public function MetaTwitchEmote(pModelEmote:ModelTwitchEmote){
			modelEmote = pModelEmote;
		}
		
		public function encode():Dictionary{;
			saveData["modelEmote"] = modelEmote.id;
			return saveData;
		}
		
	}
}