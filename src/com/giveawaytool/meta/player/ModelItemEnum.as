package com.giveawaytool.meta.player {
	import com.lachhh.utils.Utils;
	/**
	 * @author LachhhSSD
	 */
	public class ModelItemEnum {
		static private var _id:int = 0 ;
		static public var ALL:Array = new Array();
				
		static public var NULL:ModelItem = new ModelItem(-1, -1, ModelItemGenreEnum.NULL);
		static public var SWORD_1:ModelItem = create(_id++, 1, ModelItemGenreEnum.SWORD);
		static public var SWORD_2:ModelItem = create(_id++, 2, ModelItemGenreEnum.SWORD);
		static public var SWORD_3:ModelItem = create(_id++, 3, ModelItemGenreEnum.SWORD);
		static public var SWORD_4:ModelItem = create(_id++, 4, ModelItemGenreEnum.SWORD);
		static public var SWORD_5:ModelItem = create(_id++, 5, ModelItemGenreEnum.SWORD);
		static public var SWORD_6:ModelItem = create(_id++, 6, ModelItemGenreEnum.SWORD);
		static public var SWORD_7:ModelItem = create(_id++, 7, ModelItemGenreEnum.SWORD);
		static public var SWORD_8:ModelItem = create(_id++, 8, ModelItemGenreEnum.SWORD);
		static public var SWORD_9:ModelItem = create(_id++, 9, ModelItemGenreEnum.SWORD);
		static public var SWORD_10:ModelItem = create(_id++, 10, ModelItemGenreEnum.SWORD);
		
		static public var HELMET_1:ModelItem = create(_id++, 1, ModelItemGenreEnum.HELMET);
		static public var HELMET_2:ModelItem = create(_id++, 2, ModelItemGenreEnum.HELMET);
		static public var HELMET_3:ModelItem = create(_id++, 3, ModelItemGenreEnum.HELMET);
		static public var HELMET_4:ModelItem = create(_id++, 4, ModelItemGenreEnum.HELMET);
		static public var HELMET_5:ModelItem = create(_id++, 5, ModelItemGenreEnum.HELMET);
		static public var HELMET_6:ModelItem = create(_id++, 6, ModelItemGenreEnum.HELMET);
		static public var HELMET_7:ModelItem = create(_id++, 7, ModelItemGenreEnum.HELMET);
		static public var HELMET_8:ModelItem = create(_id++, 8, ModelItemGenreEnum.HELMET);
		static public var HELMET_9:ModelItem = create(_id++, 9, ModelItemGenreEnum.HELMET);
		static public var HELMET_10:ModelItem = create(_id++, 10, ModelItemGenreEnum.HELMET);
		
		static public var BODY_1:ModelItem = create(_id++, 1, ModelItemGenreEnum.BODY);
		static public var BODY_2:ModelItem = create(_id++, 2, ModelItemGenreEnum.BODY);
		static public var BODY_3:ModelItem = create(_id++, 3, ModelItemGenreEnum.BODY);
		static public var BODY_4:ModelItem = create(_id++, 4, ModelItemGenreEnum.BODY);
		static public var BODY_5:ModelItem = create(_id++, 5, ModelItemGenreEnum.BODY);
		static public var BODY_6:ModelItem = create(_id++, 6, ModelItemGenreEnum.BODY);
		static public var BODY_7:ModelItem = create(_id++, 7, ModelItemGenreEnum.BODY);
		static public var BODY_8:ModelItem = create(_id++, 8, ModelItemGenreEnum.BODY);
		static public var BODY_9:ModelItem = create(_id++, 9, ModelItemGenreEnum.BODY);
		static public var BODY_10:ModelItem = create(_id++, 10, ModelItemGenreEnum.BODY);
		
		static public var ARM_1:ModelItem = create(_id++, 1, ModelItemGenreEnum.ARM);
		static public var ARM_2:ModelItem = create(_id++, 2, ModelItemGenreEnum.ARM);
		static public var ARM_3:ModelItem = create(_id++, 3, ModelItemGenreEnum.ARM);
		static public var ARM_4:ModelItem = create(_id++, 4, ModelItemGenreEnum.ARM);
		static public var ARM_5:ModelItem = create(_id++, 5, ModelItemGenreEnum.ARM);
		static public var ARM_6:ModelItem = create(_id++, 6, ModelItemGenreEnum.ARM);
		static public var ARM_7:ModelItem = create(_id++, 7, ModelItemGenreEnum.ARM);
		static public var ARM_8:ModelItem = create(_id++, 8, ModelItemGenreEnum.ARM);
		static public var ARM_9:ModelItem = create(_id++, 9, ModelItemGenreEnum.ARM);
		static public var ARM_10:ModelItem = create(_id++, 10, ModelItemGenreEnum.ARM);
		
		static public var SHIELD_1:ModelItem = create(_id++, 1, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_2:ModelItem = create(_id++, 2, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_3:ModelItem = create(_id++, 3, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_4:ModelItem = create(_id++, 4, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_5:ModelItem = create(_id++, 5, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_6:ModelItem = create(_id++, 6, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_7:ModelItem = create(_id++, 7, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_8:ModelItem = create(_id++, 8, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_9:ModelItem = create(_id++, 9, ModelItemGenreEnum.SHIELD);
		static public var SHIELD_10:ModelItem = create(_id++, 10, ModelItemGenreEnum.SHIELD);
		
		
		static public function create(id:int, frame:int, genre:ModelItemGenre):ModelItem {
			var m:ModelItem = new ModelItem(id, frame, genre);
			ALL.push(m);
			return m;
		}
		
		static public function getFromId(id:int):ModelItem {
			for (var i : int = 0; i < ALL.length; i++) {
				var g:ModelItem = ALL[i] as ModelItem;
				if(id == g.id) return g;
			}
			return NULL;
		} 
		
		static public function getNum():int {
			return _id;
		}
		
		
		static public function pickRandomFromGenre(modelGenre:ModelItemGenre):ModelItem {
			var items:Array = getAllModelFromGenre([], modelGenre);
			var result:ModelItem = (items[Math.floor(Math.random()*items.length)]) as ModelItem; 
			return result;
		}
		
		static public function pickFromGenreAndIndex(modelGenre:ModelItemGenre, index:int):ModelItem {
			var items:Array = getAllModelFromGenre([], modelGenre);
			var result:ModelItem = (items[index]) as ModelItem; 
			return result;
		}
		
		static public function getAllModelFromGenre(output:Array, modelGenre:ModelItemGenre):Array {
			
			for (var i : int = 0; i < ALL.length; i++) {
				var m:ModelItem = ALL[i] as ModelItem;
				if(m.genre.id == modelGenre.id) {
					output.push(m);
				}
			}
			return output;
		}
		 		
	}
}
