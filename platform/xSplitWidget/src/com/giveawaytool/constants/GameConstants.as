package com.giveawaytool.constants {
	/**
	 * @author LachhhSSD
	 */
	public class GameConstants {
		static public var HERO_LVL:Array = constructHeroLVL();	
		
		static public var SUB_NEEDED:Array = [0, 25, 50, 100, 250, 500, 1000, 2000];
		static public var CASH_BONUS_1:Number = 2000;
		static public function constructHeroLVL():Array {
			var result:Array = [];
			for (var i : int = 0; i < 30; i++) {
				if (i < 4) result.push(i*40);
				else result.push(((i*(i*1.5))-i)*20);
				//trace(result[i]);
			}
			return result;
		}
	}
}
