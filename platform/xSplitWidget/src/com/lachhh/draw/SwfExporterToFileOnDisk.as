package com.lachhh.draw {
	import com.lachhh.io.Callback;

	import flash.events.Event;
	/**
	 * @author LachhhSSD
	 */
	public class SwfExporterToFileOnDisk {
		
		static public var saveCompleteCallback:Callback;
		static public var errorCallback:Callback;
		//private var _swfExporter:SwfExporter;
		
		//private var _deleteEndCallback:Callback;
		//private var _deleteFile:File;
		//static public var AUTO_OVERWRITE:Boolean = true;
		
		public function SwfExporterToFileOnDisk(/*swfExporter:SwfExporter*/) {
		//	_swfExporter = swfExporter;
		}
		
		static public function browse() : void {
			
			
		}
		
		/*static public function onSelectFolder(evt:Event) : void {
			SwfExporterToFileOnDisk.pathOnDisk = tempFile.nativePath + "\\";
			var completePath:String = pathOnDisk + swfTexture.textureFormat + swfTexture.name + ".png";
			saveFile(swfTexture.dataInPngFormat, completePath);
		}*/
		
		/*public function deleteDirectory(swfTextureExporter:SwfTextureExporter, deleteEndCallback:Callback):void {
			_deleteFile = new File(pathOnDisk + swfTextureExporter.textureFormat + _swfExporter.docName);
			_deleteFile = _deleteFile.resolvePath(pathOnDisk + swfTextureExporter.textureFormat + _swfExporter.docName);
			_deleteEndCallback = deleteEndCallback;
			if(_deleteFile.exists) {
				if(AUTO_OVERWRITE) {
					onDeleteYes();
				} else {
					UIPopUp.createYesNo("A Directory already exist at : " + _deleteFile.url + "\n Do you want to erase it?", new Callback(onDeleteYes, this, null), deleteEndCallback);
				}
			} else {
				if(_deleteEndCallback) _deleteEndCallback.call();
			}
			
		}*/
		
		/*private function onDeleteYes():void {
			_deleteFile.deleteDirectory(true);	
			if(_deleteEndCallback) _deleteEndCallback.call();
		}*/

	
		
	

		static private function onSaveComplete(event : Event) : void {
			if(saveCompleteCallback) {
				var c:Callback = saveCompleteCallback;
				saveCompleteCallback = null; 
				c.call();
			}
		}
		
		static private function onLoadError(event : Event) : void {
			trace("ERROR " + event.type);
			if(errorCallback) errorCallback.call();
		}
	}
}
