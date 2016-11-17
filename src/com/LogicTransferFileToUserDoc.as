package com {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * @author LachhhSSD
	 */
	public class LogicTransferFileToUserDoc {
		private var frFile : File;
		public var path : String;
		private var fileName : String;

		public static function execute() : void {
			
			createAndTransfer("lachhhtools_widget.html");
			createAndTransfer("lachhhtools_widget.swf");
			
		}
		
		public function transfer(pFileName:String):void {
			fileName = pFileName;
			path = File.applicationDirectory.resolvePath("./" + fileName).nativePath;
			frFile = new File(path);
			frFile.addEventListener(Event.COMPLETE, onComplete);
			frFile.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			
			frFile.load();
		}

		private function onIoError(event : IOErrorEvent) : void {
			trace("Error : " + event.text);
		}

		private function onComplete(event : Event) : void {
			
			var stream:FileStream = new FileStream();
			var file:File = File.documentsDirectory.resolvePath("LachhhTools/" + fileName);
			stream.open(file, FileMode.WRITE);
			stream.writeBytes(frFile.data);
			stream.close();
		}
		
		static private function createAndTransfer(fileName:String):LogicTransferFileToUserDoc {
			var result:LogicTransferFileToUserDoc = new LogicTransferFileToUserDoc();
			result.transfer(fileName);
			return result;
		}
	}
}
