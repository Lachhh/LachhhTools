package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.utils.Utils;

	/**
	 * @author Lachhh
	 */
	public class EffectFadeIn extends ActorComponent {
		public var prctDelta:Number = 0.1;
		public var color:int = 0xFFFFFF;
		
		public var prct:Number = 1;
		
		private var _r:Number = 0;
		private var _g:Number = 0;
		private var _b:Number = 0;
		
		public var relativeToGameSpeed:Boolean = true;
		
		
		public function EffectFadeIn(pFadeOutTime:int) {
			super();
			
			prctDelta = (1/pFadeOutTime);
			prct = 0;
			
			//Utils.SetColor(visual, _r, _g, _b, 0, _prct, _prct, _prct);
			
		}
		
		
		override public function start() : void {
			super.start();
			
			_r = (((color >> 16) & 0xFF)+0.0);//255;
			_g = (((color >> 8) & 0xFF)+0.0);//255;
			_b = (((color >> 0) & 0xFF)+0.0);//255;
			Utils.SetColor(actor.renderComponent.animView.anim, _r*prct, _g*prct, _b*prct);
		}
		
		override public function update() : void {
			super.update();
			
			prct += (relativeToGameSpeed ? GameSpeed.getSpeed() : 1) *prctDelta ;
			
			
			Utils.SetColor(actor.renderComponent.animView.anim, _r*prct, _g*prct, _b*prct);
			
			
			if(prct >= 1) {
				//Utils.SetColor(actor.renderComponent.animView.anim);
				destroyAndRemoveFromActor();
			}
		}


		static public function addToActor(actor:Actor, fadeOutTime:int, color:uint):EffectFadeIn {
			if(fadeOutTime <= 0) throw new Error("FadeoutTime Cannot be negative");
			var result:EffectFadeIn = new EffectFadeIn(fadeOutTime);
			result.color = color;
			actor.addComponent(result);
			return result;
		}
	}
}
