package com.giveawaytool.meta.player {
	/**
	 * @author LachhhSSD
	 */
	public class ModelItemGenreEnum {
		static private var _id:int = 0 ;
		static public var ALL:Array = new Array();
				
		static public var NULL:ModelItemGenre = new ModelItemGenre(-1);
				
		static public var SWORD:ModelItemGenre = create(_id++);
		static public var SHIELD:ModelItemGenre = create(_id++);
		static public var HELMET:ModelItemGenre = create(_id++);
		static public var BODY:ModelItemGenre = create(_id++);
		static public var ARM:ModelItemGenre = create(_id++);
		
		static public var RING:ModelItemGenre = create(_id++);
		
		
		static public function create(id:int):ModelItemGenre {
			var m:ModelItemGenre = new ModelItemGenre(id);
			ALL.push(m);
			return m;
		}
		
		static public function getFromId(id:int):ModelItemGenre {
			for (var i : int = 0; i < ALL.length; i++) {
				var g:ModelItemGenre = ALL[i] as ModelItemGenre;
				if(id == g.id) return g;
			}
			return NULL;
		} 
		
		static public function getNum():int {
			return _id;
		}
	}
}
