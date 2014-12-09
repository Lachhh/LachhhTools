package com.giveawaytool {
	import com.lachhh.flash.EmptyMainGame;
	import com.lachhh.flash.RightClickMenu;
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.MyMath;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.ui.MetaCallbackOnClickUI;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	/**
	 * @author LachhhSSD
	 */
	public class DefaultMainGame extends EmptyMainGame {
		static public var UI_CONTAINER_ABOVE_NO_CLICK:DisplayObjectContainer;
		static public var UI_CONTAINER_ABOVE:DisplayObjectContainer;
		static public var UI_CONTAINER:DisplayObjectContainer;
		static public var UI_CONTAINER_BELOW:DisplayObjectContainer;
		
		static public var jukeBox:JukeBox = new JukeBox();
		
		public function DefaultMainGame() {
			
		}
		
		override public function init():void {
			MyMath.init();
			KeyManager.init(this);
			
			UI_CONTAINER_ABOVE_NO_CLICK = new Sprite();
			UI_CONTAINER_ABOVE = new Sprite();
			UI_CONTAINER = new Sprite();
			UI_CONTAINER_BELOW = new Sprite();
			UI_CONTAINER_ABOVE_NO_CLICK.mouseChildren = false;
			UI_CONTAINER_ABOVE_NO_CLICK.mouseEnabled = false;
			addChild(UI_CONTAINER_BELOW);
			addChild(UI_CONTAINER);
			addChild(UI_CONTAINER_ABOVE);
			addChild(UI_CONTAINER_ABOVE_NO_CLICK);
			
			addEventListener(Event.ENTER_FRAME, updateFlash);
			
			UIBase.defaultUIContainer = UI_CONTAINER ; 
			
			MetaCallbackOnClickUI.callbackOnClickForAllInstance = new Callback(AnimationFactory.createStaticUiFxImpact, AnimationFactory, null);
			
			RightClickMenu.addRightClickMenu(this);
			RightClickMenu.addAllContextMenuItem();
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		override public function updateFlash(e:Event):void {
			update();
		}
		
		override public function update():void {
			UIBase.manager.update();
			jukeBox.update();
			
		}
	}
}



