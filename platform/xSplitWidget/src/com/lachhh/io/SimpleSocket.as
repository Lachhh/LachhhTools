package com.lachhh.io {

	import com.flashinit.ReleaseDonationInit;
	import com.flashinit.ReleaseDonationInitWithoutNews;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.giveawaytool.ui.UI_DebugText;
	import com.adobe.serialization.json.JSONDecoder;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.Timer;
   
   public class SimpleSocket
   {
     // private static var INSTANCE:SimpleSocket;
	  private var socket:Socket;
      private var connectTimer:Timer;
      private var host:String = "127.0.0.1";
      static public var DEFAULT_PORT:int = 9231;
	  private var port:int = DEFAULT_PORT;
	  public var onNewData:CallbackGroup = new CallbackGroup();
	  public var rawData:String;
	  
      public function SimpleSocket(pPort:int) {
         super();
		 //Security.allowDomain("*");
		 //Security.loadPolicyFile("http://www.berzerkstudio.com/crossdomain.xml");
		 port = pPort;
		 init();
		 
		 
        /* trace("SimpleSocket ::: CONSTRUCTOR");
         if(INSTANCE != null) {
            throw new Error("Only one instance of SimpleSocket is allowed. ");
         } else {
            init();
            return;
         }*/
      }
      
      
      
    /*  public static function getInstance() : SimpleSocket {
         if(!INSTANCE) {
            INSTANCE = new SimpleSocket(9231);
         }
         return INSTANCE;
      }*/
      
      private function init() : void {
         
         socket = new Socket();
         socket.addEventListener(Event.CONNECT, socket_connectHandler);
         socket.addEventListener(Event.CLOSE, socket_closeHandler);
         socket.addEventListener(IOErrorEvent.IO_ERROR,socket_ioErrorHandler);
         socket.addEventListener(ProgressEvent.SOCKET_DATA,socket_datahandler);
         socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,socket_securityErrorHandler);
         connectTimer = new Timer(1000);
         connectTimer.addEventListener(TimerEvent.TIMER,connect_timerHandler);
      }
      
      private function connect_timerHandler(param1:TimerEvent) : void {
         var event:TimerEvent = param1;
         
         if(socket.connected) {
            connectTimer.reset();
			DEBUGTRACE("I'm connected");
            return;
         }
		 
         try {
            socket.connect(host,port);
			DEBUGTRACE("connecting to : " + host + "/" + port);
         } catch(e:Error) {
            DEBUGTRACE(e.getStackTrace());
			//DEBUGTRACE("socket_connectHandler");
         }
         //dispatchEvent(new WidgetSocketEvent(WidgetSocketEvent.CONNECTING));
      }
      
      private function socket_connectHandler(param1:Event) : void {
		 DEBUGTRACE("socket_connectHandler");
         connectTimer.reset();
         socket.writeUTF("Connected");
         socket.flush();
         
      }
      
      private function socket_datahandler(param1:ProgressEvent) : void {
		
         rawData = socket.readUTFBytes(socket.bytesAvailable);
         DEBUGTRACE("Received Data : " + rawData);
		 
		 if(onNewData) onNewData.call();
        /* var _loc5_:ISocketData = new SocketData();
         _loc5_.data = _loc4_.data;
         _loc5_.type = _loc4_.type;*/
         //dispatchEvent(new WidgetSocketEvent(WidgetSocketEvent.DATA_CHANGE,_loc5_));
      }
      
      private function socket_closeHandler(param1:Event) : void {
		DEBUGTRACE("socket_closeHandler");
         connectTimer.start();
        // dispatchEvent(param1);
      }
      
      private function socket_ioErrorHandler(param1:IOErrorEvent) : void {
		DEBUGTRACE("socket_ioErrorHandler : " + param1.toString());
        /* if(hasEventListener(IOErrorEvent.IO_ERROR))
         {
            dispatchEvent(param1.clone());
         }*/
         param1.stopImmediatePropagation();
         param1.preventDefault();
      }
      
      private function socket_securityErrorHandler(param1:SecurityErrorEvent) : void {
		DEBUGTRACE("socket_securityErrorHandler");
        /*if(hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
         {
            dispatchEvent(param1.clone());
         }*/
         param1.stopImmediatePropagation();
         param1.preventDefault();
      }
      
      public function connect() : void {
         try {
            socket.connect(host,port);
         } catch(e:Error) {
            DEBUGTRACE(e.getStackTrace());
         }
         connectTimer.reset();
         connectTimer.start();
         //dispatchEvent(new WidgetSocketEvent(WidgetSocketEvent.CONNECTING));
      }
      
      public function close() : void {
         if(socket.connected) {
            socket.close();
         }
      }
      
      public function get connected() : Boolean {
         return socket.connected;
      }
	  
	  public function DEBUGTRACE(msg:String):void {
		  var ui:UI_DebugText = UIBase.manager.getFirst(UI_DebugText) as UI_DebugText;
		  if(ui) {
			 ui.msg += msg + "\n";
			 ui.refresh();
		  }
		  ReleaseDonationInit.addLine(msg);
		  trace(msg);
	  }
	 
   }
}
