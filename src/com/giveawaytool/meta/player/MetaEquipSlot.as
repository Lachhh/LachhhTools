package com.giveawaytool.meta.player {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaEquipSlot {
		static private var NULL_ITEM:MetaItem = new MetaItem(ModelItemEnum.NULL);
		public var metaItem : MetaItem;
		public var modelGenre : ModelItemGenre;
		private var saveData : Dictionary = new Dictionary();

		public function MetaEquipSlot(pModelGenre:ModelItemGenre) {
			metaItem = NULL_ITEM;
			modelGenre = pModelGenre;
		}
			
		public function encode():Dictionary {
			saveData["metaItem"] = metaItem.encode();
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			metaItem.decode(loadData["metaItem"]);
		}
		
		public function equip(m:MetaItem):void {
			if(!canEquip(m)) return ;
			metaItem = m;
		}
		
		public function swapSlots(mSlot:MetaEquipSlot):void {
			if(!canEquip(mSlot.metaItem)) return ;
			if(!mSlot.canEquip(metaItem)) return ;
			var temp:MetaItem = metaItem;
			equip(mSlot.metaItem);
			mSlot.equip(temp);
		}
		
		public function DEBUGEquipRandomItem():void {
			var randomizedItem:MetaItem = MetaItem.DEBUGCreateDummyFromGenre(modelGenre);
			equip(randomizedItem);
		}
		
		public function DEBUGEquipItemFromIndex(index:int):void {
			var randomizedItem:MetaItem = MetaItem.DEBUGCreateDummyFromGenreAndIndex(modelGenre, index);
			equip(randomizedItem);
		}
		
		public function canEquip(pMetaItem:MetaItem):Boolean {
			return modelGenre.id == pMetaItem.modelItem.genre.id; 
		}

		public function isEmpty():Boolean {
			return metaItem.modelItem.isNull;
		}
	}
}
