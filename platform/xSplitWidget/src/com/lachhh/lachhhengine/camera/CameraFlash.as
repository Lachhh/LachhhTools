package com.lachhh.lachhhengine.camera {
	import com.lachhh.ResolutionManager;
	import com.lachhh.flash.EmptyMainGame;
	import com.lachhh.flash.Screen;
	import com.lachhh.flash.debug.DebugDraw;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.actor.Actor;

	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * @author LachhhSSD
	 */
	public class CameraFlash extends CameraBase {
		static public var mainCamera:CameraFlash;
		public var gameVisualContainer:CameraFlashContainers ;
		public var visualStaticContainer:Sprite ;
		public var boundsFOV:Rectangle = new Rectangle();
		public var boundsMax:Rectangle = new Rectangle();
		public var debugDraw:DebugDraw;
		public var zoomScale:Number = 1;
		
		private var mouseInWorld:Point = new Point();
		
		static public var tempRect:Rectangle = new Rectangle();
		private var _main:EmptyMainGame;
		
		public function CameraFlash(main:EmptyMainGame) {
			super();
			_main = main;
			visualStaticContainer = new Sprite();
			
			gameVisualContainer = new CameraFlashContainers(new Sprite());
			mainCamera = this;
			
			
			
			boundsFOV.width = ResolutionManager.getGameWidth();
			boundsFOV.height = ResolutionManager.getGameHeight();
			boundsFOV.x = 0;
			boundsFOV.y = 0;
			
		}
		
		override public function start() : void {
			super.start();
			_main.addChildAt(gameVisualContainer.container, 0);
			_main.addChildAt(visualStaticContainer, 0);
			
			debugDraw = DebugDraw.addToActor(this, gameVisualContainer.debugVisual);
		}
		
		public function zoom(scale:Number):void {
			zoomScale = scale;
			boundsFOV.width = ResolutionManager.getGameWidth()/zoomScale;
			boundsFOV.height = ResolutionManager.getGameHeight()/zoomScale;
			gameVisualContainer.container.scaleX = scale;
			gameVisualContainer.container.scaleY = scale;
		}

		override public function update() : void {
			super.update();
			updateBounds();
			gameVisualContainer.container.x = -boundsFOV.x*zoomScale;
			gameVisualContainer.container.y = -boundsFOV.y*zoomScale;			
		}
		
		public function getMouseInWorld():Point {
			var mouseXFromCenter:Number = KeyManager.GetMousePos().x - (Screen.width*0.5);
			var mouseYFromCenter:Number = KeyManager.GetMousePos().y - (Screen.height*0.5);
			var dx:Number = (mouseXFromCenter) / (Screen.width / (boundsFOV.width+0.0));
			var dy:Number = (mouseYFromCenter) / (Screen.height / (boundsFOV.height+0.0));
			
			//Debug.Log(dx+"/"+ dy);
			mouseInWorld.x = px + dx ;
			mouseInWorld.y = py + dy ;
			return mouseInWorld;
		}
		
		public function getMouseInWorldFlash():Point {
			mouseInWorld.x = _main.mouseX + boundsFOV.x;
			mouseInWorld.y = _main.mouseY + boundsFOV.y;
			return mouseInWorld;
		}
		
		public function updateBounds():void {
			if(boundsMax.width > 0) { 
				px = Math.max(boundsMax.x+boundsFOV.width*.5, px);
				px = Math.min(boundsMax.right-boundsFOV.width*.5, px);
			} 
			
			if(boundsMax.height > 0) { 
				py = Math.max(boundsMax.y+boundsFOV.height*.5, py);
				py = Math.min(boundsMax.bottom-boundsFOV.height*.5, py);
			}
			
			boundsFOV.x = px - boundsFOV.width*0.5;
			boundsFOV.y = py - boundsFOV.height*0.5;
		}
		
		public function isInFieldOfVIew(actor:Actor, offsetX:int, offsetY:int):Boolean {
			var isInFOVHorizontally:Boolean = Math.abs(actor.px-px) < (boundsFOV.width*0.5)+offsetX;
			var isInFOVVertically:Boolean = Math.abs(actor.py-py) < boundsFOV.height*0.5+offsetY;
			return (isInFOVHorizontally && isInFOVVertically);
		}
		
		public function getRandomXInBounds():int {
			return Math.random()*boundsFOV.width+boundsFOV.x;
		}
		
		public function getRandomYInBounds():int {
			return Math.random()*boundsFOV.height+boundsFOV.y;
		}
		
		
		override public function destroy() : void {
			super.destroy();
			_main.removeChild(gameVisualContainer.container);
			_main.removeChild(visualStaticContainer);
		}
	}
}
