package com.giveawaytool.components {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	/**
	 * @author LachhhSSD
	 */
	public class LifeComponent extends ActorComponent {
		public var maxHp:Number = 10;
		public var hp:Number = 10;
		public function LifeComponent() {
			super();
		}
		
		public function addHp(mod:Number):void {
			hp += mod;
			if(hp > maxHp) hp = maxHp;
		}
		
		public function damage(dmg:Number):void {
			addHp(-dmg);
		}
		
		public function heal(prct:Number):void {
			addHp(maxHp*prct);
		}
		
		public function healToMax():void {
			addHp(maxHp);
		}
		
		public function get isDead():Boolean {
			return hp <= 0;
		}
		
		public function get hpPrct():Number {
			if(maxHp == 0) return 0;
			return hp / maxHp;
		}
		
		static public function addToActor(actor: Actor, maxHp:int):LifeComponent {
			var result:LifeComponent = new LifeComponent();
			result.maxHp = maxHp;
			actor.addComponent(result);
			return result;
		}
	}
}
