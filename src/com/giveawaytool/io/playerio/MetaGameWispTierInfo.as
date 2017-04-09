package com.giveawaytool.io.playerio {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispTierInfo {
		private var saveData : Dictionary = new Dictionary();
		private var listTiers : Vector.<MetaGameWispTier> = new Vector.<MetaGameWispTier>();
		public function encode():Dictionary {
			saveData = new Dictionary();
			for (var i : int = 0; i < listTiers.length; i++) {
				saveData["listTiers"+i] = listTiers[i].encode();	
			}
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			var i:int = 0;
			listTiers = new Vector.<MetaGameWispTier>();
			while(loadData["listTiers"+i]) {
				listTiers.push(MetaGameWispTier.createFromRaw(loadData["listTiers"+i]));
				i++;
			}
		}

		public function decodeFromRaw(d : Dictionary) : void {
			listTiers = new Vector.<MetaGameWispTier>();
			var i:int = 0;
			
			while(d["data"][i]) {
				listTiers.push(MetaGameWispTier.createFromRaw(d["data"][i]));
				i++;
			}
		}

		public function getFromId(tierId : String) : MetaGameWispTier {
			for (var i : int = 0; i < listTiers.length; i++) {
				var tier:MetaGameWispTier = listTiers[i];
				if(tier.tierId == tierId) return tier;
			}
			return MetaGameWispTier.NULL;
		}
	}
}
