package com.giveawaytool.ui {
	import air.update.ApplicationUpdater;
	import air.update.events.DownloadErrorEvent;
	import air.update.events.StatusUpdateErrorEvent;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;

	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.EffectFlashColor;
	import com.giveawaytool.effect.EffectFlashColorFadeIn;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.events.ErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_Updater extends UIBase {
		
		private var appUpdater:ApplicationUpdater = new ApplicationUpdater();
		
		public function UI_Updater() {
			super(AnimationFactory.ID_UI_UPDATE);
			registerClick(skipBtn, onSkip);
			
			appUpdater.updateURL = "http://lachhhAndFriends.com/twitchTool/update_flash.xml";
			//we set the event handlers for INITIALIZED nad ERROR
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
			appUpdater.addEventListener(ErrorEvent.ERROR, onError);
			
			appUpdater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, onStatusUpdate);
			appUpdater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, onStatusUpdateError);
			appUpdater.addEventListener(ProgressEvent.PROGRESS, onDownloadProgress);
			appUpdater.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE, onDownloadComplete);
			appUpdater.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, onDownloadError);
			//initialize the updater
			appUpdater.initialize();
			setNameOfDynamicBtn(skipBtn, "Skip");
		}
		
		//listener for INITIALIZED event of the applicationUpdater;
		function onUpdate(event:UpdateEvent):void {
			//start the process of checking for a new update and to install
			appUpdater.checkNow();
		}
		//Handler function for error events triggered by the ApplicationUpdater.initialize
		function onError(event:ErrorEvent):void {
			trace(event);
			//createWindow();
			displayWindowError(event.errorID, event.text);
		}
		//handler function for StatusUpdateEvent.UPDATE_STATUS
		//this is called after the update descriptor was downloaded and interpreted successfuly 
		function onStatusUpdate(event:StatusUpdateEvent):void {
			trace(event);
			//prevent the default (start downloading the new version)
			event.preventDefault();
			//createWindow();
			//windowContent.bar.visible = false; //hide the progress bar
			//create the window for displaying Update available
			if (event.available) {
				trace("Update Available");
				trace("description : " + event.version + " " + event.details[0][1]);
				//UIPopUp.createYesNo("Update Available!" + event.version + event.details[0][1], new Callback(startDownload, this, null), new Callback(closeWindow, this, null))
				var b:UIPopupInsert = UIPopupInsert.createInsertBig("Update Available!", new Callback(startDownload, this, null), new Callback(closeWindow, this, null));
				b.inputTxt.text =  " " + event.details[0][1];
				b.descTxt.text = "New Update Available!" + "\n(v" + event.version + ")";
				b.setNameOfBtnByIndex(1, "Update");
				b.setNameOfBtnByIndex(3, "Skip");
				//windowContent.title = "Update Available";
				//windowContent.enableDescription = true;
				//windowContent.description = event.version + " " + event.details[0][1];
				///windowContent.buttonLeft.label = "Update";
				//windowContent.buttonRight.label = "Cancel";
				//addEventToButton(windowContent.buttonLeft, MouseEvent.CLICK, startDownload);
				//addEventToButton(windowContent.buttonRight, MouseEvent.CLICK, closeWindow);
				//we don't have an update, so display this information
				skipBtn.visible = false;
				loadingSpinMc.visible = false;
			} else {
				//closeWindow();
				appUpdater = null;
				skipBtn.visible = false;
				loadingSpinMc.visible = false;
				updateTxt.text = "You're up to date!";
				CallbackTimerEffect.addWaitCallFctToActor(this, closeWindow, 1000);
				
				//windowContent.title = "No Update Available";
				//windowContent.enableDescription = false;
				//windowContent.buttonLeft.visible = false;
				//windowContent.buttonRight.label = "Close";
				//addEventToButton(windowContent.buttonRight, MouseEvent.CLICK, closeWindow);
			}
		}
		
		//error listener for an error when the updater could not download or
		//interpret the update descriptor file.
		function onStatusUpdateError(event:StatusUpdateErrorEvent):void {
			//createWindow();
			displayWindowError(event.subErrorID, event.text);
		}
		//error listener for DownloadErrorEvent. Dispatched if there is an error while connecting or
		//downloading the update file. It is also dispatched for invalid HTTP statuses 
		//(such as “404 - File not found”).
		function onDownloadError(event:DownloadErrorEvent):void {
			//createWindow();
			displayWindowError(event.subErrorID, event.text);	
		}
		//start the download of the new version
		function startDownload():void {
			appUpdater.downloadUpdate();
			loadingSpinMc.visible = true;
			updateTxt.text = "Downloading...(0%)";
			skipBtn.visible = false;
			//createWindow();
			//windowContent.bar.visible = true;
			//windowContent.bar.setProgress(0, 100);
		}
		//listener for the ProgressEvent when a download of the new version is in progress
		function onDownloadProgress(event:ProgressEvent):void {
			//trace(event);
			var prct:Number = event.bytesLoaded / event.bytesTotal;
			var prctInt:int = Math.floor(prct*100);
			updateTxt.text = "Downloading...(" + prctInt+ "%)\n I will restart after the download.";
			//windowContent.bar.setProgress(event.bytesLoaded, event.bytesTotal);
		}
		//listener for the complete event for downloading the application
		//just close the window; the downloaded version will be automatically installed,
		//and then the application gets restarted
		function onDownloadComplete(event:UpdateEvent):void {
			//closeWindow();
			loadingSpinMc.visible = false;
			updateTxt.text = "Updated! I need to restart...";
			
			setNameOfDynamicBtn(skipBtn, "Restart");
			
			//CallbackTimerEffect.addWaitCallFctToActor(this, closeWindow, 3000);
			
			
		}
		//sets the state of the window in error display mode
		function displayWindowError(errorId:int, errorText:String):void {
			loadingSpinMc.visible = false;
			UIPopUp.createOkOnly("Oops, something went wrong with the update.\n(" + errorText + ")", new Callback(onSkip, this, null));
			/*windowContent.title = "Error";
			windowContent.enableDescription = true;
			windowContent.description = "Error ID: " + errorId + ". " + errorText;
			windowContent.buttonLeft.visible = false;
			windowContent.buttonRight.label = "Close";
			windowContent.bar.visible = false;
			addEventToButton(windowContent.buttonRight, MouseEvent.CLICK, closeWindow);*/
		}
		
		//close the window
		function closeWindow():void {
			onSkip();
		}
		
		

		private function onSkip() : void {
			EffectFlashColorFadeIn.create(0, 15, new Callback(toMenu, this, null));
			if(appUpdater) {
				appUpdater.cancelUpdate();
			}
		}
		
		private function toMenu():void {
			destroy();
			new UI_MainMenu();
			var fx:EffectFlashColor = EffectFlashColor.create(0, 5);
			fx.start();
		}
		
		public function get skipBtn() : MovieClip { return visual.getChildByName("skipBtn") as MovieClip;}
		public function get updateTxt() : TextField { return visual.getChildByName("updateTxt") as TextField;}
		public function get loadingSpinMc() : MovieClip { return visual.getChildByName("loadingSpinMc") as MovieClip;}
	}
}
