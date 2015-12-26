package com.giveawaytool.meta.donations {
	/**
	 * @author LachhhSSD
	 */
	public class TodayDate {
		static public var today:Date = new Date();
		static public var beginningOfWeek:Date = new Date();
		
		static public function refresh():void {
			today = new Date();
			beginningOfWeek = new Date();
			beginningOfWeek.date -= beginningOfWeek.day;
			trace(isThisWeek(today));
		}
		
		static public function isThisDay(date:Date):Boolean {
			return isSameDay(date, today);
		}
		
		static public function isThisWeek(date:Date):Boolean {
			if(date == null) return false;
			var dateBeginningOfWeek:Date = new Date(date.time);
			dateBeginningOfWeek.date -= date.day;
			
			return isSameDay(beginningOfWeek, dateBeginningOfWeek);
		}
		
		static public function isSameDay(d1:Date, d2:Date):Boolean {
			if(d1 == null || d2 == null) return false;
			if(d1.fullYear != d2.fullYear) return false;
			if(d1.month != d2.month) return false;
			if(d1.date != d2.date) return false;
			return true;
		}
	}
}
