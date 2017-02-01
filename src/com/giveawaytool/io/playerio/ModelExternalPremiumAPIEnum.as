package com.giveawaytool.io.playerio {

	/**
	 * @author Lachhh
	 */
	public class ModelExternalPremiumAPIEnum {
		static private var _id:int = 0 ;
		static public var ALL:Array = new Array();
				
		static public var NULL:ModelExternalPremiumAPI = new ModelExternalPremiumAPI(-1,  "", "");
				
		static public var GAMERSAFE:ModelExternalPremiumAPI = Create("gs", "gs_", "GamerSafe");
		static public var KONGREGATE:ModelExternalPremiumAPI = Create("kong", "kong_", "Kongregate");
		static public var ARMORGAMES:ModelExternalPremiumAPI = Create("armor", "armor_", "Armor Games");
		static public var TWITCH:ModelExternalPremiumAPI = Create("twitch", "twitch_", "Twitch");
		
		static public var YAHOO:ModelExternalPremiumAPI = Create("ygn", "ygn_", "Yahoo Games");
		static public var NEWGROUNDS:ModelExternalPremiumAPI = Create("ng", "ng_", "Newgrounds");
		static public var GOOGLEPLAYGAMES:ModelExternalPremiumAPI = Create("gpg", "gpg_", "Google Play Games");
		static public var IOSGAMECENTER:ModelExternalPremiumAPI = Create("iosgc", "iosgc_", "Game Center");
		static public var FACEBOOK:ModelExternalPremiumAPI = Create("fb", "fb_", "Facebook");
		static public var BERZERK:ModelExternalPremiumAPI = Create("bzk", "berzerk_", "Berzerk Studios");
		
		static public function Create(id:String, prefixId:String, nameOfSystem:String):ModelExternalPremiumAPI {
			var m:ModelExternalPremiumAPI = new ModelExternalPremiumAPI(_id, prefixId, nameOfSystem);
			_id++;
			ALL.push(m);
			return m;
		}
				
				
		static public function GetFromId(id:int):ModelExternalPremiumAPI {
			for (var i : int = 0; i < ALL.length; i++) {
				var g:ModelExternalPremiumAPI = ALL[i];
				if(id == g.id) return g;
			}
			return NULL;
		} 
		
		static public function getFromIndex(id:int):ModelExternalPremiumAPI {
			if(id >= ALL.length) NULL;
			if(id < 0) NULL;
			var g:ModelExternalPremiumAPI = ALL[id] as ModelExternalPremiumAPI;
			return g;
		} 
		
		static public function RemovePlatFormPrefixFromString(str:String):String {
			for (var i : int = 0; i < ModelExternalPremiumAPIEnum.ALL.length; i++) {
				var modelExternal:ModelExternalPremiumAPI = ModelExternalPremiumAPIEnum.getFromIndex(i);
				str = RemovePrefix(str, modelExternal.prefixId);	
			}
			
			return str;
		}
		
		static private function RemovePrefix(strToManipulate:String, prefixToRemove:String):String {
			var index:int = strToManipulate.indexOf(prefixToRemove);
			if(index == 0) {
				strToManipulate = strToManipulate.substr(prefixToRemove.length, strToManipulate.length - (prefixToRemove.length));
			}
			return strToManipulate;
		}
		
		static public function RemovePrefixFromModel(strToManipulate:String, modelExternal:ModelExternalPremiumAPI):String {
			return RemovePrefix(strToManipulate, modelExternal.prefixId);	
		}
	}
}
