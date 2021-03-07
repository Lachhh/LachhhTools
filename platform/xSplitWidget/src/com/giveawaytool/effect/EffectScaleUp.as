package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.DisplayObject;

	/**
	 * @author Eel
	 */
	public class EffectScaleUp extends ActorComponent {
		
		public var displayObject:DisplayObject;
		
		public var scaleSpeed:Number = 0.1;
		
		public function EffectScaleUp() {
			super();
		}
		
		public override function start():void{
			super.start();
		}
		
		public override function update():void{
			super.update();
			
			displayObject.scaleX += scaleSpeed;
			displayObject.scaleY += scaleSpeed;
			
		}
		
		public static function addToActor(actor:Actor):EffectScaleUp{
			var result:EffectScaleUp = new EffectScaleUp();
			result.displayObject = actor.renderComponent.animView.anim;
			actor.addComponent(result);
			return result;
		}
		
		public static function addToActorWithSpecificDisplayObject(actor:Actor, displayObject:DisplayObject):EffectScaleUp{
			var result:EffectScaleUp = new EffectScaleUp();
			result.displayObject = displayObject;
			actor.addComponent(result);
			return result;
		}
	}
}