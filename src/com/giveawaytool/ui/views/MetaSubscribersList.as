package com.giveawaytool.ui.views {
	import com.giveawaytool.ui.MetaSubscriber;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSubscribersList {
		public var subscribers : Array = new Array();
		private var saveData : Dictionary;

		public function sortByDate() : void {
			subscribers.sort(sortDate);
		}
		
		
		public function sortDate(m1:MetaSubscriber, m2:MetaSubscriber):int {
			if(m1.date.time > m2.date.time) return -1;
			if(m1.date.time < m2.date.time) return 1;
			return 0;
		}
		
		public function addCopyAsNew(m:MetaSubscriber):void {
			var newDonation:MetaSubscriber = m.clone();
			newDonation.isNew = true;
			add(newDonation);
		}

		public function add(metaSubscriber : MetaSubscriber) : void {
			subscribers.push(metaSubscriber);
		}
		
		public function clone(otherList : MetaSubscribersList) : void {
			decode(otherList.encode());
		}
				
		public function hasFollower(m:MetaSubscriber):Boolean {
			for (var i : int = 0; i < subscribers.length; i++) {
				var metaSubscriber:MetaSubscriber = subscribers[i];
				if(metaSubscriber.isEquals(m)) return true;
			}
			return false;
		}
		
		public function encode():Dictionary {
			saveData = new Dictionary();
			for (var i : int = 0; i < subscribers.length; i++) {
				var donation : MetaSubscriber = subscribers[i];
				saveData["subscriber" + i] = donation.encode();	
			}
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			subscribers = new Array();
			if(loadData == null) return ;
			var i:int = 0;
			while(loadData["subscriber" + i] != null) {
				var d:Dictionary = loadData["subscriber" + i];
				subscribers.push(MetaSubscriber.create(d));
				i++;
			}
			
		}
				
		public function getMetaSubscriber(i:int):MetaSubscriber {
			if(i < 0) return MetaSubscriber.NULL;
			if(i >= subscribers.length) return MetaSubscriber.NULL;
			return subscribers[i];
			
		}
		
		public function copyKeepingOnlyNew() : MetaSubscribersList{
			var result : MetaSubscribersList = new MetaSubscribersList();
			for (var i : int = 0; i < subscribers.length; i++) {
				var d:MetaSubscriber = subscribers[i];
				if(d.isNew) {
					result.subscribers.push(d);
				}
			}
			return result;
		}
		
		public function remove(m:MetaSubscriber):void {
			var i:int = subscribers.indexOf(m);
			if(i != -1) subscribers.splice(i,1);
		}
		
		
		
		public function getAmountTotalOfNew():Number {
			var result:Number = 0;
			for (var i : int = 0; i < subscribers.length; i++) {
				var metaSubscriber:MetaSubscriber = subscribers[i];
				if(metaSubscriber.isNew) {
					result++;
				}
			} 
			return result;
		}

		public function setAllNew(b : Boolean) : void {
			for (var i : int = 0; i < subscribers.length; i++) {
				var metaSubscriber:MetaSubscriber = subscribers[i];
				metaSubscriber.isNew = b;
			}
		}

		public function containsName(name:String):Boolean {
			for (var i : int = 0; i < subscribers.length; i++) {
				var metaSubscriber:MetaSubscriber = subscribers[i];
				if(metaSubscriber.name.toLowerCase() == name.toLowerCase()) return true;
			}
			return false;
		}
		
		public function addIfNameNotInList(metaSubscriber : MetaSubscriber) : Boolean {
			if(containsName(metaSubscriber.name)) return false;
			add(metaSubscriber);
			return true;
		}
		
		public function isEmpty():Boolean {
			return subscribers.length <= 0;
		}

		public function updateMetaSub(metaSubscriber : MetaSubscriber) : void {
			var alreadySub:MetaSubscriber = getMetaSubByName(metaSubscriber.name);
			if(alreadySub.isNull()) {
				add(alreadySub);
			} else {
				alreadySub.numMonthInARow = metaSubscriber.numMonthInARow;
				alreadySub.date = new Date();
			}
		}
		
		public function getMetaSubByName(name:String):MetaSubscriber {
			for (var i : int = 0; i < subscribers.length; i++) {
				var metaSubscriber:MetaSubscriber = subscribers[i];
				if(metaSubscriber.name.toLowerCase() == name.toLowerCase()) return metaSubscriber;
			}
			return MetaSubscriber.NULL;
		}
		
		public function createArrayOfName():Array {
			var result:Array = new Array();
			for (var i : int = 0; i < subscribers.length; i++) {
				var metaSub:MetaSubscriber = subscribers[i];
				result.push(metaSub.name);
			}
			return result;
		}

		public function clear() : void {
			subscribers = new Array();
		}
	}
}
