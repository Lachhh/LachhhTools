package com.giveawaytool.effect {
	import com.giveawaytool.MainGame;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.utils.Utils;

	import flash.display.Sprite;

	/**
	 * @author Lachhh
	 */
	public class EffectFlashColor extends ActorComponent {
		public var prctDelta:Number = 0.1;
		
		public var prct:Number = 0;
		public var color:int = 0xFFFFFF;
		
		private var _sprite:Sprite ;
		public var useGameSpeed:Boolean = true;
		public var callback:Callback;
		public var autoDestroy:Boolean = true;
		public function EffectFlashColor() {
			super();
			_sprite = new Sprite();
		}

		override public function start() : void {
			super.start();
			
			_sprite.graphics.clear();
			_sprite.graphics.beginFill(color, 1);
			_sprite.graphics.drawRect(-1000,-1000, 3000, 3000);
			_sprite.graphics.endFill();
			_sprite.alpha = prct;
			MainGame.instance.addChild(_sprite);
		}
		
		public function Init():void {
			
		}
		
		override public function update() : void {
			super.update();
			
			prct -= (useGameSpeed ? GameSpeed.getSpeed() : 1) *prctDelta;
			_sprite.alpha = prct;
			if(prct <= 0 || prct > 1) {
				if(callback) callback.call();
				if(autoDestroy) destroyAndRemoveFromActor();
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

		static public function create(color:uint, fadeOutTime:int):EffectFlashColor {
			var result:EffectFlashColor = new EffectFlashColor();
			result.prct = 1;
			result.prctDelta = 1/fadeOutTime;
			result.color = color;
			MainGame.dummyActor.addComponent(result);
			return result;
		}
		
		static public function create2(color:uint, fadeOutTime:int, prct:Number):EffectFlashColor {
			var result:EffectFlashColor = new EffectFlashColor();
			result.prct = 1;
			result.prctDelta = 1/fadeOutTime;
			result.color = color;
			result.prct = prct;
			result.start();
			MainGame.dummyActor.addComponent(result);
			return result;
		}
	}
}
