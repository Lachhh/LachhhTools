package com.giveawaytool.meta.player {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaItem {
		public var modelItem:ModelItem;
		private var saveData : Dictionary = new Dictionary();
		
		public function MetaItem(pModel:ModelItem) {
			modelItem = pModel;
		}
		
		public function encode():Dictionary {
			saveData["modelItem"] = modelItem.id;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			var id:int = loadData["modelItem"]; 
			modelItem = ModelItemEnum.getFromId(id); 
		}
		
		public function getFrame():int {
			return modelItem.frame;
		}
		
		static public function DEBUGCreateDummyFromGenre(modelGenre:ModelItemGenre):MetaItem {
			var result:MetaItem = new MetaItem(ModelItemEnum.pickRandomFromGenre(modelGenre));
			
			return result;
		}
		
		static public function DEBUGCreateDummyFromGenreAndIndex(modelGenre:ModelItemGenre, index:int):MetaItem {
			var result:MetaItem = new MetaItem(ModelItemEnum.pickFromGenreAndIndex(modelGenre, index));
			
			return result;
		}
	}
}
