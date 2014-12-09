package com.lachhh.lachhhengine.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.RenderComponent;

	/**
	 * @author LachhhSSD
	 */
	public class UIEffect extends Actor {
		public function UIEffect() {
			super();
			UIBase.manager.add(this);
		}

		
		override public function start() : void {
			super.start();
			renderComponent.animView.addEndCallback(new Callback(destroy, this, null));
		}
		
		static public function createStaticUiFx(animId:int, x:int, y:int):UIEffect {
			var result:UIEffect = new UIEffect();
			result.renderComponent = RenderComponent.addToActor(result, UIBase.defaultUIContainer, animId);
			result.px = x;
			result.py = y;
			result.refresh();
			return result;
		}
		
		static public function createStaticUiFxOnMouseCursor(animId:int):UIEffect {
			return createStaticUiFx(animId, KeyManager.GetMousePos().x, KeyManager.GetMousePos().y);
		}
	}
}
