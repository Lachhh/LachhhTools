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
		private var fileNameOutput : String;
		private var fileNameSrc : String;

		public static function execute() : void {
			
			createAndTransferLocal("lachhhtools_widget.html");
			createAndTransferLocal("lachhhtools_widget.swf");
			
		}
		
		public function transfer(pFileSrcPath:String, pFileNameOutput: String):void {
			fileNameSrc = pFileSrcPath;
			fileNameOutput = pFileNameOutput;
			
			try {
				frFile = new File(fileNameSrc);
				frFile.addEventListener(Event.COMPLETE, onComplete);
				frFile.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
				
				frFile.load();
			} catch(e:Error) {
				
			}
		}

		private function onIoError(event : IOErrorEvent) : void {
			trace("Error : " + event.text);
		}

		private function onComplete(event : Event) : void {
			
			var stream:FileStream = new FileStream();
			var file:File = File.documentsDirectory.resolvePath("LachhhTools/" + fileNameOutput);
			stream.open(file, FileMode.WRITE);
			stream.writeBytes(frFile.data);
			stream.close();
		}
		
		static public function createAndTransfer(fileName:String, filenameOutput:String):LogicTransferFileToUserDoc {
			var result:LogicTransferFileToUserDoc = new LogicTransferFileToUserDoc();
			result.transfer(fileName, filenameOutput);
			return result;
		}
		
		static public function createAndTransferLocal(fileName:String):LogicTransferFileToUserDoc {
			var result:LogicTransferFileToUserDoc = new LogicTransferFileToUserDoc();
			result.transfer(File.applicationDirectory.resolvePath("./" + fileName).nativePath, fileName);
			return result;
		}
	}
}
