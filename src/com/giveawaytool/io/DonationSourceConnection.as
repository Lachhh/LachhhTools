package com.giveawaytool.io {
	import com.giveawaytool.meta.donations.MetaDonationSourceConnection;
	import com.lachhh.io.Callback;

	import flash.events.IOErrorEvent;
	/**
	 * @author LachhhSSD
	 */
	public class DonationSourceConnection {
		public var onNewTips: Callback;
		public var metaStreamTipConnection:MetaDonationSourceConnection;
		public var active:Boolean;
				
		public var lastDonations:Array = new Array();
		public var lastError:IOErrorEvent;
		
		
		public function DonationSourceConnection() {
			active = false;
		}
		
		public function retrieveLast25Donations(success:Callback, error:Callback):DonationSourceRequest {
			if(metaStreamTipConnection == null || metaStreamTipConnection.modelSource.isNull) {
				active = false;
				return null;
			}
			
			lastDonations = new Array();
			var url:String = metaStreamTipConnection.getUrlForLast(25);
			var request:DonationSourceRequest = new DonationSourceRequest(url);
			request.onError.addCallback(new Callback(setActive, this, [false]));
			request.onError.addCallback(error);
			request.onSuccess.addCallback(new Callback(onLoadedSuccess, this, [lastDonations, request]));
			
			request.onSuccess.addCallback(new Callback(setActive, this, [true]));
			request.onSuccess.addCallback(success);
			request.sendRequest();
			return request;
		}
		
		private function setActive(b:Boolean):void {
			active = b;
		}
		
		public function onLoadedSuccess(output:Array, request:DonationSourceRequest):void {
			 output = metaStreamTipConnection.modelSource.convertRawDataToArray(output, request.rawData); 
		}
		
		public function isActive():Boolean {
			return active;
		}
	}
}
