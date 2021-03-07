package com.giveawaytool.meta.twitch {
	/**
	 * @author Eel
	 */
	public class ModelTwitchEmoteEnum {
		
		public static var NULL:ModelTwitchEmote = new ModelTwitchEmote(-1);
		
		public static var ALL:Array = new Array();
		
		public static function getOrCreateEmote(pId:int):ModelTwitchEmote{
			var model:ModelTwitchEmote = getFromId(pId);
			if(model.isNull){
				return create(pId);
			} else {
				return model;
			}
		}
		
		public static function create(pId:int):ModelTwitchEmote{
			if(!getFromId(pId).isNull) throw new Error("DUPLICATE IN MODEL ENUM");
			
			var result:ModelTwitchEmote = new ModelTwitchEmote(pId);
			ALL.push(result);
			return result;
		}
		
		public static function getFromId(pId:int):ModelTwitchEmote{
			for each(var emote:ModelTwitchEmote in ALL){
				if(emote.id == pId) return emote;
			}
			return NULL;
		}
		
	}
}