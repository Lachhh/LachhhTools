package com.giveawaytool.meta {
	/**
	 * @author LachhhSSD
	 */
	public class MetaTwitchChat {
		public var debugLog:String ="";
		
		public function addLine(str:String):void {
			debugLog += "\n" + str;
		}
	}
}
