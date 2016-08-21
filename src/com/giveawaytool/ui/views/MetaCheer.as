package com.giveawaytool.ui.views {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.meta.donations.MetaData;

	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class MetaCheer extends MetaData {
		public static const NULL : MetaCheer = new MetaCheer();
		public var name : String = "ACheer";
		public var date : Date  = new Date();
		public var numBits : int = 0;

		public function MetaCheer() {
		}
		
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["name"] = name;
			saveData["date"] = date.time;
			saveData["numBits"] = numBits;
			
			return saveData; 
		}

		public function decode(loadData : Dictionary) : void {
			if (loadData == null) return ;
			name = loadData["name"];
			date = new Date(loadData["date"]);
			numBits = loadData["numBits"];
		}

		public function isNull() : Boolean {
			return this == NULL;
		}

		public function isEquals(m : MetaCheer) : Boolean {
			if(name != m.name) return false;
			if(date.time != m.date.time) return false; 
			return true;
		}

		public function clone() : MetaCheer {
			var result:MetaCheer = new MetaCheer();
			result.decode(encode());
			return result;
		}

		static public function create(d : Dictionary) : MetaCheer {
			var result:MetaCheer = new MetaCheer();
			result.decode(d);
			return result;
		}

		static public function create2(name : String, date : Date, numBits : int) : MetaCheer {
			var result:MetaCheer = new MetaCheer();
			result.name = name;
			result.date = date;
			result.numBits = numBits;
			return result;
		}
		
		static public function createDUMMY() : MetaCheer {
			var result:MetaCheer = new MetaCheer();
			var id:int = Math.random() * 999;
			result.name = "MrDummy_" + id;
			result.numBits = Math.random()*5000+5;
			return result;
		}

		public function getDescForToolTip() : String {
			return name + "\nCheered On " + date.toDateString() + " with " + numBits + " bit(s)";
		}
		
		public function getDateForView() : String {
			var year:int = date.fullYear;
			var month:String = Utils.PutZero(date.month+1);
			var day:String = Utils.PutZero(date.date);
			var hour:String = Utils.PutZero(date.hours);
			var minute:String = Utils.PutZero(date.minutes);
			
			return month + "/" + day + " " + hour + ":" + minute;
		}
	}
}
