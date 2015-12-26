package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.giveawaytool.meta.MetaPlayMovie;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class UI_PlayMovies extends UIBase {
		private var clientSockets : Array = new Array() ;
		private var serverSocket:ServerSocket = new ServerSocket();
		public function UI_PlayMovies() {
			super(AnimationFactory.ID_UI_PLAYMOVIE);
			
			serverSocket.bind(9232, "127.0.0.1");
			serverSocket.addEventListener( ServerSocketConnectEvent.CONNECT, onConnect );
			serverSocket.listen();
			
			
			createSendMovieBtn(0, "JustDoIt", "Just Do It");
			createSendMovieBtn(1, "VanDammeHit", "VanDamme Hit");
			createSendMovieBtn(2, "VanDammeExplode", "VanDamme Explode");
			createSendMovieBtn(3, "VanDammeCover", "VanDamme Cover");
			createSendMovieBtn(4, "VanDammeShoot", "VanDamme Shoot");
			createSendMovieBtn(5, "DealWithIt", "Deal with it");
			createSendMovieBtn(6, "MrThompson", "Mr. Thompson");
			createSendMovieBtn(7, "ItsOver9000", "It's Over 9000");
			//getPlayMovieBtn(6).visible = false;
			//getPlayMovieBtn(7).visible = false;
			getPlayMovieBtn(8).visible = false;
			getPlayMovieBtn(9).visible = false;
			
			/*registerClickWithCallback(playMovie1Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("JustDoIt")]));
			registerClickWithCallback(playMovie2Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("VanDammeHit")]));
			registerClickWithCallback(playMovie3Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("VanDammeExplode")]));
			registerClickWithCallback(playMovie4Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("VanDammeCover")]));
			registerClickWithCallback(playMovie5Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("VanDammeShoot")]));
			registerClickWithCallback(playMovie5Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("DealWithIt")]));
			
			setNameOfDynamicBtn(playMovie1Btn, "Just Do It");
			setNameOfDynamicBtn(playMovie2Btn, "VanDamme Hit");
			setNameOfDynamicBtn(playMovie3Btn, "VanDamme Explode");
			setNameOfDynamicBtn(playMovie4Btn, "VanDamme Cover");
			setNameOfDynamicBtn(playMovie5Btn, "VanDamme Shoot");
			setNameOfDynamicBtn(playMovie5Btn, "VanDamme Shoot");*/
		}
		
		private function createSendMovieBtn(i:int, msgToSend:String, btnLabel:String):void {
			var visualBtn:MovieClip = getPlayMovieBtn(i);
			setNameOfDynamicBtn(visualBtn, btnLabel);
			registerClickWithCallback(visualBtn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create(msgToSend)]));
		}
		
		private function onConnect( event:ServerSocketConnectEvent ):void {
			var clientSocket:Socket = event.socket;
			clientSockets.push(clientSocket);
         	//clientSocket.addEventListener( ProgressEvent.SOCKET_DATA, onClientSocketData );
			clientSocket.addEventListener(ProgressEvent.SOCKET_DATA, onClientSocketData);
			clientSocket.addEventListener(Event.CLOSE, onClose);
         	trace( "Connection from " + clientSocket.remoteAddress + ":" + clientSocket.remotePort );
		}
		
		private function onClose(event : Event) : void {
			trace("Socket CLosed");
		}
	  
	 	private function onClientSocketData( event:ProgressEvent ):void
	    {
			
	        /* var buffer:ByteArray = new ByteArray();
			 
	         clientSocket.readBytes( buffer, 0, clientSocket.bytesAvailable );
	         var recString:String = buffer.toString();
	         recString = recString.replace(/\n/g,'');
	         recString = recString.replace(/\r/g,'');
	         trace( "Received: " + buffer.toString() );
	         trace( "Received: " + recString );*/
	    }
		
		public function sendPlayMovie(m:MetaPlayMovie):void {
			var d:Dictionary = m.encode();
			d.type = "playMovie";
			sendData(d);
		}
		
		public function sendData(data:Dictionary):void {
			var obj:Object = DataManager.dictToObject(data);
					 
			var dataToSend:String = (JSON.stringify(obj));
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
		
		public function getPlayMovieBtn(i:int) : MovieClip { return visual.getChildByName("playMovieBtn" + i) as MovieClip;}
	}
}
