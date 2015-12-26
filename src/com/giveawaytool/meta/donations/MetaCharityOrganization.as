package com.giveawaytool.meta.donations {
	import com.lachhh.lachhhengine.meta.ModelBaseStr;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCharityOrganization extends ModelBaseStr {
		public var name:String;
		public var description:String;
		public var urlWebsite:String;
		private var saveData : Dictionary = new Dictionary();
		
		public function MetaCharityOrganization(id:String, pName:String, pDescription:String, pUrlWebsite:String) {
			super(id);
			name = pName;
			description = pDescription;
			urlWebsite = pUrlWebsite;
		}
				
		public function encode():Dictionary {
			saveData["name"] = name;
			saveData["description"] = description;
			saveData["urlWebsite"] = urlWebsite;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			name = loadData["name"];
			description = loadData["description"];
			urlWebsite = loadData["urlWebsite"];
		}
	}
}
