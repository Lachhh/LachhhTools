package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.DisplayObject;

	/**
	 * @author LachhhSSD
	 */
	public class EffectScaleBackTo1 extends ActorComponent {
		public var displayObj:DisplayObject;		
		public var scaleX:Number;
		public var scaleY:Number;
		public var ease:Number = 0.3;
		public var threshold:Number = 0.1;
		
		override public function start() : void {
			super.start();
			displayObj.scaleX = scaleX;
			displayObj.scaleY = scaleY;
		}
		
		override public function update() : void {
			super.update();
			displayObj.scaleX += (1-displayObj.scaleX)*ease;
			displayObj.scaleY += (1-displayObj.scaleY)*ease;
			
			if(Math.abs(displayObj.scaleX-1) <= 0.01 && Math.abs(displayObj.scaleY-1) <= threshold) {
				destroyAndRemoveFromActor();
			} 
		}
		
		
		override public function destroy() : void {
			super.destroy();
			displayObj.scaleX = 1;
			displayObj.scaleY = 1;
		}
		
		static public function addToActor(actor:Actor, scaleX:Number, scaleY:Number):EffectScaleBackTo1 {
			var result:EffectScaleBackTo1 = new EffectScaleBackTo1();
			result.displayObj = actor.renderComponent.animView.anim;
			result.scaleX = scaleX;
			result.scaleY = scaleY;
			  
			actor.addComponent(result);
			return result;
		}
		
		static public function addToActorWithSpecificMc(actor:Actor, displayObject:DisplayObject, scaleX:Number, scaleY:Number):EffectScaleBackTo1 {
			var result:EffectScaleBackTo1 = addToActor(actor, scaleX, scaleY);
			result.displayObj = displayObject;
			
			return result;
		}
	}
}
