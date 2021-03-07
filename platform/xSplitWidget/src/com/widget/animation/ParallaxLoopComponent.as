package com.giveawaytool.animation {
	import com.lachhh.ResolutionManager;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.components.RenderComponent;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author LachhhSSD
	 */
	public class ParallaxLoopComponent extends ActorComponent {		
		
		private var _animViews:Vector.<FlashAnimationView>;
		public var widthPerPart:Number = 600;
		public var widthToCover:Number = ResolutionManager.getGameWidth();
		public var animId:int = -1;
		public var speed:Number = 1;
		public var padding:Number = 0;
		
		public var minY:int = -99999999;
		public var maxY:int = 99999999;
		
		public var parentVisual:DisplayObjectContainer;
		
		
		public function ParallaxLoopComponent(pParentVisual:DisplayObjectContainer) {
			super();
			parentVisual = pParentVisual;	
			_animViews = new Vector.<FlashAnimationView>();
			speed = 0.75;
		}

		override public function refresh() : void {
			super.refresh();
			checkToCoverWidth();
			
			for (var i : int = 0; i < _animViews.length; i++) {
				var animView:FlashAnimationView = _animViews[i];
				animView.x = actor.px + i*widthPerPart ;
				animView.y = actor.py ;
				animView.setAnim(animId);
				
				animView.addChildOnNewParent(parentVisual);
				animView.refresh();
			}
		}
		
		public function setAsBmp():void {
			if(animId == -1) return ;
			for (var i : int = 0; i < _animViews.length; i++) {
				var animView:FlashAnimationView = _animViews[i];
				animView.anim.cacheAsBitmap = true;
			}
		}
		
		override public function update() : void {
			super.update();			
			var screenWidth:int = CameraFlash.mainCamera.boundsFOV.width;
			var screenHeight:int = CameraFlash.mainCamera.boundsFOV.height;
			
			var camX:int = (CameraFlash.mainCamera.px*speed-screenWidth * 0.5)- actor.px;
			var camY:int = (CameraFlash.mainCamera.py*speed-screenHeight * 0.5);
			
			var gapX : int = -(camX % widthPerPart) ;
			var gapY : int = -camY + actor.py;
			if(gapX > 0) gapX -= widthPerPart; 
			for (var i : int = 0;i < _animViews.length; i++) {
				var animView:FlashAnimationView = _animViews[i] ;
				animView.x = gapX+CameraFlash.mainCamera.boundsFOV.x;
				animView.y = Math.min(maxY, Math.max(minY, gapY+CameraFlash.mainCamera.boundsFOV.y));
				animView.update();
				gapX += (widthPerPart + padding); 
			}
		}
		
		private function checkToCoverWidth():void {
			var widthCovered:int = _animViews.length * widthPerPart;
			while(widthCovered < widthToCover+widthPerPart) {
				var animView:FlashAnimationView = new FlashAnimationView(parentVisual);
				_animViews.push(animView);
				widthCovered = _animViews.length * widthPerPart; 
			}
		}
		
		override public function destroy() : void {
			super.destroy();
			destroyAnimViews();
		}
		
		
		private function destroyAnimViews():void {
			while(_animViews.length > 0) {
				var animView:FlashAnimationView = _animViews.shift();
				animView.destroy();
			}
		}

		
		
		static public function addToActor(actor : Actor, widthPerPart:int, parentVisual:DisplayObjectContainer, animId:int):ParallaxLoopComponent {
			var result:ParallaxLoopComponent = new ParallaxLoopComponent(parentVisual);
			actor.addComponent(result);
			result.widthPerPart = widthPerPart;
			result.animId = animId;
			result.refresh();
			
			return result;
		}
	}
}
