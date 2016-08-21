package com.giveawaytool.ui.views {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.meta.donations.MetaData;

	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class MetaHost extends MetaData {
		public static const NULL : MetaHost = new MetaHost();
		public var name : String = "AHost";
		public var date : Date  = new Date();
		public var numViewers : int = 0;

		public function MetaHost() {
		}
		
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["name"] = name;
			saveData["date"] = date.time;
			saveData["numViewers"] = numViewers;
			
			return saveData; 
		}

		public function decode(loadData : Dictionary) : void {
			if (loadData == null) return ;
			name = loadData["name"];
			date = new Date(loadData["date"]);
			numViewers = loadData["numViewers"];
		}

		public function isNull() : Boolean {
			return this == NULL;
		}

		public function isEquals(m : MetaHost) : Boolean {
			if(name != m.name) return false;
			if(date.time != m.date.time) return false; 
			return true;
		}

		public function clone() : MetaHost {
			var result:MetaHost = new MetaHost();
			result.decode(encode());
			return result;
		}

		static public function create(d : Dictionary) : MetaHost {
			var result:MetaHost = new MetaHost();
			result.decode(d);
			return result;
		}
		
		static public function create2(name:String, date:Date, numViewers:int) : MetaHost {
			var result:MetaHost = new MetaHost();
			result.name = name;
			result.date = date;
			result.numViewers = numViewers;
			return result;
		}
		
		static public function createDUMMY() : MetaHost {
			var result:MetaHost = new MetaHost();
			var id:int = Math.random() * 999;
			result.name = "MrDummy_" + id;
			result.numViewers = Math.random()*50+5;
			return result;
		}

		public function getDescForToolTip() : String {
			return name + "\nHosted On " + date.toDateString() + " for " + numViewers + " viewer(s)";
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
