package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author Lachhh
	 */
	public class EffectBlinking extends ActorComponent {
		public var blinkingTime:Number = 60;
		public var blinkingDelay:Number = 2;
		public var color:int = 0xFFFFFF;
		public var visualToBlink:DisplayObject ;
		public var useGameSpeed:Boolean = true;
		
		private var _blinkingDelayWait:Number;
		private var _colorApplied:Boolean;
		
		
		
		public function EffectBlinking() {
			super();
			_colorApplied = false;
			_blinkingDelayWait = blinkingDelay;
		}
		
		override public function update() : void {
			super.update();
			
			_blinkingDelayWait -= (useGameSpeed ? GameSpeed.getSpeed() : 1);
			if(_blinkingDelayWait <= 0) {
				_blinkingDelayWait = blinkingDelay;
				_colorApplied = !_colorApplied; 	
				if(_colorApplied) {
					Utils.SetColor2(visualToBlink, color);
				} else {
					Utils.SetColor(visualToBlink);
				}
			}	
			
			blinkingTime -= (useGameSpeed ? GameSpeed.getSpeed() : 1);
			if(blinkingTime <= 0) {
				Utils.SetColor(visualToBlink);
				destroyAndRemoveFromActor();
			}
		}
		
		
		override public function destroy() : void {
			super.destroy();
			Utils.SetColor(visualToBlink);
		}

		
		
		static public function addToActor(actor:Actor, blinkingTime:int, color:uint):EffectBlinking {
			var result:EffectBlinking = new EffectBlinking();
			result.blinkingTime = blinkingTime;
			result.color = color;
			result.visualToBlink = actor.renderComponent.animView.anim;
			actor.addComponent(result);
			
			return result;
		}
		
		static public function addToActorWithSpecificMc(actor:Actor, displayObject:DisplayObject, blinkingTime:int, color:uint):EffectBlinking {
			var result:EffectBlinking = addToActor(actor, blinkingTime, color);
			result.visualToBlink = displayObject;
			
			return result;
		}
		
	}
}
