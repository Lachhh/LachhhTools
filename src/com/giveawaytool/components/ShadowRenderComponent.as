package com.giveawaytool.components {
	import com.lachhh.lachhhengine.camera.CameraFlashContainers;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	/**
	 * @author LachhhSSD
	 */
	public class ShadowRenderComponent extends RenderComponent {
		public var animShadowView:FlashAnimationView;
		public var shadowOffset:Point = new Point(4,4);		 
		public function ShadowRenderComponent(parentVisual : DisplayObjectContainer) {
			super(parentVisual);
			animShadowView = new FlashAnimationView(CameraFlashContainers.instance.backFxVisual);
		}
		
		
		override public function start() : void {
			super.start();
			animShadowView.x = actor.px;
			animShadowView.y = actor.py;
			animShadowView.update();
		}

		override public function setAnim(animId : int) : void {
			super.setAnim(animId);
			animShadowView.setAnim(animId);
			if(animShadowView.hasAnim()) {
				Utils.SetColor2(animShadowView.anim, 0x000000);
			}
		}

		override public function update() : void {
			super.update();
			animShadowView.x = animView.x + shadowOffset.x;
			animShadowView.y = animView.y + shadowOffset.y;
			animShadowView.rotation = animView.rotation ;
			animShadowView.update();
		}

		override public function destroy() : void {
			super.destroy();
			animShadowView.destroy();
		}

		static public function addToActor(actor : Actor, parentVisual:DisplayObjectContainer, animId:int):RenderComponent {
			var result:ShadowRenderComponent = new ShadowRenderComponent(parentVisual);
			result.setAnim(animId);
			actor.addComponent(result);
			return result;
		}
	}
}
