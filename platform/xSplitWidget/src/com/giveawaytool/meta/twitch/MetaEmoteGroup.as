package com.giveawaytool.meta.twitch {
	import flash.utils.Dictionary;
	/**
	 * @author Eel
	 */
	public class MetaEmoteGroup {
		
		private var saveData:Dictionary = new Dictionary();
		
		public var emotes:Array = new Array();
		
		public function MetaEmoteGroup(){
			
		}
		
		public function encode():Dictionary{
			saveData = new Dictionary();
			
			var index:int = 0;
			
			for each(var emote:MetaTwitchEmote in emotes){
				saveData["emote"+index] = emote.encode();
				index++;
			}
			
			return saveData;
		}
		
		public function decode(data:Dictionary):void{
			emotes = new Array();
			var index:int = 0;
			while(data["emote"+index] != null){
				emotes.push(MetaTwitchEmote.createFromRawData(data["emote"+index]));
				index++;
			}
		}
		
		public function fillFromList(list:Array):void{
			for each(var emote:MetaTwitchEmote in list){
				addEmote(emote);
			}
		}
		
		public function addEmote(emote:MetaTwitchEmote):void{
			emotes.push(emote);
		}
		
		public static function createFromArray(list:Array):MetaEmoteGroup{
			var result:MetaEmoteGroup = new MetaEmoteGroup();
			result.fillFromList(list);
			return result;
		}
		
		public static function createFromRawData(data:Dictionary):MetaEmoteGroup{
			var result:MetaEmoteGroup = new MetaEmoteGroup();
			result.decode(data);
			return result;
		}
	}
}