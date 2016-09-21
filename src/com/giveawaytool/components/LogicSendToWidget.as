package com.giveawaytool.components {
	import com.giveawaytool.ui.views.MetaCheerAlert;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.ui.views.MetaSubscribersList;
	import com.giveawaytool.ui.MetaSubscriber;
	import com.giveawaytool.ui.views.MetaFollower;
	import com.giveawaytool.ui.views.MetaFollowerList;
	import com.lachhh.io.CallbackGroup;
	import com.lachhh.io.Callback;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaPlayMovie;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.giveawaytool.meta.donations.MetaDonationList;
	import com.giveawaytool.meta.donations.MetaDonationsConfig;
	import com.giveawaytool.ui.MetaHostAlert;
	import com.giveawaytool.ui.MetaSubcriberAlert;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class LogicSendToWidget extends ActorComponent {
		private var serverSocket:ServerSocket = new ServerSocket();
		private var clientSockets:Array = new Array();
		public var onWidgetChanged:CallbackGroup = new CallbackGroup();
		public var onSendFailed:CallbackGroup = new CallbackGroup();
		public function LogicSendToWidget(port:int) {
			super();
			
			
			serverSocket.bind(port, "127.0.0.1");
			serverSocket.addEventListener( ServerSocketConnectEvent.CONNECT, onConnect );
			serverSocket.listen();
		}
		
		private function onConnect( event:ServerSocketConnectEvent ):void {
			var clientSocket : Socket = event.socket;
			clientSockets.push(clientSocket);

			clientSocket.addEventListener(ProgressEvent.SOCKET_DATA, onClientSocketData);
			clientSocket.addEventListener(Event.CLOSE, onClose);
         	trace( "Connection from " + clientSocket.remoteAddress + ":" + clientSocket.remotePort );
			sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
			
			onWidgetChanged.call();
		}
		
		private function onClose(event : Event) : void {
			trace("Socket CLosed " + event);
			cleanDeadSocket();
			onWidgetChanged.call();
		}
	  
	 	private function onClientSocketData( event:ProgressEvent ):void {	
	        /* var buffer:ByteArray = new ByteArray();
			 
	         clientSocket.readBytes( buffer, 0, clientSocket.bytesAvailable );
	         var recString:String = buffer.toString();
	         recString = recString.replace(/\n/g,'');
	         recString = recString.replace(/\r/g,'');
	         trace( "Received: " + buffer.toString() );
	         trace( "Received: " + recString );*/
	    }
		
		public function sendAddDonation(m:MetaDonation):void {
			var d:Dictionary = m.encode();
			MetaGameProgress.instance.metaDonationsConfig.allDonations.encodeNewDonation(d, m);
			d.type = "newDonation";
			sendData(d);
		}
		
		
		public function sendPlayMovie(m:MetaPlayMovie):void {
			var d:Dictionary = m.encode();
			d.type = "playMovie";
			sendData(d);
		}

		public function sendHostAlert(m : MetaHostAlert) : void {
			var d:Dictionary = m.encode();
			d.type = "hostAlert";
			sendData(d);
		}

		public function sendFollowAlert(m : MetaFollowAlert) : void {
			var d:Dictionary = m.encodeForWidget();
			d.type = "followAlert";
			sendData(d);
		}
		
		public function sendCheerAlert(m : MetaCheerAlert) : void {
			var d:Dictionary = m.encode();
			d.type = "cheerAlert";
			sendData(d);
		}
		
		public function sendAllNewFollow(allFollows:MetaFollowerList):void {
			var newFollowersList:MetaFollowerList = allFollows.copyKeepingOnlyNew();
			for (var i : int = 0; i < newFollowersList.followers.length; i++) {
				var m:MetaFollower = newFollowersList.getMetaFollower(i);
				sendFollowAlert(MetaFollowAlert.create(m));
			}
		}
		
		public function sendSubscriberAlert(m : MetaSubcriberAlert) : void {
			var d:Dictionary = m.encodeForWidget();
			d.type = "subAlert";
			sendData(d);
		}
		
		public function sendAllNewSubscriber(allFollows:MetaSubscribersList):void {
			var newFollowersList:MetaSubscribersList = allFollows.copyKeepingOnlyNew();
			for (var i : int = 0; i < newFollowersList.subscribers.length; i++) {
				var m:MetaSubscriber= newFollowersList.getMetaSubscriber(i);
				sendSubscriberAlert(MetaSubcriberAlert.createFromSub(m));
			}
		}
		
		public function sendTwitterAlert(m : MetaTwitterAlert) : void {
			var d:Dictionary = m.encode();
			d.type = "tweetAlert";
			sendData(d);
		}
		
		public function sendAllNewDonation(allDonation:MetaDonationList):void {
			var newDonationsList:MetaDonationList = allDonation.copyKeepingOnlyNew();
			var d:Dictionary = newDonationsList.encodeForWidget(MetaGameProgress.instance.metaDonationsConfig);
			d.type = "newDonationList";
			sendData(d);
		}
		
		public function sendDonationConfig(m:MetaDonationsConfig):void {
			var d:Dictionary = m.encodeForWidget();
			d.type = "refreshConfig";
			sendData(d);
		}
		
		
		public function sendForceStopAnim():void {
			var d:Dictionary = MetaGameProgress.instance.metaDonationsConfig.encodeForWidget();
			d.type = "forceStopAnim";
			sendData(d);
		}
		
		public function sendData(data:Dictionary):void {
			cleanDeadSocket();
			
			if(!hasAWidgetConnected()) {
				onSendFailed.call();
				return ;
			}
			
			if(!TwitchConnection.isLoggedIn()) return ;
			if(!TwitchConnection.instance.isUserAmemberOfKOTS()) return ;
			
			var obj:Object = DataManager.dictToObject(data);
			var dataToSend:String = (JSON.stringify(obj)) + "\n";
			for (var i : int = 0; i < clientSockets.length; i++) {
				var clientSocket:Socket =  clientSockets[i];
				if(!clientSocket.connected) continue;
				
				clientSocket.writeUTFBytes(dataToSend);
           		clientSocket.flush();
			}
		}
		
		public function cleanDeadSocket():void {
			for (var i : int = 0; i < clientSockets.length; i++) {
				var clientSocket:Socket =  clientSockets[i];
				if(clientSocket.connected == false) {
					trace("socket Dead, Removed");
					clientSockets.splice(i, 1);
					i--;
				} 
			}
		}
		
		public function hasAWidgetConnected():Boolean {
			return clientSockets.length >= 1;
		}

		
	}
}
