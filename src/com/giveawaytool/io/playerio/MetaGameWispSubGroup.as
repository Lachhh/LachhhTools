package com.giveawaytool.io.playerio {
	import com.lachhh.io.Callback;
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import flash.utils.Dictionary;
	import playerio.DatabaseObject;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispSubGroup {
		public var isLoaded : Boolean = false;
		public var listOfSub : Vector.<MetaGameWispSub> = new Vector.<MetaGameWispSub>();

		public function MetaGameWispSubGroup() {
			//DEBUG_FillWithDummy();
		}

		public function loadIfEmpty() : void {
			if(isLoaded) return ;
			fetchSubOnServers();
			isLoaded = true;
		}
		
		public function fetchSubOnServers():void {
			 MetaServerProgress.instance.loadAllGameWishSub(this, new Callback(removeInactive, this, null), null);
		}
		
		private function removeInactive():void {
			for (var i : int = 0; i < listOfSub.length; i++) {
				if(listOfSub[i].isInactive()) {
					listOfSub.splice(i, 1);
					i--;
				}
			}
		}
		
		public function getSubFromName(name:String):MetaGameWispSub {
			for (var i : int = 0; i < listOfSub.length; i++) {
				if(listOfSub[i].isNameEquals(name)) return listOfSub[i];
			}
			return null;
		}
		
		public function getPledgeFromMetaPlayer(name:String):ModelPatreonReward {
			var m:MetaGameWispSub = getSubFromName(name);
			if(m == null) return ModelPatreonRewardEnum.NULL;
			return ModelPatreonRewardEnum.getHighestPledge(m.tierCostInCents);
		}
		
		public function setSubs(ob : Array) : void {
			listOfSub = new Vector.<MetaGameWispSub>();
			for (var i : int = 0; i < ob.length; i++) {
				var subRaw:DatabaseObject = ob[i];
				var newSub:MetaGameWispSub = MetaGameWispSub.createFromDb(subRaw);
				listOfSub.push(newSub); 
			}
		}
		
		public function add(m:MetaGameWispSub):void {
			listOfSub.push(m);
		}

		public function hasPledgeOfCost(twitchName : String, costInCents:Number) : Boolean {
			var gameWispSub:MetaGameWispSub = getSubFromName(twitchName);
			if(gameWispSub == null) return false;
			return gameWispSub.hasPledge(costInCents);
		}

		public static function sortNext(metaTotal : Vector.<MetaGameWispSub>) : void {
			metaTotal.sort(sortOnPledge);
		}

		private static function sortOnPledge(a:MetaGameWispSub, b:MetaGameWispSub) : int {
			if(a.tierCostInCents > b.tierCostInCents) return -1;
			if(a.tierCostInCents < b.tierCostInCents) return 1;
			return 0;
		}
		
		public function DEBUG_FillWithDummy() : void {
			listOfSub = new Vector.<MetaGameWispSub>();
			for (var i : int = 0; i < 37; i++) {
				var result : MetaGameWispSub = MetaGameWispSub.createDummy();
				listOfSub.push(result);
			}
		}
		
		public function append(metaChannelSubsGroupBatch : MetaGameWispSubGroup) : void {
			listOfSub = new Vector.<MetaGameWispSub>();
			for (var i : int = 0; i < metaChannelSubsGroupBatch.listOfSub.length; i++) {
				listOfSub.push(metaChannelSubsGroupBatch.listOfSub[i]);
			}
		}
		
		public function toMetaSubList():MetaSubscribersList {
			var result : MetaSubscribersList = new MetaSubscribersList();
			for (var i : int = 0; i < listOfSub.length; i++) {
				var gameWispSub : MetaGameWispSub = listOfSub[i];
				var newSub:MetaSubscriber = gameWispSub.toMetaSub();
				result.add(newSub);
			 }
			 return result;
		}
		
		static public function createFromRawData(d:Dictionary):MetaGameWispSubGroup {
			var result:MetaGameWispSubGroup = new MetaGameWispSubGroup();
			if(d == null) return result;
			if(d["data"] == null) return result;
			var listObj:Object = d["data"];
			var i:int = 0;
			
			
			while(listObj[i]) {
				var rawData:Dictionary = listObj[i];
				if(rawData == null) continue;
				var newSub:MetaGameWispSub = MetaGameWispSub.createFromGameWispRequest(rawData);
				result.add(newSub);
				i++;
			}
			return result;
		}

		public function clear() : void {
			listOfSub = new Vector.<MetaGameWispSub>();			
		}
	}
}
