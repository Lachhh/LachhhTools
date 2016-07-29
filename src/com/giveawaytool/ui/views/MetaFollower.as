package com.giveawaytool.ui.views {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.meta.donations.MetaData;

	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class MetaFollower extends MetaData {
		public static const NULL : MetaFollower = new MetaFollower();
		public var name : String = "AFollower";
		public var date : Date  = new Date();
		public var isNew : Boolean  = false;
		public function MetaFollower() {
		}
		
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["name"] = name;
			saveData["date"] = date.time;
			return saveData; 
		}

		public function decode(loadData : Dictionary) : void {
			if (loadData == null) return ;
			name = loadData["name"];
			date = new Date(loadData["date"]);
			
		}

		public function isNull() : Boolean {
			return this == NULL;
		}

		public function isEquals(m : MetaFollower) : Boolean {
			if(name != m.name) return false;
			if(date.time != m.date.time) return false; 
			return true;
		}

		public function clone() : MetaFollower {
			var result:MetaFollower = new MetaFollower();
			result.decode(encode());
			return result;
		}

		static public function create(d : Dictionary) : MetaFollower {
			var result:MetaFollower = new MetaFollower();
			result.decode(d);
			return result;
		}
		
		static public function create2(name:String, date:Date) : MetaFollower {
			var result:MetaFollower = new MetaFollower();
			result.name = name;
			result.date = date;
			return result;
		}
		
		static public function createDUMMY() : MetaFollower {
			var result:MetaFollower = new MetaFollower();
			var id:int = Math.random() * 999;
			result.name = "MrDummy_" + id;
			result.isNew = (Math.random() < 0.2);
			return result;
		}

		public function getDescForToolTip() : String {
			return name + "\nFollowed On " + date.toDateString();
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
