package com.lachhh.flash {
	import flash.utils.getTimer;
	import avmplus.getQualifiedClassName;

	/**
	 * @author Lachhh
	 */
	public class FlashUtils {
		static public function mySplit(strToSplit:String, arg:String):Array {
			return strToSplit.split(arg);
		}
		
		static public function myParseFloat(s:String):Number {
			return Number(s) ;
		}
		
		static public function myReplace(msg:String, toFind:String, toBeReplacedWith:String):String {
			return msg.split(toFind).join(toBeReplacedWith) ;
		}
		
		static public function myGetQualifiedClassName(o:Object):String {
			return getQualifiedClassName(o);
		}
		
		static public function myGetTime():int {
			return getTimer();
		}
	}
}
