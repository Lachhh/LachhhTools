package com.giveawaytool.io.playerio {
	import playerio.DatabaseObject;
	/**
	 * @author LachhhSSD
	 */
	public class MetaGameWispGroup {
		public var isLoaded : Boolean = false;
		public var listOfSub : Vector.<MetaGameWispSub> = new Vector.<MetaGameWispSub>();

		public function MetaGameWispGroup() {
			//DEBUG_FillWithDummy();
		}

		public function loadIfEmpty() : void {
			if(isLoaded) return ;
			fetchSubOnServers();
			isLoaded = true;
		}
		
		public function fetchSubOnServers():void {
			 MetaServerProgress.instance.loadAllGameWishSub(this, null, null);
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
		
		public function DEBUG_FillWithDummy():void {
			listOfSub = new Vector.<MetaGameWispSub>();
			 for (var i : int = 0; i < 37; i++) {
			 	var result:MetaGameWispSub = MetaGameWispSub.createDummy();
				 listOfSub.push(result);
			 }
		}
	}
}
