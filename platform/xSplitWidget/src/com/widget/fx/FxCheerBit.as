package com.giveawaytool.fx {
	import com.lachhh.ResolutionManager;
	import com.giveawaytool.effect.LogicDestroyOutsideOfBounds;
	import com.giveawaytool.effect.LogicRotate;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class FxCheerBit extends Actor {
		public var amount : int ;
		static public var force: int = 6 ;
		static public var allBits: Vector.<FxCheerBit> = new Vector.<FxCheerBit>() ;

		public function FxCheerBit(pAmount:int) {
			super();
			amount = pAmount;
			UIBase.manager.add(this);
			
			renderComponent = RenderComponent.addToActor(this, UIBase.defaultUIContainer, getIdFromAmount());
			physicComponent = PhysicComponent.addToActor(this);
			physicComponent.vx = Math.random()*6-3;
			physicComponent.vy = Math.random()*-4;
			physicComponent.gravY = 0.1+Math.random()*0.05;
			
			var l : LogicRotate = LogicRotate.addToActor(this);
			l.rotateSpeed = 5 + Math.random() * 25;
			allBits.push(this);
			allBits.sort(sortOnValue);
		}
		
		private function sortOnValue(a:FxCheerBit, b:FxCheerBit):int {
			if(a.amount < b.amount) return -1;
			if(a.amount > b.amount) return 1;
			if(a.py < b.py) return -1;
			if(a.py > b.py) return 1;
			return 0;
			
		}
		
		public function setRandomVelocity():void {
			 physicComponent.vx = Math.random()*force-force*0.5;
			physicComponent.vy = Math.random()*-force;
			physicComponent.gravY = 0.1 + Math.random() * 0.05;
		}

		override public function update() : void {
			super.update();
			if(px < 0 && physicComponent.vx < 0) physicComponent.vx *= -0.5;
			if(px > ResolutionManager.getGameWidth() && physicComponent.vx > 0) physicComponent.vx *= -0.5;
			if(py < 0 && physicComponent.vy < 0) physicComponent.vy *= -0.5;
			if(py > ResolutionManager.getGameHeight()+100) {
				
				destroy();
			}
		}

		override public function destroy() : void {
			super.destroy();
			var i:int = allBits.indexOf(this);
			if(i != -1) allBits.splice(i, 1);
			allBits.sort(sortOnValue);
		}

		private function getIdFromAmount() : int {
			if(amount >= 10000) return AnimationFactory.ID_FX_CHEER_BIT10000;
			if(amount >= 5000) return AnimationFactory.ID_FX_CHEER_BIT5000;
			if(amount >= 1000) return AnimationFactory.ID_FX_CHEER_BIT1000;
			if(amount >= 100) return AnimationFactory.ID_FX_CHEER_BIT100;
			return AnimationFactory.ID_FX_CHEER_BIT1;			
		}
		
		static public function createOfAmount(amount:int, x:int, y:int):FxCheerBit {
			 var result:FxCheerBit = new FxCheerBit(amount);
			 result.px = x;
			 result.py = y;
			 result.setRandomVelocity();
			 return result; 
		}
		
		static public function createBitExplosion(amount:int, px:int, py:int):void {
			var num10000:int = Math.floor(amount/10000)*5;
			amount -= num10000*10000;
			var num5000:int = Math.floor(amount/5000)*5;
			amount -= num5000*5000;
			var num1000:int = Math.floor(amount/1000)*5;
			amount -= num1000*1000;
			var num100:int = Math.floor(amount/100)*5;
			amount -= num100*100;
			var num1:int = amount*5+5;
			var total:int = num10000+num5000+num1000 +num100+num1;
			if(total > 20) force = 4+Math.random()*2;
			if(total > 30) force = 6+Math.random()*2;
			if(total > 40) force = 8+Math.random()*2;
			if(total > 50) force = 10+Math.random()*2;
			
			
			
			var i : int = 0;
			for (i = 0; (i < num10000) && (i < 25); i++) FxCheerBit.createOfAmount(10000, px, py);
			for (i = 0; (i < num5000) && (i < 25); i++) FxCheerBit.createOfAmount(5000, px, py);
			for (i = 0; (i < num1000) && (i < 25); i++) FxCheerBit.createOfAmount(1000, px, py);
			for (i = 0; (i < num100) && (i < 25) ; i++) FxCheerBit.createOfAmount(100, px, py);
			for (i = 0; (i < num1) && (i < 25); i++) FxCheerBit.createOfAmount(1, px, py);
		}

		static public function setRandomForce() : void {
			//force = 3+Math.random()*3;
		}
	}
}
