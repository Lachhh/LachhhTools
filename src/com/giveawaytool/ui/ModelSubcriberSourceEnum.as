package com.giveawaytool.ui {
	/**
	 * @author LachhhSSD
	 */
	public class ModelSubcriberSourceEnum {
		static public var ALL:Array = new Array();
				
		static public var NULL:ModelSubcriberSource = new ModelSubcriberSource("", -1);
				
		static public var TWITCH:ModelSubcriberSource = create("twitch", 1);
		static public var GAMEWISP:ModelSubcriberSource = create("gamewisp", 2);
		
		static public function create(id:String, frame:int):ModelSubcriberSource {
			var m:ModelSubcriberSource = new ModelSubcriberSource(id, frame);
			if(!getFromId(id).isNull) throw new Error("Duplicate ID!");
			ALL.push(m);
			return m;
		}
		
		static public function getFromId(id:String):ModelSubcriberSource {
			for (var i : int = 0; i < ALL.length; i++) {
				var g:ModelSubcriberSource = ALL[i] as ModelSubcriberSource;
				if(id == g.id) return g;
			}
			return NULL;
		} 
		
		static public function getFromIndex(index:int):ModelSubcriberSource {
			if(index >= ALL.length) return NULL;
			if(index < 0) return NULL;
			return ALL[index] as ModelSubcriberSource;
		}  
				
		static public function getNum():int {
			return ALL.length;
		}
	}
}
