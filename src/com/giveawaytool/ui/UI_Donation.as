package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.components.LogicNotifications;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaPlayMovie;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.giveawaytool.meta.donations.MetaDonation;
	import com.giveawaytool.meta.donations.MetaDonationList;
	import com.giveawaytool.meta.donations.MetaDonationsConfig;
	import com.giveawaytool.ui.views.ViewDonationsEdit;
	import com.giveawaytool.ui.views.ViewSubTemp;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.text.TextField;
	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Donation extends UIBase {
		 //Stending : Lachhh, will we be able to buy other stuff than character customisation with XP? I mean, I really want to buy some things directly from YOU. Like a Kazoo song, or something else!
		public var viewDonationsEdit : ViewDonationsEdit;
		
		private var serverSocket:ServerSocket = new ServerSocket();
		private var clientSockets:Array = new Array();		
		public var logicNotification:LogicNotifications;
		public var logicNavigation:LogicOnOffNextFrame;
		
		public function UI_Donation() {
			super(AnimationFactory.ID_UI_DONATION);
			
			logicNavigation = LogicOnOffNextFrame.addToActor(this, donationsMc);
			logicNavigation.invisibleOnFirstFrame = false;
			logicNavigation.isOn = false;
			
			txt.text = "Charity";
			lblTxt.text = "";
			registerClick(backBtn, onBack);
			registerClick(charityBtn, onClickCharity);

			viewDonationsEdit = new ViewDonationsEdit(this, donationsMc);
			new ViewSubTemp(this, subMc);
			
			registerClick(creditsBtn, onCredits);
			
			serverSocket.bind(9231, "127.0.0.1");
			serverSocket.addEventListener( ServerSocketConnectEvent.CONNECT, onConnect );
			serverSocket.listen();
			 			
			refresh();
			
			viewDonationsEdit.initData();
			
			if(MainGame.dummyActor.getComponent(LogicNotifications) == null) {
				logicNotification = MainGame.dummyActor.addComponent(new LogicNotifications(MetaGameProgress.instance)) as LogicNotifications;
				logicNotification.uiDonation = this;			
			}
			
			var n:Number = 0.00001;
			var i:int = n*100;
			var n2:Number = (i*0.01);
			trace(n + "/" + n2);	
		}

		private function onBack() : void {
			logicNavigation.isOn = false;
		}

		private function onClickCharity() : void {
			logicNavigation.isOn = true;
		}

		private function onConnect( event:ServerSocketConnectEvent ):void {
			var clientSocket:Socket = event.socket;
			clientSockets.push(clientSocket);
         
			clientSocket.addEventListener(ProgressEvent.SOCKET_DATA, onClientSocketData);
			clientSocket.addEventListener(Event.CLOSE, onClose);
         	trace( "Connection from " + clientSocket.remoteAddress + ":" + clientSocket.remotePort );
			sendDonationConfig(MetaGameProgress.instance.metaDonationsConfig);
			
		}

		private function onClose(event : Event) : void {
			trace("Socket CLosed");
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
		
		private function onCredits() : void {
			//Utils.navigateToURLAndRecord(VersionInfo.URL_TWITCH_LF);
			sendPlayMovie(MetaPlayMovie.createDummy());
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
		
		public function sendSubscriberAlert(m : MetaSubcriberAlert) : void {
			var d:Dictionary = m.encode();
			d.type = "subAlert";
			sendData(d);
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
			var obj:Object = DataManager.dictToObject(data);
					 
			var dataToSend:String = (JSON.stringify(obj)) + "\n";
			for (var i : int = 0; i < clientSockets.length; i++) {
				var clientSocket:Socket =  clientSockets[i];
				if(clientSocket.connected == false) {
					trace("socket Dead, Removed");
					clientSockets.splice(i, 1);
					i--;
				} else {
					clientSocket.writeUTFBytes(dataToSend);
           			clientSocket.flush();
				}
			}
		}
		
		public function get donationsMc() : MovieClip { return visual.getChildByName("donationsMc") as MovieClip;}
		public function get creditsBtn() : MovieClip { return visual.getChildByName("creditsBtn") as MovieClip;}
		public function get subMc() : MovieClip { return visual.getChildByName("subMc") as MovieClip;}
		
		public function get charityBtn() : MovieClip { return donationsMc.getChildByName("charityBtn") as MovieClip;}
		public function get backBtn() : MovieClip { return donationsMc.getChildByName("backBtn") as MovieClip;}
		public function get txt() : TextField { return charityBtn.getChildByName("txt") as TextField;}
		public function get lblTxt() : TextField { return charityBtn.getChildByName("lblTxt") as TextField;}
		

		
		
		
			
	}
}
