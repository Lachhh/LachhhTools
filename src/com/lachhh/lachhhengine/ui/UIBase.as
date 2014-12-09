package com.lachhh.lachhhengine.ui {
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.ui.EffectShakeRotateUI;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ActorObjectManager;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.RenderComponent;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * @author LachhhSSD
	 */
	public class UIBase extends Actor {
		static public var manager:ActorObjectManager = new ActorObjectManager();
		static public var defaultUIContainer:DisplayObjectContainer ;
		
		public var visual:MovieClip;
		public var inputEnabled:Boolean; 
		
		
		private var metaCallbacks:Vector.<MetaCallbackOnClickUI> = new Vector.<MetaCallbackOnClickUI>();
		
		public function UIBase(visualId:int) {
			super();
			manager.debugName = "Screens";
			manager.add(this);
			
			renderComponent = RenderComponent.addToActor(this,  defaultUIContainer, visualId);
			visual = renderComponent.animView.anim;
			inputEnabled = true;
		}
		
		override public function destroy() : void {
			super.destroy();
			enableAllClicks(false);
		}
		
		
		public function registerEventWithCallback(pVisual:DisplayObject, eventType:String, fctOnEvent:Callback):MetaCallbackOnClickUI {
			var metaClick:MetaCallbackOnClickUI = new MetaCallbackOnClickUI(pVisual, eventType, fctOnEvent);
			metaCallbacks.push(metaClick);
			return metaClick;
		}
		
		public function registerEvent(pVisual:DisplayObject, eventType:String, fctOnEvent:Function):MetaCallbackOnClickUI {
			return registerEventWithCallback(pVisual, eventType, new Callback(fctOnEvent, null, null));
		}

		public function registerClick(pVisual:DisplayObject, fctOnClick:Function):MetaCallbackOnClickUI {
			return registerClickWithCallback(pVisual, new Callback(fctOnClick, null, null));
		}
		
		public function registerClickWithCallback(pVisual:DisplayObject, fctOnClick:Callback):MetaCallbackOnClickUI {
			return registerEventWithCallback(pVisual, MouseEvent.MOUSE_DOWN, fctOnClick);
		}
		
		public function enableAllClicks(b:Boolean):void {
			for (var i : int = 0; i < metaCallbacks.length; i++) {
				var metaClick:MetaCallbackOnClickUI = metaCallbacks[i];
				metaClick.enable(b);
			}
			inputEnabled = b;
		}
		
		public function removeClickFromVisual(visual:DisplayObject):void {
			for (var i : int = 0; i < metaCallbacks.length; i++) {
				var metaClick:MetaCallbackOnClickUI = metaCallbacks[i];
				if(metaClick.visual == visual) {
					metaCallbacks.splice(i, 1);
					metaClick.enable(false);
					i--;
				}
			}
		}
		
		
		public function doBtnPressAnim(btn:MovieClip):void {
			EffectFadeOut.addToActorWithSpecificMc(this, btn, 5, 0xFFFFFF);
			EffectShakeRotateUI.addToActor(this, btn, 15);
		}
		
		public function setNameOfDynamicBtn(btn:MovieClip, name:String):void {
			var tf:TextField = getTextFieldOfDynamicBtn(btn);
			tf.text = name;
		}
		
		public function getTextFieldOfDynamicBtn(btn:MovieClip):TextField {
			return btn.getChildByName("txt") as TextField;
		}
	}
}
