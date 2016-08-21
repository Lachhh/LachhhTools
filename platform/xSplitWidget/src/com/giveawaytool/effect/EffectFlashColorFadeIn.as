package com.giveawaytool.effect {
	import com.giveawaytool.MainGame;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.utils.Utils;

	import flash.display.Sprite;

	/**
	 * @author Lachhh
	 */
	public class EffectFlashColorFadeIn extends ActorComponent {
		public var fadeOutTime:Number = 60;
		public var fadeOutTimeMax:Number = 60;
		public var color:int = 0xFFFFFF;
		public var callback:Callback;
		
		private var _sprite:Sprite ;
		
		public function EffectFlashColorFadeIn() {
			super();
			_sprite = new Sprite();
		}
		
		override public function start() : void {
			super.start();
			fadeOutTimeMax = fadeOutTime;
			_sprite.graphics.clear();
			_sprite.graphics.beginFill(color, 1);
			_sprite.graphics.drawRect(-200,-200, 2000, 1200);
			_sprite.graphics.endFill();
			_sprite.alpha = 0;
			MainGame.instance.addChild(_sprite);
		}
		
		override public function update() : void {
			super.update();
			
			fadeOutTime -= GameSpeed.getSpeed();
			
			_sprite.alpha = 1-(fadeOutTime / fadeOutTimeMax);
			if(fadeOutTime <= 0) {
				if(callback) callback.call();
				destroyAndRemoveFromActor();
			}	
			
			//blinkingTime -= SK_Game.instance.speedManager.GetSpeed();
			//if(blinkingTime <= 0) {
				
			//}
		}

		
		override public function destroy() : void {
			super.destroy();
			Utils.LazyRemoveFromParent(_sprite);
			_sprite = null;
			
		}

		static public function create(color:uint, fadeOutTime:int, c:Callback):EffectFlashColorFadeIn {
			var result:EffectFlashColorFadeIn = new EffectFlashColorFadeIn();
			result.fadeOutTime = fadeOutTime;
			result.color = color;
			result.callback = c;
			MainGame.dummyActor.addComponent(result);
			return result;
		}
	}
}
