package com.giveawaytool.meta {
	/**
	 * @author LachhhSSD
	 */
	public class ModelDonationAwardEnum {
		static public var ALL:Array = new Array();
		static private var _id:int = 0; 
		static public var NULL:ModelDonationAward = new ModelDonationAward(-1, -1, "");
				
		static public var FIRST_DAY:ModelDonationAward = create(_id++, 1, "First donation\nof the day");
		static public var TOP_DAY:ModelDonationAward = create(_id++, 2, "Top donator\nof the day");
		static public var TOP_WEEK:ModelDonationAward = create(_id++, 3, "Top donator\nof the week");
		static public var TOP_MONTH:ModelDonationAward = create(_id++, 4, "Top donator\nof the month");
		static public var TOP_ALL_TIME:ModelDonationAward = create(_id++, 5, "Top donator\nof all time");
		
		static public function create(id:int, frame:int, title:String):ModelDonationAward {
			var m:ModelDonationAward = new ModelDonationAward(id, frame, title);
			if(!getFromId(id).isNull) throw new Error("Duplicate ID!");
			ALL.push(m);
			return m;
		}
		
		static public function getFromId(id:int):ModelDonationAward {
			for (var i : int = 0; i < ALL.length; i++) {
				var g:ModelDonationAward = ALL[i] as ModelDonationAward;
				if(id == g.id) return g;
			}
			return NULL;
		}  
				
		static public function getNum():int {
			return ALL.length;
		}
	}
}
