package com.lachhh.flash {
	import com.lachhh.io.Callback;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Administrator
	 */
	dynamic public class Initializer extends MovieClip {
		static public const URL_SITELOCK_FGL:String = "flashgamelicense.com";
		static public const URL_SITELOCK_BERZERK:String = "berzerkstudio.com";
		static public const URL_SITELOCK_BERZERK_LAND:String = "berzerk-land.com";
		
		private var _back:MovieClip;
		public var useSiteLock:Boolean = true;
		public var canBePlayedOffline:Boolean = true;
		public var urlsSiteLocks:Array = [];
		public var preloader:IPreloader;
		
		public function Initializer() {
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}

		private function update(e:Event):void {
			if(this.loaderInfo == null || this.loaderInfo.url == null || !canStart || stage == null) return ;
			
			removeEventListener(Event.ENTER_FRAME, update);			
			
			init();			
		}
		
		protected function init():void {
			if(canPlay) {
				preloader.callback = new Callback(preloaderEnded, this, []);
				addChild(preloader.visual);
				preloader.init();	
			} 
		}
		
		protected function get canPlay():Boolean {
			var sites:Array = urlsSiteLocks;
			sites.push(URL_SITELOCK_BERZERK);
			sites.push(URL_SITELOCK_BERZERK_LAND);
			sites.push(URL_SITELOCK_FGL);
			return (!useSiteLock || SiteLocking.isInSites(root, sites)) || (canBePlayedOffline && SiteLocking.isInSites(root, [""]));
		}

		
		
		private function onClick(e:Event):void {
			navigateToURL(new URLRequest("http://flashgamedistribution.com/profile/BerzerkStudio"), "_blank");
		}
				
		protected function getMainClassString():String {
			var str:String = getQualifiedClassName(this);
			var params:Array = str.split(".");
			var thePackage:String = "com.monstersmash.MainGame";
			return thePackage;	
		} //com.berzerkstudio.starterkit::Main
		
		private function preloaderEnded():void {			
			removeChild(preloader.visual);
			preloader = null;
			StartMain();
		}
		
		protected function StartMain():void {
			gotoAndStop(2);
			var mainClass:Class = Class(getDefinitionByName(getMainClassString()));
			if(mainClass) {
				var app:DisplayObject = new mainClass();
				addChild(app as DisplayObject);
				app["init"]();
			}
			if(_back) removeChild(_back);
			_back = null;
		}
		
		protected function get canStart():Boolean { return true; }
		
		protected function CreatePreloaderBack():MovieClip {
			return null;
		}
	}
}
