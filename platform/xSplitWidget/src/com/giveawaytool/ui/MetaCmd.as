package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmd {
		public var callbackOnEnd:Callback;
		public function execute(pMetaConfig:MetaDonationsConfig):void {
			
		}
		
		protected function endCmd():void {
			if(callbackOnEnd) callbackOnEnd.call();
		}
	}
}
