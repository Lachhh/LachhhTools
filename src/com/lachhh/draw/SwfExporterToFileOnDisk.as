package com.lachhh.draw {
	import com.giveawaytool.ui.UIPopUp;
	import com.lachhh.io.Callback;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	/**
	 * @author LachhhSSD
	 */
	public class SwfExporterToFileOnDisk {
		static public var DEFAULT_PATH:String = File.applicationStorageDirectory.nativePath;
		static public var pathOnDisk:String = DEFAULT_PATH;
		
		static private var tempFile:File ;
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

		static public function saveTexture(swfTexture:SwfTexture):void {
			var onSelectFolder:Function = function(evt:Event) : void {
				SwfExporterToFileOnDisk.pathOnDisk = tempFile.nativePath ;
				var popup:UIPopUp = UIPopUp.createLoading("Alright, let me create that png for you.\n(Please wait)");
				popup.renderComponent.animView.addCallbackOnFrame(new Callback(onPopupIdle, this, [popup, swfTexture]), popup.idleFrame);
			} ;
			
			
			tempFile = new File();
			tempFile.addEventListener(Event.SELECT, onSelectFolder);
			
			tempFile.browseForSave("Where do you want that file, soldier?");
			
		}
		
		static private function onPopupIdle(popup:UIPopUp, swfTexture:SwfTexture):void {
			var completePath:String = pathOnDisk ;
			var index:int = completePath.indexOf(".png");
			var l:int = completePath.length;
			if(index == (l - 4)) {
				  
			} else {
				completePath += ".png";
			}
			swfTexture.extractTexture(new Matrix());
			saveFile(swfTexture.dataInPngFormat, completePath); 
			popup.close();
		}
		
		
		/*public function saveXml(xml:XML):void {
			var b:ByteArray = new ByteArray();
			XML.prettyPrinting = true;
			b.writeUTFBytes(xml.toXMLString());
			
			var completePath:String = pathOnDisk + _swfExporter.docName + ".xml";
			saveFile(b, completePath);
		}*/
		
		static public function saveFile(data:ByteArray, path:String):void {	
			var saveFile:File = new File();
			saveFile = saveFile.resolvePath(path);
			var fileStream:FileStream = new FileStream();
			fileStream.openAsync(saveFile, FileMode.WRITE);
			fileStream.writeBytes(data);
			fileStream.addEventListener(Event.CLOSE, onSaveComplete);
			fileStream.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			fileStream.close();
		}

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
