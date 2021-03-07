package com.lachhh.lachhhengine.meta {

	/**
	 * @author Lachhh
	 */
	public class MetaUpgrade {
		public var upgradeRange : Array ;
		
		public var value : Number = 0 ;
		public function MetaUpgrade(xpRange : Array) {
			upgradeRange = xpRange;
		}
				
		public function GetXpNeeded(lvlToReach : int) : int {
			if(lvlToReach > 0 && lvlToReach <= upgradeRange.length) {
				return upgradeRange[lvlToReach - 1];
			} else {
				return -1;	
			}	
		}

		public function GetLevelAt(xp : int) : int {
			for (var i : int = 0 ;i < upgradeRange.length; i++) {
				var crntXp:int = upgradeRange[i];
				if(crntXp > xp) {
					return i;	
				}
			} 	
			return upgradeRange.length;
		}

		public function get isMaxed() : Boolean {
			return GetLevelAt(value) >= numLevels; 	
		}

		public function get numLevels() : int {
			return upgradeRange.length ;	
		} 

		public function get crntLevel() : int {
			return GetLevelAt(value);
		}

		public function get xpToNext() : int {
			return GetXpNeeded(crntLevel+1);
		}
		
		public function get lvlProgressPrct() : Number {
			if(isMaxed) return 0;
			var nextLvlXp : int = GetXpNeeded(crntLevel + 1);
			var crntLvlXp : int = GetXpNeeded(crntLevel);
			var xpDiff : int = nextLvlXp - crntLvlXp;
			return (value - crntLvlXp) / xpDiff;
		}
	
	}
}
