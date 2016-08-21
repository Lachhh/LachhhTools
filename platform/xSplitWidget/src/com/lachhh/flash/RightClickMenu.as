package com.lachhh.flash {
	import com.lachhh.flash.debug.DebugScreen;
	import com.lachhh.io.Callback;

	import flash.display.NativeMenu;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;

	// import com.lachhh.flash.debug.DebugScreen;
	/**
	 * @author LachhhSSD
	 */
	public class RightClickMenu {
		static private var _ciDebug:ContextMenuItemWithCallback ;
		static private var _ciBerzerkStudio:ContextMenuItemWithCallback ;
		static private var _contextMenuItems:Array = new Array() ;
		static private var _sponsorContextMenuItem : ContextMenuItemWithCallback;
		private static var _debugScreen : DebugScreen;
		private static var _sprite: Sprite;
		private static var _added:Boolean = false;
		
		private static var _menusShown:ContextMenu ;
		private static var _menusHidden:ContextMenu ;
		
		
		
		
		static public function addRightClickMenu(sprite:Sprite):void {
			_ciBerzerkStudio = new ContextMenuItemWithCallback("Developed by Berzerk Studio", new Callback(onBerzerkStudio, RightClickMenu, null));
			_ciDebug = new ContextMenuItemWithCallback("Show Lachhh debug",   new Callback(OnDebug, RightClickMenu, null));
			
			_menusHidden = new ContextMenu();
			_menusHidden.hideBuiltInItems();

			_menusShown = new ContextMenu();
			
			_sprite = sprite;
			_sprite.contextMenu = _menusHidden;
		}
		
		static public function addAllContextMenuItem():void {
			if(_added) return ;
			_sprite.contextMenu = _menusShown;
			_added = true;
		}
		
		static public function removeContextMenuItem():void {
			_sprite.contextMenu = _menusHidden;
			_added = false;
			_contextMenuItems = new Array() ;
		}
		
		static private function OnDebug():void {
		
		}
		
		static private function onBerzerkStudio():void {
			navigateToURL(new URLRequest("http://www.berzerkstudio.com"), "_blank");
		}
		
	}
}

import com.lachhh.io.Callback;

import flash.display.NativeMenuItem;
import flash.events.Event;
class ContextMenuItemWithCallback {
	private var _contextMenuItem:NativeMenuItem ;
	private var _callback:Callback ;

	public function ContextMenuItemWithCallback(caption:String, callback:Callback) {
	
	}
	
	private function onClick(e:Event):void {
		_callback.call();
	}
	
	public function get contextMenuItem():NativeMenuItem {
		return _contextMenuItem;
	}
}