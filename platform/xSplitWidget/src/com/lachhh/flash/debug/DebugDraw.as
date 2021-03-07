package com.lachhh.flash.debug {
	import com.giveawaytool.physics.Circle;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.components.RenderComponent;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.ui.Keyboard;

	/**
	 * @author LachhhSSD
	 */
	public class DebugDraw extends RenderComponent {
		private var emptyAnim:MovieClip;
		public function DebugDraw(parentVisual : DisplayObjectContainer) {
			super(parentVisual);
			setAnim(AnimationFactory.EMPTY);
			emptyAnim = animView.anim as MovieClip;
			
			
		}

		override public function update() : void {
			super.update();
			emptyAnim.visible = KeyManager.IsKeyDown(Keyboard.HOME);
			emptyAnim.graphics.clear();
		}
		
		public function drawCircle(c:Circle):void {
			if(!canDraw) return ;
			emptyAnim.graphics.lineStyle(1, 0xFF0000, 0.5); 	
			emptyAnim.graphics.drawCircle(c.x-CameraFlash.mainCamera.px, c.y-CameraFlash.mainCamera.py, c.radius);
		}
		
		public function get canDraw():Boolean {
			return emptyAnim.visible;
		}
		
		static public function addToActor(actor: Actor, parentVisual:DisplayObjectContainer):DebugDraw {
			var result:DebugDraw = new DebugDraw(parentVisual);
			actor.addComponent(result);
			return result;
		}
	}
}
