package com.giveawaytool.meta {
	/**
	 * @author LachhhSSD
	 */
	public class MetaIRCConnection {
		public var userName : String;
		public var auth : String;
		public var channelName : String;

		public function MetaIRCConnection(pChannel:String, pAuth:String) {
			auth = pAuth;
			channelName = pChannel;
			userName = pChannel;
		}
	}
}
