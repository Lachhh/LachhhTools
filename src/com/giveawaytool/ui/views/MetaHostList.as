package com.giveawaytool.ui.views {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaHostList {
		public var hosts : Array = new Array();
		private var saveData : Dictionary;

		public function sortByDate() : void {
			hosts.sort(sortDate);
		}
		
		
		public function sortDate(m1:MetaHost, m2:MetaHost):int {
			if(m1.date.time > m2.date.time) return -1;
			if(m1.date.time < m2.date.time) return 1;
			return 0;
		}
		
		public function add(metaHost : MetaHost) : void {
			hosts.push(metaHost);
		}
		
		public function clone(otherList : MetaHostList) : void {
			decode(otherList.encode());
		}
				
		public function hasFollower(m:MetaHost):Boolean {
			for (var i : int = 0; i < hosts.length; i++) {
				var metaFollower:MetaHost = hosts[i];
				if(metaFollower.isEquals(m)) return true;
			}
			return false;
		}
		
		public function encode():Dictionary {
			saveData = new Dictionary();
			for (var i : int = 0; i < hosts.length; i++) {
				var donation:MetaHost = hosts[i];
				saveData["host"+i] = donation.encode();	
			}
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			hosts = new Array();
			if(loadData == null) return ;
			var i:int = 0;
			while(loadData["host" + i] != null) {
				var d:Dictionary = loadData["host" + i];
				hosts.push(MetaHost.create(d));
				i++;
			}
			
		}
				
		public function getMetaHost(i:int):MetaHost {
			if(i < 0) return MetaHost.NULL;
			if(i >= hosts.length) return MetaHost.NULL;
			return hosts[i];
			
		}
		
		public function remove(m:MetaHost):void {
			var i:int = hosts.indexOf(m);
			if(i != -1) hosts.splice(i,1);
		}
		
		public function containsName(name:String):Boolean {
			for (var i : int = 0; i < hosts.length; i++) {
				var metaFollower:MetaHost = hosts[i];
				if(metaFollower.name == name) return true;
			}
			return false;
		}
		
		public function addIfNameNotInList(metaFollower : MetaHost) : Boolean {
			if(containsName(metaFollower.name)) return false;
			add(metaFollower);
			return true;
		}
		
		public function isEmpty():Boolean {
			return hosts.length <= 0;
		}
		
	}
}
