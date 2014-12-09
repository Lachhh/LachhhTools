package com.giveawaytool.effect {
	import flash.display.DisplayObject;
	import com.lachhh.lachhhengine.MyMath;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class EffectSquash extends ActorComponent {
		public var rot:Number = 0;
		public var speedRot:Number = 30;

		public var xScaleMax:Number = 0.1;
		public var yScaleMax:Number = -0.1;
		public var numRevolution:int = -1;
		private var scaleXApplied:Number = 0;
		private var scaleYApplied:Number = 0;
		

		override public function start() : void {
			super.start();
			applyChanges();
		}
		
		override public function update() : void {
			super.update();
			
			cancelPreviousChanges();
			applyChanges();
			calculateNextChanges();
		}
		
		private function calculateNextChanges():void {
			rot += speedRot;
			if(rot > 360) {
				rot -= 360;
				checkToDestroyAfterRevolution();
			}
			if(rot < 0) rot += 360;
		}
		
		private function checkToDestroyAfterRevolution():void {
			if(numRevolution == -1) return ;
			numRevolution--;
			if(numRevolution <= 0) {
				destroyAndRemoveFromActor();
			}
		}
		
		private function applyChanges():void {
			scaleXApplied = MyMath.mySin(rot)*xScaleMax;
			scaleYApplied = MyMath.mySin(rot)*yScaleMax;
			if(actor.renderComponent.animView.scaleX > 0) {
				actor.renderComponent.animView.scaleX += scaleXApplied;
				actor.renderComponent.animView.scaleY += scaleYApplied;
			} else {
				actor.renderComponent.animView.scaleX -= scaleXApplied;
				actor.renderComponent.animView.scaleY += scaleYApplied;
			}
				
		}
		
		private function cancelPreviousChanges():void {
			if(actor.renderComponent.animView.scaleX > 0) {
				actor.renderComponent.animView.scaleX -= scaleXApplied;
				actor.renderComponent.animView.scaleY -= scaleYApplied;
			} else {
				actor.renderComponent.animView.scaleX += scaleXApplied;
				actor.renderComponent.animView.scaleY -= scaleYApplied;
			}
		}
		
		override public function destroy() : void {
			super.destroy();
			cancelPreviousChanges();	
		}
		
		static public function addToActor(actor:Actor):EffectSquash {
			var result:EffectSquash = new EffectSquash();
			actor.addComponent(result);
			return result;
		}
	}
}
