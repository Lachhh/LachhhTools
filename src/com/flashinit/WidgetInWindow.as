package com.flashinit {
	import flash.desktop.NativeApplication;
	import flash.display.Loader;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	/**
	 * @author simon
	 */
	public class WidgetInWindow {
		private var mainWindow : NativeWindow;
		private var newWindow : NativeWindow;
		private var aLoader : Loader;

		public function WidgetInWindow() {
			mainWindow = NativeApplication.nativeApplication.activeWindow;
			randomTestLol();
		}
		
		private function randomTestLol():void {
			var windowOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			windowOptions.systemChrome = NativeWindowSystemChrome.NONE;
			windowOptions.renderMode = NativeWindowRenderMode.GPU;
			windowOptions.transparent = false;
			/*windowOptions.systemChrome = NativeWindowSystemChrome.NONE;
			windowOptions.renderMode = NativeWindowRenderMode.DIRECT;
			windowOptions.transparent = true;*/
			
			windowOptions.resizable = true;
			windowOptions.maximizable = false;
			windowOptions.minimizable = true;
			//windowOptions.owner = mainWindow;
			
			
			
			newWindow = new NativeWindow(windowOptions);
			newWindow.activate();
			newWindow.bounds = new Rectangle(0,0, 1280, 720);
			newWindow.title = "LachhhTools OBS ALERTS";
			newWindow.orderInBackOf(mainWindow); 
			
			newWindow.activate();
			loadSwf(null);
			//newWindow.stage.addChild(new ReleaseDonationInit());
			
			
			var swfStage:Stage = newWindow.stage; 
			swfStage.scaleMode = StageScaleMode.NO_SCALE; 
			swfStage.align = StageAlign.TOP_LEFT; 

		}
		
		
		private function loadSwf(event : Event) : void {
			aLoader = new Loader();
			var lc:LoaderContext = new LoaderContext(false, new ApplicationDomain(null)); 
			lc.allowCodeImport = true;
			lc.allowLoadBytesCodeExecution = true;
			
			newWindow.stage.addChild(aLoader);
			// Load SWF as usual:
			aLoader.load(new URLRequest("lachhhtools_widget.swf"), lc);
			aLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			
			try {Security.allowDomain("*");}catch (e) { };
		}

		private function onComplete(event : Event) : void {
			
			newWindow.stage.frameRate = 60;
			newWindow.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//newWindow.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			//newWindow.stage.scaleMode = StageScaleMode.SHOW_ALL;
			
		}

		private function onEnterFrame(event : Event) : void {
			//newWindow.activate()
			
			checkIfHasBeenClosed();
			refresh(); 
		}
		
		private function checkIfHasBeenClosed() : void {
			if(mainWindow == null) return;
			if (!mainWindow.closed) return;
			destroy();
		}

		private function destroy() : void {
			if(newWindow == null) return;
			newWindow.close();
			newWindow = null;
			aLoader.unloadAndStop();
			aLoader = null;
		}

		 public function refresh() : void {
			if(newWindow == null) return;
			if(newWindow.closed) return;
			
			var activeWindow : NativeWindow = mainWindow;
			if(activeWindow.closed) return;
			newWindow.orderInBackOf(mainWindow);
			newWindow.x = activeWindow.x +4;
			newWindow.y = activeWindow.y +1;
		}
	}
}