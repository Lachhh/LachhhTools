package com.giveawaytool.meta.twitch {
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
		
		public static function createFromRawData(value:int):MetaTwitchEmote{
			var modelEmote:ModelTwitchEmote = ModelTwitchEmoteEnum.getOrCreateEmote(value);
			return new MetaTwitchEmote(modelEmote);
		}
		
		static public function createDummy():MetaTwitchEmote {
			var modelEmote:ModelTwitchEmote = ModelTwitchEmoteEnum.getOrCreateEmote(46870 + Math.random()*1000);
			return new MetaTwitchEmote(modelEmote); 
		}
		
	}
}