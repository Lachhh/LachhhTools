package com.giveawaytool.meta {
	import com.giveawaytool.ui.views.MetaHostList;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaHostConfig {
		public var metaHosts : MetaHostList = new MetaHostList();
		
		public var alertOnNewHost:Boolean = true;
		public var bigHostNum:int = 10;
		
		private var saveData : Dictionary = new Dictionary();

		public function MetaHostConfig() {
		}
				
		public function encode():Dictionary {
			saveData["alertOnNewHost"] = alertOnNewHost;
			saveData["bigHostNum"] = bigHostNum;
			saveData["metaHosts"] = metaHosts.encode();
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			alertOnNewHost = (loadData["alertOnNewHost"]);
			bigHostNum = (loadData["bigHostNum"]);
			metaHosts.decode(loadData["metaHosts"]);
		}
	}
}
