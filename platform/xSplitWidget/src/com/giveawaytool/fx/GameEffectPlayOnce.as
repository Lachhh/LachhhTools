package com.giveawaytool.fx {
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.components.RenderComponent;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author LachhhSSD
	 */
	public class GameEffectPlayOnce extends GameEffect {
		override public function start() : void {
			super.start();
			renderComponent.animView.addEndCallback(new Callback(destroy, this, null));
		}

		override public function update() : void {
			super.update();
			
		}
		
		static public function createStaticFx(visualContainer:DisplayObjectContainer, animId:int, x:int, y:int):GameEffectPlayOnce {
			var result:GameEffectPlayOnce = new GameEffectPlayOnce();
			result.renderComponent = RenderComponent.addToActor(result, visualContainer, animId);
			result.px = x;
			result.py = y;
			result.refresh();
			return result;
		}

	}
}
