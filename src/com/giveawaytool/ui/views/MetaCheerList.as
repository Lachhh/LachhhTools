package com.giveawaytool.ui.views {
	import com.lachhh.utils.Utils;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCheerList {
		public var cheers : Array = new Array();
		private var saveData : Dictionary;

		public function sortByDate() : void {
			cheers.sort(sortDate);
		}
		
		
		public function sortDate(m1:MetaCheer, m2:MetaCheer):int {
			if(m1.date.time > m2.date.time) return -1;
			if(m1.date.time < m2.date.time) return 1;
			return 0;
		}
		
		public function add(metaHost : MetaCheer) : void {
			cheers.push(metaHost);
		}
		
		public function clone(otherList : MetaCheerList) : void {
			decode(otherList.encode());
		}

		public function hasFollower(m : MetaCheer) : Boolean {
			for (var i : int = 0; i < cheers.length; i++) {
				var metaFollower:MetaCheer = cheers[i];
				if(metaFollower.isEquals(m)) return true;
			}
			return false;
		}
		
		public function encode():Dictionary {
			saveData = new Dictionary();
			for (var i : int = 0; i < cheers.length; i++) {
				var donation:MetaCheer = cheers[i];
				saveData["cheer"+i] = donation.encode();	
			}
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			cheers = new Array();
			if(loadData == null) return ;
			var i:int = 0;
			while(loadData["cheer" + i] != null) {
				var d:Dictionary = loadData["cheer" + i];
				cheers.push(MetaCheer.create(d));
				i++;
			}
			
		}
				
		public function getMetaCheer(i:int):MetaCheer {
			if(i < 0) return MetaCheer.NULL;
			if(i >= cheers.length) return MetaCheer.NULL;
			return cheers[i];
			
		}
		
		public function remove(m:MetaCheer):void {
			var i:int = cheers.indexOf(m);
			if(i != -1) cheers.splice(i,1);
		}
		
		public function containsName(name:String):Boolean {
			for (var i : int = 0; i < cheers.length; i++) {
				var metaFollower:MetaCheer = cheers[i];
				if(metaFollower.name == name) return true;
			}
			return false;
		}
		
		public function addIfNameNotInList(metaFollower : MetaCheer) : Boolean {
			if(containsName(metaFollower.name)) return false;
			add(metaFollower);
			return true;
		}
		
		public function isEmpty():Boolean {
			return cheers.length <= 0;
		}

		public function clear() : void {
			Utils.ClearArray(cheers);
		}
		
	}
}
