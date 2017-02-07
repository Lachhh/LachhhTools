package com.giveawaytool.components {
	import com.giveawaytool.io.twitch.streamlabs.StreamLabsConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	/**
	 * @author LachhhSSD
	 */
	public class LogicStreamLabs {
		public var onConnect:Callback ;
		public function LogicStreamLabs() {
			StreamLabsConnection.getInstance().accessToken = MetaGameProgress.instance.metaDonationsConfig.metaStreamLabsConnection.accessToken;
			StreamLabsConnection.getInstance().onConnect = new Callback(onConnected, this, null);
			StreamLabsConnection.getInstance().onConnectError = new Callback(onError, this, null);
		}

		private function onError() : void {
			
		}

		private function onConnected() : void {			
			MetaGameProgress.instance.metaDonationsConfig.metaStreamLabsConnection.accessToken = StreamLabsConnection.instance.accessToken;
			
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refresh();
			if(onConnect) onConnect.call();
		}
		
		public function showLogin():void {
			StreamLabsConnection.getInstance().showLogin();
		}
	}
}
