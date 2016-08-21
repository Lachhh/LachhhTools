package com.giveawaytool.effect {
	import com.lachhh.lachhhengine.MyMath;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	/**
	 * @author LachhhSSD
	 */
	public class EffectRotate extends ActorComponent {
		public var rotX:Number = 0;
		public var rotY:Number = 0;
		public var speedRotX:Number = 1;
		public var speedRotY:Number = 1;
		public var xDistance:Number = 30;
		public var yDistance:Number = 15;
		private var vxApplied:Number = 0;
		private var vyApplied:Number = 0;
		
		public function EffectRotate() {
			super();
		}

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
			rotX += speedRotX;
			rotY += speedRotY;
			if(rotX > 360) rotX -= 360;
			if(rotY > 360) rotY -= 360;
			if(rotX < 0) rotX += 360;
			if(rotY < 0) rotY += 360;
		}
		
		private function applyChanges():void {
			vxApplied = MyMath.myCos(rotX)*xDistance;
			vyApplied = MyMath.myCos(rotY)*yDistance;
			actor.px += vxApplied;
			actor.py += vyApplied;	
		}
		
		private function cancelPreviousChanges():void {
			actor.px -= vxApplied;
			actor.py -= vyApplied;
		}
		
		override public function destroy() : void {
			super.destroy();
			cancelPreviousChanges();	
		}
		
		static public function addToActor(actor:Actor):EffectRotate {
			var result:EffectRotate = new EffectRotate();
			actor.addComponent(result);
			return result;
		}
	}
}
