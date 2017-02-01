package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.VersionInfo;
	/**
	 * @author LachhhSSD
	 */
	public class ModelAlertTypeEnum {
		static public var ALL:Array = new Array();
				
		static public var NULL:ModelAlertType = new ModelAlertType(-1, "", "");
		private static var _id : int = 0;
		static public var FOLLOW : ModelAlertType = create("follow alert", VersionInfo.URL_FOLLOW_ALERT);
		static public var SUB : ModelAlertType = create("sub alert", VersionInfo.URL_SUB_ALERT);
		static public var HOST : ModelAlertType = create("host alert", VersionInfo.URL_HOST_ALERT);
		static public var DONATION : ModelAlertType = create("donation alert", VersionInfo.URL_DONATION_ALERT);
		static public var CHEERS : ModelAlertType = create("bits alert", VersionInfo.URL_CHEERS_ALERT);
		static public var TWEET : ModelAlertType = create("tweet alert", "");
		
		
		
		static public var GIVEAWAY : ModelAlertType = create("giveaway", "");
		static public var EXPORTPNG : ModelAlertType = create("exportPNG", "");
		static public var COUNTDOWN : ModelAlertType = create("countdown", "");
		

		static public function create(id : String, urlPreview:String) : ModelAlertType {
			var index:int = _id++;
			var m:ModelAlertType = new ModelAlertType(index, id, urlPreview);
			if(!getFromId(index).isNull) throw new Error("Duplicate ID!");
			ALL.push(m);
			return m;
		}
		
		static public function getFromId(id:int):ModelAlertType {
			for (var i : int = 0; i < ALL.length; i++) {
				var g:ModelAlertType = ALL[i] as ModelAlertType;
				if(id == g.id) return g;
			}
			return NULL;
		} 
		
		static public function getFromIndex(index:int):ModelAlertType {
			if(index >= ALL.length) return NULL;
			if(index < 0) return NULL;
			return ALL[index] as ModelAlertType;
		}  
				
		static public function getNum():int {
			return ALL.length;
		}
	}
}
